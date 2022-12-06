import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/order_model.dart';
import 'package:shamo/providers/cart_provider.dart';
import 'package:shamo/services/transaction_service.dart';
import 'package:shamo/theme.dart';
import 'package:shamo/widgets/order_card.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    loadOrders();
    super.initState();
  }

  Future<void> loadOrders() async {
    setState(() {
      isLoading = true;
    });

    try {
      orders = await TransactionService().getOrders();
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  bool isLoading = false;
  List<OrderModel> orders = [];

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: bgColor1,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Your Orders',
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
      );
    }

    Widget emptyCart() {
      return Container(
        width: double.infinity,
        color: bgColor3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ic_cart_shop.png',
              width: 80,
            ),
            const SizedBox(height: 20),
            Text(
              'Opss! Your Order is Empty',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Let\'s find your favorite shoes',
              style: secondaryTextStyle,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Explore Store',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor3,
      appBar: header(),
      body: orders.isEmpty
          ? emptyCart()
          : ListView(
              children: orders.map((e) => OrderCard(e)).toList(),
            ),
    );
  }
}