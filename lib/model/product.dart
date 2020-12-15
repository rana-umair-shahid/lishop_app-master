import 'package:flutter/material.dart';

class Product {
  String imgpath;
  String name;
  int price;
  String description;

  Product({String imgpath, String name,int price,String description}) {
    this.imgpath = imgpath;
    this.name = name;
    this.price = price;
    this.description = description;
  }

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    return Product(
      imgpath: parsedJson["imgpath"],
      name: parsedJson["name"],
      price: parsedJson["price"],
      description: parsedJson['description'],
    );
  }
}
