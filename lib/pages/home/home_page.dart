import 'package:flutter/material.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/models/user_model.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/providers/product_provider.dart';
import 'package:shamo/services/sortir_product_service.dart';
import 'package:shamo/widgets/product_card.dart';
import 'package:shamo/widgets/product_tile.dart';
import 'package:shamo/theme.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    loadProducts();
    super.initState();
  }

  Future<void> loadProducts() async {
    setState(() {
      isLoading = true;
    });

    try {
      products = await SortirProductService().getProducts(index);
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  bool isLoading = false;
  List<ProductModel> products = [];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hallo, ${user.name}',
                    style: primaryTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    '@${user.username}',
                    style: subtittleTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: regular,
                    ),
                  ),
                ],
              ),
            ),
            ClipOval(
              child: Image.network(
                user.profilePhotoUrl.toString(),
                width: 54,
              ),
            ),
          ],
        ),
      );
    }

    Widget categoryButton(
      String text,
      int indexCategory,
    ) {
      return InkWell(
        onTap: () {
          index = indexCategory;
          loadProducts();
          setState(() {});
        },
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          decoration: indexCategory == index
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: primaryColor,
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: subtittleTextColor),
                  color: transparentColor,
                ),
          child: Text(
            text,
            style: indexCategory == index
                ? primaryTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 13,
                  )
                : subtittleTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 13,
                  ),
          ),
        ),
      );
    }

    Widget categories() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: defaultMargin),
              categoryButton('All Shoes', 0),
              categoryButton('Running', 5),
              categoryButton('Training', 4),
              categoryButton('Basketball', 3),
              categoryButton('Hiking', 2),
            ],
          ),
        ),
      );
    }

    Widget popularProduct() {
      return isLoading
          ? const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: defaultMargin,
                    right: defaultMargin,
                    top: defaultMargin,
                  ),
                  child: Text(
                    'Popular Products',
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 14),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: defaultMargin),
                        Row(
                          children:
                              products.map((e) => ProductCard(e)).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
    }

    Widget newArrivals() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: defaultMargin,
              right: defaultMargin,
              top: defaultMargin,
            ),
            child: Text(
              'New Arrivals',
              style: primaryTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 22,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 14),
            child: Column(
              children: [
                SizedBox(width: defaultMargin),
                Column(
                  children: productProvider.products
                      .map((e) => ProductTile(e))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return ListView(
      children: [
        header(),
        categories(),
        popularProduct(),
        newArrivals(),
      ],
    );
  }
}
