import 'package:flutter/material.dart';
import 'package:shamo/models/order_model.dart';
import 'package:shamo/theme.dart';

class OrderCard extends StatelessWidget {
  const OrderCard(this.order, {Key? key}) : super(key: key);
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.items!.length == 1
                      ? '${order.items![0].product!.name}'
                      : '${order.items![0].product!.name} ...',
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '\$${order.totalPrice}',
                  style: priceTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${order.status}",
            style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
