import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/pages/product_page.dart';
import 'package:shamo/providers/wishlist_provider.dart';
import 'package:shamo/theme.dart';

class WishlistTile extends StatefulWidget {
  const WishlistTile(this.product, {Key? key}) : super(key: key);
  final ProductModel product;

  @override
  State<WishlistTile> createState() => _WishlistTileState();
}

class _WishlistTileState extends State<WishlistTile> {
  bool isWishlist = false;

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(widget.product),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 12,
          right: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: bgColor4,
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage('${widget.product.galleries![0].url}'),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.product.name}',
                    style: primaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    '\$${widget.product.price}',
                    style: priceTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {});
                wishlistProvider.setProduct(widget.product);

                if (wishlistProvider.isWishlist(widget.product)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Has been added to the Whistlist',
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: secondaryColor,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Has been removed from the Whistlist',
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: alertColor,
                    ),
                  );
                }

                // Future.delayed(
                //   const Duration(seconds: 1),
                //   () => Navigator.pushNamed(context, '/home'),
                // );
              },
              child: Image.asset(
                wishlistProvider.isWishlist(widget.product)
                    ? 'assets/images/btn_love2.png'
                    : 'assets/images/btn_love.png',
                width: 34,
                height: 34,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
