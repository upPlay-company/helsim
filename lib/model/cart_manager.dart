import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:helsim/model/address.dart';
import 'package:helsim/model/cart_product.dart';
import 'package:helsim/model/product.dart';
import 'package:helsim/model/user.dart';
import 'package:helsim/model/user_manager.dart';
import 'package:helsim/services/cepaberto_services.dart';

class CartManager extends ChangeNotifier {

  List<CartProduct> items = [];

  User user;
  Address address;

  num productsPrice = 0.0;
  num deliveryPrice;

  num get totalPrice => productsPrice + (deliveryPrice ?? 0);

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  final Firestore firestore = Firestore.instance;

  void updateUser(UserManager userManager){
    user = userManager.user;
    productsPrice = 0.0;
    items.clear();
    removeAddress();

    if(user != null){
      _loadCartItems();
      _loadUserAddress();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user.cartReference.getDocuments();

    items = cartSnap.documents.map(
       (d) => CartProduct.fromDocument(d)..addListener(_onItemUpdate)
    ).toList();
  }

  Future<void> _loadUserAddress() async {
    if(user.address != null && await calculateDelivery(user.address.lat, user.address.long)){
       address = user.address;
       notifyListeners();
    }
  }

  void addToCard(Product product){
    try {
      final e = items.firstWhere((p) => p.stackable(product));
      e.increment();
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdate);
      items.add(cartProduct);
      user.cartReference.add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.documentID);
      _onItemUpdate();
    }
    notifyListeners();
  }

  void _onItemUpdate(){
    productsPrice = 0.0;

    for(int i = 0; i<items.length; i++){
      final cartProduct = items[i];

      if(cartProduct.quantity == 0){
        removeOfCart(cartProduct);
        i--;
        continue;
      }

      notifyListeners();

      productsPrice += cartProduct.totalPrice;

      _updateCartProduct(cartProduct);

    }
  }

  void _updateCartProduct(CartProduct cartProduct){
    if(cartProduct.id != null)
      user.cartReference.document(cartProduct.id).
      updateData(cartProduct.toCartItemMap());
  }

  void removeOfCart(CartProduct cartProduct){
    items.removeWhere((p) => p.id == cartProduct.id);
    user.cartReference.document(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdate);
    notifyListeners();
  }

  void clear(){
    for(final cartProduct in items){
      user.cartReference.document(cartProduct.id).delete();
    }
    items.clear();
    notifyListeners();
  }

  bool get isCartValid {
    for(final cartProduct in items){
      if(!cartProduct.hasStock) return false;
    }
    return true;
  }

  bool get isAddressValid => address != null && deliveryPrice != null;

  // PROCURANDO CEP

  Future<void> getAddress(String cep) async {
    loading = true;
    final cepAbertoService = CepAbertoService();

    try {
      final cepAbertoAddress = await cepAbertoService.getAddressFromCep(cep);

      if(cepAbertoAddress != null){
        address = Address(
          street: cepAbertoAddress.logradouro,
          district: cepAbertoAddress.bairro,
          zipCode: cepAbertoAddress.cep,
          city: cepAbertoAddress.cidade.nome,
          state: cepAbertoAddress.estado.sigla,
          lat: cepAbertoAddress.latitude,
          long: cepAbertoAddress.longitude
        );
      }

      loading = false;
    } catch (e) {
      loading = false;
      return Future.error('CEP Inválido');
    }
  }

  Future<void> setAddress(Address address) async {
    loading = true;
    this.address = address;
    
    if(await calculateDelivery(address.lat, address.long)){
      user.setAddress(address);
      loading = false;
    } else {
      loading = false;
      return Future.error('Endereço fora do raio de entrega :(');
    }
  }

  void removeAddress(){
    deliveryPrice = null;
    address = null;
    notifyListeners();
  }

  Future<bool> calculateDelivery(double lat, double long) async {
    final DocumentSnapshot doc = await firestore.document('aux/delivery').get();

    final latStore = doc.data['lat'] as double;
    final longStore = doc.data['long'] as double;

    final maxkm = doc.data['maxkm'] as num;
    final base = doc.data['base'] as num;
    final km = doc.data['km'] as num;

    double dis =
      await Geolocator().distanceBetween(latStore, longStore, lat, long);

    dis /= 1000.0;

    if(dis > maxkm){
      return false;
    }

    deliveryPrice = base + dis * km;
    return true;

  }

}