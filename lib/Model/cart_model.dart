import 'package:food_delivery_2/Model/product_model.dart';

class CartModel {
  final MyProductModel productModel;
  int quantity;

  CartModel({
    required this.productModel,
    required this.quantity,
  });
}
