import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductInformation extends StatefulWidget {
  @override
  _ProductInformationState createState() => _ProductInformationState();
}

class _ProductInformationState extends State<ProductInformation> {
  var _farmKey = GlobalKey<FormState>();
  String name;
  String price;
  String color;
  File _image;
  String imgpath;
  String _uploadedFileURL;
  Timestamp timestamp;

  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController colorController = new TextEditingController();
  final productRefernce = Firestore.instance.collection("products");

  @override
  Widget build(BuildContext context) {
  uploadFile();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _farmKey,
      body: Container(
          margin: EdgeInsets.only(top: 100, right: 20, bottom: 20.0, left: 20),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.camera_alt),
                                  title: Text(
                                    'Camera',
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.black),
                                  ),
                                  onTap: () {
                                    getImagefromCamera();
                                    Navigator.of(context).pop();
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ListTile(
                                  leading: Icon(Icons.gamepad),
                                  title: Text(
                                    'Gallery',
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.black),
                                  ),
                                  onTap: () {
                                    getImagefromGallery();
                                  },
                                )
                              ],
                            ));
                      });
                },
                child: _image != null
                    ? Image.file(
                        _image,
                        width: 250,
                        height: 250,
                      )
                    : Container(
                        height: 250,
                        width: 250,
                        child: Image(
                          image: AssetImage('assets/beds.jpg'),
                        ),
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Name',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Price',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
              SizedBox(
                height: 17.0,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Color',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: colorController,
                decoration: InputDecoration(
                    labelText: 'Color',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                  width: 330.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    //  color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(10.0),
                    //  color: Colors.blu,
                  ),
                  child: RaisedButton(
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 20.0, color: Colors.white70),
                      ),
                      elevation: 5.0,
                      onPressed: () {
                        uploadingData(imgpath,name, price, color,);

                      })),
            ],
          )),
    );
  }

  Future getImagefromCamera() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 20);
    setState(() {
      _image = image;
    });
  }

  Future getImagefromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future uploadFile() async {
    var date = DateTime.now().millisecondsSinceEpoch;
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('images/${date.toString()}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    }).catchError((error) {
      print(error);
    });
  }

  Future<void> uploadingData(
      String name, String price, String color, String imgpath) async {
    await Firestore.instance.collection("products").add({
      'name': nameController.text,
      'price': priceController.text,
      'color': colorController.text,
      'imgpath': _uploadedFileURL.toString(),
    }).catchError((errors) {
      print(errors);
    }).then((value) => {
          print('dataupdated'),
        });
  }

// Future<void> readData() async {
//  // DocumentSnapshot snapshot =
//    //   await Firestore.instance.collection('products').document('users').get();
//   await Firestore.instance.collection('products').document('users').get();
//       //print(snapshot.data['name']);

}
