// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/providers/cart_provider.dart';
import 'package:shamo/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubble extends StatefulWidget {
  final String text;
  final bool isSender;
  final ProductModel? product;

  // ignore: prefer_const_constructors_in_immutables
  ChatBubble({
    this.isSender = false,
    this.text = '',
    this.product,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    Future<void> showSuccessDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) => SizedBox(
          width: MediaQuery.of(context).size.width - (2 * 30),
          child: AlertDialog(
            backgroundColor: bgColor3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.close,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/ic_success.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Hurray :)',
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Item added successfully',
                    style: subtittleTextStyle.copyWith(
                      fontWeight: regular,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 154,
                    height: 44,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/cart');
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: primaryColor,
                      ),
                      child: Text(
                        'View My Cart',
                        style: primaryTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget productPreview() {
      return Container(
        width: 250,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.isSender ? bgColor5 : bgColor4,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.isSender ? 12 : 0),
            topRight: Radius.circular(widget.isSender ? 0 : 12),
            bottomLeft: const Radius.circular(12),
            bottomRight: const Radius.circular(12),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.product!.galleries![0].url!,
                    width: 70,
                    height: 70,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.product!.name!,
                        style: primaryTextStyle.copyWith(
                          fontWeight: regular,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '\$${widget.product!.price}',
                        style: priceTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    cartProvider.addCart(widget.product!);
                    showSuccessDialog();
                  },
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: primaryColor),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                  child: Text(
                    'Add to Cart',
                    style: purpleTextStyle.copyWith(
                      fontWeight: regular,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/checkout');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Buy Now',
                    style: GoogleFonts.poppins(
                      color: bgColor5,
                      fontWeight: regular,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment:
            widget.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          widget.product is UninitializedProductModel
              ? const SizedBox()
              : productPreview(),
          Row(
            mainAxisAlignment: widget.isSender
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width *
                        0.6, // kelebaran tiap-tiap chat 60%
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: widget.isSender ? bgColor5 : bgColor4,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(widget.isSender ? 12 : 0),
                      topRight: Radius.circular(widget.isSender ? 0 : 12),
                      bottomLeft: const Radius.circular(12),
                      bottomRight: const Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    widget.text,
                    style: primaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: regular,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
