import 'dart:convert';
import 'package:shamo/main.dart';
import 'package:shamo/models/cart_model.dart';
import 'package:http/http.dart' as http;
import 'package:shamo/models/order_model.dart';
import 'package:shamo/session_manager.dart';

class TransactionService {
  String baseUrl = UrlAPI().baseUrl;
  String token = mainStorage.get("token");

  Future<List<OrderModel>> getOrders() async {
    var url = '$baseUrl/transactions';

    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<OrderModel> orders = [];

      for (var item in data) {
        orders.add(OrderModel.fromJson(item));
      }

      return orders;
    } else {
      throw Exception('Gagal Get Orders!');
    }
  }

  Future<bool> checkout(
    String token,
    List<CartModel> carts,
    double totalPrice,
  ) async {
    var url = '$baseUrl/checkout';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode(
      {
        'address': "Marsemoon",
        'items': carts
            .map(
              (cart) => {
                'id': cart.product.id,
                'quantity': cart.quantity,
              },
            )
            .toList(),
        'status': "PENDING",
        'total_price': totalPrice,
        'shipping_price': 0,
      },
    );

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Melakukan Checkout!');
    }
  }
}
