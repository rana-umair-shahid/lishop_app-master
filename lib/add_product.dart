import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lishop_app/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bloc/products_screen_bloc.dart';
import 'model/product.dart';

class data_list extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => data_listState();
}

class data_listState extends State<data_list> {
  final productRefernce = Firestore.instance.collection("products");
  List<Product> products = [];
  String _imageUrl;
  String _downloadUrl;
  ProductsScreenBloc _productsScreenBloc = ProductsScreenBloc();

  @override
  void initState() {
    super.initState();
    _productsScreenBloc.readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 30),
          ),
          FloatingActionButton(
            heroTag: 'shopping',
            backgroundColor: Colors.black,
            onPressed: () {},
            child: Icon(
              Icons.shopping_basket,
              size: 30.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 50.0,
          ),
          FloatingActionButton(
              heroTag: 'add',
              backgroundColor: Colors.black,
              child: Icon(Icons.add_circle),
              onPressed: () {})
        ],
      ),
      resizeToAvoidBottomPadding: false,
      // body: ListView(
      //   padding: EdgeInsets.only(left: 20, top: 100, right: 20, bottom: 20),
      body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(10.0),
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  // color: Colors.orange,
                  borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              )),
              margin: EdgeInsets.only(
                top: 100.0,
              ),
              child: Material(
                  elevation: 5.0,
                  // color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/search.png'),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              )),
                          width: 200,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Shop',
                style: TextStyle(fontSize: 20.0, color: Colors.black45),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '3 Seaters',
                style: TextStyle(fontSize: 30.0, color: Colors.black87),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: _productsScreenBloc.productStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Product> products = snapshot.data;
                }
                return GridView.builder(
                    padding: EdgeInsets.only(bottom: 50),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white70,
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: 30,
                                ),
                                width: 200,
                                height: 100,
                                child: products[index].imgpath != null
                                    ? Image.network(products[index].imgpath)
                                    : Container(
                                        height: 250,
                                        width: 250,
                                        child: Image(
                                          image: AssetImage('assets/beds.jpg'),
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 70),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${products[index].description}',
                                    ),
                                    Text(
                                      products[index].name,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17),
                                    ),
                                    Text(
                                      '${products[index].price}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                            ]),
                      );
                    });
              },
            )
            // else Center(
            //   child: CircularProgressIndicator(
            //     backgroundColor: Colors.white70,
            //   ),
            // ),
          ]),
    );
  }
}
