class ProductSearchModel {
  String status;
  String message;
  List<Data> data;

  ProductSearchModel({this.status, this.message, this.data});

  ProductSearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int storeId;
  int stock;
  int varientId;
  int productId;
  String productName;
  String productImage;
  String description;
  int price;
  int mrp;
  Null varientImage;
  String unit;
  int quantity;
  String type;
  int discountper;
  int avgrating;
  String isFavourite;
  int cartQty;
  int countrating;
  int maxprice;
  List<Varients> varients;
  List<Images> images;
  List<Tags> tags;

  Data(
      {this.storeId,
      this.stock,
      this.varientId,
      this.productId,
      this.productName,
      this.productImage,
      this.description,
      this.price,
      this.mrp,
      this.varientImage,
      this.unit,
      this.quantity,
      this.type,
      this.discountper,
      this.avgrating,
      this.isFavourite,
      this.cartQty,
      this.countrating,
      this.maxprice,
      this.varients,
      this.images,
      this.tags});

  Data.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    stock = json['stock'];
    varientId = json['varient_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    description = json['description'];
    price = json['price'];
    mrp = json['mrp'];
    varientImage = json['varient_image'];
    unit = json['unit'];
    quantity = json['quantity'];
    type = json['type'];
    discountper = json['discountper'];
    avgrating = json['avgrating'];
    isFavourite = json['isFavourite'];
    cartQty = json['cart_qty'];
    countrating = json['countrating'];
    maxprice = json['maxprice'];
    if (json['varients'] != null) {
      varients = new List<Varients>();
      json['varients'].forEach((v) {
        varients.add(new Varients.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_id'] = this.storeId;
    data['stock'] = this.stock;
    data['varient_id'] = this.varientId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['description'] = this.description;
    data['price'] = this.price;
    data['mrp'] = this.mrp;
    data['varient_image'] = this.varientImage;
    data['unit'] = this.unit;
    data['quantity'] = this.quantity;
    data['type'] = this.type;
    data['discountper'] = this.discountper;
    data['avgrating'] = this.avgrating;
    data['isFavourite'] = this.isFavourite;
    data['cart_qty'] = this.cartQty;
    data['countrating'] = this.countrating;
    data['maxprice'] = this.maxprice;
    if (this.varients != null) {
      data['varients'] = this.varients.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Varients {
  int storeId;
  int stock;
  int varientId;
  String description;
  int price;
  int mrp;
  Null varientImage;
  String unit;
  int quantity;
  Null dealPrice;
  Null validFrom;
  Null validTo;
  String isFavourite;
  int cartQty;
  int avgrating;
  int countrating;
  int discountper;
  int maxprice;

  Varients(
      {this.storeId,
      this.stock,
      this.varientId,
      this.description,
      this.price,
      this.mrp,
      this.varientImage,
      this.unit,
      this.quantity,
      this.dealPrice,
      this.validFrom,
      this.validTo,
      this.isFavourite,
      this.cartQty,
      this.avgrating,
      this.countrating,
      this.discountper,
      this.maxprice});

  Varients.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    stock = json['stock'];
    varientId = json['varient_id'];
    description = json['description'];
    price = json['price'];
    mrp = json['mrp'];
    varientImage = json['varient_image'];
    unit = json['unit'];
    quantity = json['quantity'];
    dealPrice = json['deal_price'];
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
    isFavourite = json['isFavourite'];
    cartQty = json['cart_qty'];
    avgrating = json['avgrating'];
    countrating = json['countrating'];
    discountper = json['discountper'];
    maxprice = json['maxprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_id'] = this.storeId;
    data['stock'] = this.stock;
    data['varient_id'] = this.varientId;
    data['description'] = this.description;
    data['price'] = this.price;
    data['mrp'] = this.mrp;
    data['varient_image'] = this.varientImage;
    data['unit'] = this.unit;
    data['quantity'] = this.quantity;
    data['deal_price'] = this.dealPrice;
    data['valid_from'] = this.validFrom;
    data['valid_to'] = this.validTo;
    data['isFavourite'] = this.isFavourite;
    data['cart_qty'] = this.cartQty;
    data['avgrating'] = this.avgrating;
    data['countrating'] = this.countrating;
    data['discountper'] = this.discountper;
    data['maxprice'] = this.maxprice;
    return data;
  }
}

class Images {
  String image;

  Images({this.image});

  Images.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

class Tags {
  int tagId;
  int productId;
  String tag;

  Tags({this.tagId, this.productId, this.tag});

  Tags.fromJson(Map<String, dynamic> json) {
    tagId = json['tag_id'];
    productId = json['product_id'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_id'] = this.tagId;
    data['product_id'] = this.productId;
    data['tag'] = this.tag;
    return data;
  }
}
