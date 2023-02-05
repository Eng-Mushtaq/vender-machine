import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vender_machine/Model/machineProduct.dart';
// import 'package:vender_machine/Model/machineModel.dart';
// import 'package:vender_machine/Model/machineModel.dart';

// import '../models/http_exception.dart';
import '../Model/model.dart';
import './product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [];
  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<MachineModel> machines = [];
  MachineModel? machine;
  List<MachineProduct> products = [];
  List<MachineProduct> cartList = [];

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }
  MachineHome? machineHome;
  // List<MachineHome> machines = [];
  Future<void> fetchAndSetProducts() async {
    const url =
        'https://vender-machine-3ecd6-default-rtdb.firebaseio.com/machines.json';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        print('no data found');
        return;
      }

      print(' the exctracted data is :${machineHome}');

      extractedData.forEach((prodData) {
        // print(prodData);
        machines.add(MachineModel.fromJson(prodData));
      });

      // machines = extractedData;
      print('MMMMMMMMMMMMMMMMMMMMMM');
      // print(machine!.name);
      print('MMMMMMMMMMMMMMMMMMMMMM');

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  void currentMachine(String? qrCode) {
    machine = machines.firstWhere((element) => element.qrCode == qrCode);
    notifyListeners();
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = 'https://flutter-update.firebaseio.com/products/$id.json';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://flutter-update.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      // throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
