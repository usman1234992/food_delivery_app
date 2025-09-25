import 'package:flutter/material.dart';
import 'package:food_delivery_2/Model/cart_model.dart';
import 'package:food_delivery_2/Model/product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];

  List<CartModel> get carts => _carts;

  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  // 🟠 Add Product to Cart
  void addCart(MyProductModel productModel) {
    int index = _carts.indexWhere((element) =>
        element.productModel.name == productModel.name); // check by name

    if (index != -1) {
      _carts[index].quantity += 1;
    } else {
      _carts.add(CartModel(productModel: productModel, quantity: 1));
    }
    notifyListeners();
  }

  // 🟠 Increase Quantity
  void addQuantity(MyProductModel product) {
    int index = _carts
        .indexWhere((element) => element.productModel.name == product.name);
    if (index != -1) {
      _carts[index].quantity += 1;
      notifyListeners();
    }
  }

  // 🟠 Decrease Quantity
  void reduceQuantity(MyProductModel product) {
    int index = _carts
        .indexWhere((element) => element.productModel.name == product.name);
    if (index != -1 && _carts[index].quantity > 1) {
      _carts[index].quantity -= 1;
    } else if (index != -1 && _carts[index].quantity == 1) {
      _carts.removeAt(index); // remove if qty reaches 0
    }
    notifyListeners();
  }

  // 🟠 Check if Product Exists
  bool productExist(MyProductModel productModel) {
    return _carts
            .indexWhere((element) =>
                element.productModel.name == productModel.name) !=
        -1;
  }

  // 🟠 Total Price
  double totalCart() {
    double total = 0;
    for (var item in _carts) {
      total += item.quantity * item.productModel.price;
    }
    return total;
  }
}
