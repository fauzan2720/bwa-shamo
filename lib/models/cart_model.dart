import 'package:shamo/models/product_model.dart';

class CartModel {
  int? id;
  late ProductModel product;
  int? quantity;

  CartModel({
    this.id,
    required this.product,
    this.quantity,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductModel.fromJson(json['product']);
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
    };
  }

  double getTotalPrice() {
    return product.price! * quantity!;
  }
}
