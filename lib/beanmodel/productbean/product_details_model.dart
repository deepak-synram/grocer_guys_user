class ProductDetailsModel {
  int success;
  String message;
  Data data;

  ProductDetailsModel({this.success, this.message, this.data});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int productId;
  int catId;
  String productName;
  String productImage;
  String type;
  int hide;
  int addedBy;
  int approved;
  String maxAddCardQty;
  int isSubscribe;
  String title;
  String slug;
  Null url;
  String image;
  int parent;
  int level;
  String description;
  int status;
  int taxType;
  Null taxName;
  int taxPer;
  Null txId;
  List<Varient> varient;

  Data(
      {this.productId,
      this.catId,
      this.productName,
      this.productImage,
      this.type,
      this.hide,
      this.addedBy,
      this.approved,
      this.maxAddCardQty,
      this.isSubscribe,
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
      this.txId,
      this.varient});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    catId = json['cat_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    type = json['type'];
    hide = json['hide'];
    addedBy = json['added_by'];
    approved = json['approved'];
    maxAddCardQty = json['max_add_card_qty'];
    isSubscribe = json['is_subscribe'];
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
    if (json['varient'] != null) {
      varient = new List<Varient>();
      json['varient'].forEach((v) {
        varient.add(new Varient.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['cat_id'] = this.catId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['type'] = this.type;
    data['hide'] = this.hide;
    data['added_by'] = this.addedBy;
    data['approved'] = this.approved;
    data['max_add_card_qty'] = this.maxAddCardQty;
    data['is_subscribe'] = this.isSubscribe;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['url'] = this.url;
    data['image'] = this.image;
    data['parent'] = this.parent;
    data['level'] = this.level;
    data['description'] = this.description;
    data['status'] = this.status;
    data['tax_type'] = this.taxType;
    data['tax_name'] = this.taxName;
    data['tax_per'] = this.taxPer;
    data['tx_id'] = this.txId;
    if (this.varient != null) {
      data['varient'] = this.varient.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Varient {
  int varientId;
  int productId;
  int quantity;
  String unit;
  int baseMrp;
  int basePrice;
  String description;
  String varientImage;
  String ean;
  int approved;
  int addedBy;

  Varient(
      {this.varientId,
      this.productId,
      this.quantity,
      this.unit,
      this.baseMrp,
      this.basePrice,
      this.description,
      this.varientImage,
      this.ean,
      this.approved,
      this.addedBy});

  Varient.fromJson(Map<String, dynamic> json) {
    varientId = json['varient_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    unit = json['unit'];
    baseMrp = json['base_mrp'];
    basePrice = json['base_price'];
    description = json['description'];
    varientImage = json['varient_image'];
    ean = json['ean'];
    approved = json['approved'];
    addedBy = json['added_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['varient_id'] = this.varientId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['base_mrp'] = this.baseMrp;
    data['base_price'] = this.basePrice;
    data['description'] = this.description;
    data['varient_image'] = this.varientImage;
    data['ean'] = this.ean;
    data['approved'] = this.approved;
    data['added_by'] = this.addedBy;
    return data;
  }
}
