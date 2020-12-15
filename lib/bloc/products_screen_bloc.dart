import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lishop_app/model/product.dart';

class ProductsScreenBloc {
  var _productController = StreamController<List<Product>>();
  final productRefernce = Firestore.instance.collection("products");

  //Function to feed Data.
  StreamSink<List<Product>> get productSink => _productController.sink;

  //Stream to output the Data
  Stream<List<Product>> get productStream => _productController.stream;

  dispose() {
    //Dispose Stream to avoid memory leak.
    _productController?.close();
  }

  Future<void> readData() async {
    List<Product> products = [];

    QuerySnapshot result =
        await productRefernce.getDocuments().catchError((error) {
      print(error);
      return;
    });
    result.documents.forEach((element) {
      Product product = new Product.fromJson(element.data());
      products.add(product);
      print(product);
    });
    print(products);
    productSink.add(products);
  }
}
