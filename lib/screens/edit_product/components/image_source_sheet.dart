import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {

  ImageSourceSheet({this.onImageSelected});

  final Function(File) onImageSelected;

  final ImagePicker picker = ImagePicker();

  void editImage(String path) async {
    final File croppedFile = await ImageCropper.cropImage(
        sourcePath: path,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Editor de Imagem',
        toolbarColor: Colors.black,
        toolbarWidgetColor: Colors.white
        ),
      iosUiSettings: const IOSUiSettings(
        title: 'Editar Imagem',
        cancelButtonTitle: 'Cancelar',
        doneButtonTitle: 'Concluir',
      )
    );
    if(croppedFile != null){
      onImageSelected(croppedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid)
    return BottomSheet(
      onClosing: (){},
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FlatButton(
            onPressed: () async {
              final PickedFile file =
                await picker.getImage(source: ImageSource.camera);
              editImage(file.path);
            },
            child: const Text('Câmera'),
          ),
          FlatButton(
            onPressed: () async {
              final PickedFile file =
                await picker.getImage(source: ImageSource.gallery);
              editImage(file.path);
            },
            child: const Text('Galeria'),
          )
        ],
      ),
    );
    else
      return CupertinoActionSheet(
        title: const Text('Selecionar foto para o item'),
        cancelButton: CupertinoActionSheetAction(
            onPressed: Navigator.of(context).pop,
            child: const Text('Cancelar', style: TextStyle(color: Colors.red),),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text('Câmera', style: TextStyle(color: Colors.black),),
            onPressed: () async {
              final PickedFile file =
                  await picker.getImage(source: ImageSource.camera);
              editImage(file.path);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Galeria', style: TextStyle(color: Colors.black),),
            onPressed: () async {
              final PickedFile file =
                  await picker.getImage(source: ImageSource.gallery);
              editImage(file.path);
            },
          ),
        ],
      );
  }
}
