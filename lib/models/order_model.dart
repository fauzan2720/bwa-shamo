class OrderModel {
  int? id;
  int? usersId;
  String? address;
  int? totalPrice;
  int? shippingPrice;
  String? status;
  String? payment;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  List<Items>? items;

  OrderModel(
      {this.id,
      this.usersId,
      this.address,
      this.totalPrice,
      this.shippingPrice,
      this.status,
      this.payment,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.items});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    address = json['address'];
    totalPrice = json['total_price'];
    shippingPrice = json['shipping_price'];
    status = json['status'];
    payment = json['payment'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['users_id'] = this.usersId;
    data['address'] = this.address;
    data['total_price'] = this.totalPrice;
    data['shipping_price'] = this.shippingPrice;
    data['status'] = this.status;
    data['payment'] = this.payment;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  int? usersId;
  int? productsId;
  int? transactionsId;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Items(
      {this.id,
      this.usersId,
      this.productsId,
      this.transactionsId,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.product});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    productsId = json['products_id'];
    transactionsId = json['transactions_id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['users_id'] = this.usersId;
    data['products_id'] = this.productsId;
    data['transactions_id'] = this.transactionsId;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  int? price;
  String? description;
  Null? tags;
  int? categoriesId;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
      this.name,
      this.price,
      this.description,
      this.tags,
      this.categoriesId,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    tags = json['tags'];
    categoriesId = json['categories_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['tags'] = this.tags;
    data['categories_id'] = this.categoriesId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
