class SubscriberProducts {
  String status;
  String message;
  List<Data> data;

  SubscriberProducts({this.status, this.message, this.data});

  SubscriberProducts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  bool isSubscribe;
  int id;
  int productId;
  String createdAt;
  String updatedAt;
  int catId;
  String productName;
  String productImage;
  String type;
  int hide;
  int addedBy;
  int approved;
  String maxAddCardQty;
  String title;
  String slug;
  String url;
  String image;
  int parent;
  int level;
  String description;
  int status;
  int taxType;
  String taxName;
  int taxPer;
  String txId;

  Data(
      {this.id,
      this.productId,
      this.createdAt,
      this.updatedAt,
      this.catId,
      this.productName,
      this.productImage,
      this.type,
      this.hide,
      this.addedBy,
      this.approved,
      this.maxAddCardQty,
      this.title,
      this.slug,
      this.url,
      this.image,
      this.parent,
      this.level,
      this.description,
      this.status,
      this.taxType,
      this.taxName,
      this.taxPer,
      this.isSubscribe,
      this.txId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    catId = json['cat_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    type = json['type'];
    hide = json['hide'];
    addedBy = json['added_by'];
    approved = json['approved'];
    maxAddCardQty = json['max_add_card_qty'];
    title = json['title'];
    slug = json['slug'];
    url = json['url'];
    image = json['image'];
    parent = json['parent'];
    level = json['level'];
    description = json['description'];
    status = json['status'];
    taxType = json['tax_type'];
    taxName = json['tax_name'];
    taxPer = json['tax_per'];
    txId = json['tx_id'];
    isSubscribe = json['is_subscribe'] == 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['cat_id'] = catId;
    data['product_name'] = productName;
    data['product_image'] = productImage;
    data['type'] = type;
    data['hide'] = hide;
    data['added_by'] = addedBy;
    data['approved'] = approved;
    data['max_add_card_qty'] = maxAddCardQty;
    data['title'] = title;
    data['slug'] = slug;
    data['url'] = url;
    data['image'] = image;
    data['parent'] = parent;
    data['level'] = level;
    data['description'] = description;
    data['status'] = status;
    data['tax_type'] = taxType;
    data['tax_name'] = taxName;
    data['tax_per'] = taxPer;
    data['tx_id'] = txId;
    data['is_subscribe'] = isSubscribe;
    return data;
  }
}
