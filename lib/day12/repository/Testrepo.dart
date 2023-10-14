import 'dart:convert';

import 'package:hundred_day/day12/data/prodcutsModel.dart';
import 'package:http/http.dart' as http;

abstract class TestingRepo {
  Future<int> getData();
  Future<List<Products>> getProducts();
}

class TestRepo extends TestingRepo {
  @override
  Future<int> getData() async {
    Future.delayed(const Duration(milliseconds: 2), () {});
    return 1;
  }

  @override
  Future<List<Products>> getProducts() async {
    // TODO: implement getProducts
    String uri = "https://fakestoreapi.com/products";
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      final products = jsonDecode(response.body);
      List<Products> productList = [];
      for (var product in products) {
        productList.add(Products.fromJson(product));
      }
      return productList;
    } else {
      throw Exception("Failed to load data from $uri");
    }
  }
}
