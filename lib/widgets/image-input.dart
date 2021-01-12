import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:places_app/localization/localication-methods.dart';

class ImageInput extends StatefulWidget {

  final Function _onSelectedImage;

  ImageInput(this._onSelectedImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storeImage;

  Future<void> pickImage()async{
    final picker=ImagePicker();
    File image;
    final imageFile= await picker.getImage(source:ImageSource.camera,maxWidth: 600);
    if(imageFile==null){
      return;
    }
    image=File(imageFile.path);

    setState(() {
      _storeImage=image;
    });

    final appDir=await sysPath.getApplicationDocumentsDirectory();
    final fileName=path.basename(imageFile.path);
    final savedImage= await image.copy('${appDir.path}/$fileName');
    widget._onSelectedImage(savedImage);

  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 120,
          width: 150,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storeImage == null
              ? Text(
                  getTextTranslated(context, 'no_image'),
                  textAlign: TextAlign.center,
                )
              : Image.file(
                _storeImage,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: FlatButton.icon(
                onPressed: pickImage,
                icon: Icon(
                  Icons.camera_alt,
                  color: Theme.of(context).primaryColor,
                ),
                label: Text(
                  getTextTranslated(context, 'take_pic'),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )))
      ],
    );
  }
}
