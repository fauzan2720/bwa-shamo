import 'dart:convert';
import 'package:shamo/main.dart';
import 'package:shamo/models/product_model.dart';
import 'package:http/http.dart' as http;

class SortirProductService {
  String baseUrl = UrlAPI().baseUrl;

  Future<List<ProductModel>> getProducts(
    int idCategory,
  ) async {
    var url = '$baseUrl/products?categories=$idCategory';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception('Gagal Get Products!');
    }
  }
}
