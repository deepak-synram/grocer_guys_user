class SingleApiHomePage {
  String status;
  String message;
  List<BannerDataModel> banner;
  List<Null> secondBanner;
  List<TopCat> topCat;
  List<Recentselling> recentselling;
  List<Topselling> topselling;
  List<Recentselling> dealproduct;
  List<Whatsnew> whatsnew;
  List<Recentselling> spotlight;

  SingleApiHomePage(
      {this.status,
      this.message,
      this.banner,
      this.secondBanner,
      this.topCat,
      this.recentselling,
      this.topselling,
      this.dealproduct,
      this.whatsnew,
      this.spotlight});

  SingleApiHomePage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    if (json['banner'] != null) {
      banner = [];
      json['banner'].forEach((v) {
        banner.add(BannerDataModel.fromJson(v));
      });
    }

    if (json['top_cat'] != null) {
      topCat = [];
      json['top_cat'].forEach((v) {
        topCat.add(TopCat.fromJson(v));
      });
    }
    if (json['recentselling'] != null) {
      recentselling = [];
      json['recentselling'].forEach((v) {
        recentselling.add(Recentselling.fromJson(v));
      });
    }
    if (json['topselling'] != null) {
      topselling = [];
      json['topselling'].forEach((v) {
        topselling.add(Topselling.fromJson(v));
      });
    }
    if (json['dealproduct'] != null) {
      dealproduct = [];
      json['dealproduct'].forEach((v) {
        dealproduct.add(Recentselling.fromJson(v));
      });
    }
    if (json['whatsnew'] != null) {
      whatsnew = [];
      json['whatsnew'].forEach((v) {
        whatsnew.add(Whatsnew.fromJson(v));
      });
    }
    if (json['spotlight'] != null) {
      spotlight = [];
      json['spotlight'].forEach((v) {
        spotlight.add(Recentselling.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.banner != null) {
      data['banner'] = this.banner.map((v) => v.toJson()).toList();
    }
    if (this.topCat != null) {
      data['top_cat'] = this.topCat.map((v) => v.toJson()).toList();
    }
    if (this.recentselling != null) {
      data['recentselling'] =
          this.recentselling.map((v) => v.toJson()).toList();
    }
    if (this.topselling != null) {
      data['topselling'] = this.topselling.map((v) => v.toJson()).toList();
    }
    if (this.dealproduct != null) {
      data['dealproduct'] = this.dealproduct.map((v) => v.toJson()).toList();
    }
    if (this.whatsnew != null) {
      data['whatsnew'] = this.whatsnew.map((v) => v.toJson()).toList();
    }
    if (this.spotlight != null) {
      data['spotlight'] = this.spotlight.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerDataModel {
  int bannerId;
  String bannerName;
  String bannerImage;
  int storeId;
  int catId;
  String type;
  String title;

  BannerDataModel(
      {this.bannerId,
      this.bannerName,
      this.bannerImage,
      this.storeId,
      this.catId,
      this.type,
      this.title});

  BannerDataModel.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
    bannerName = json['banner_name'];
    bannerImage = json['banner_image'];
    storeId = json['store_id'];
    catId = json['cat_id'];
    type = json['type'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_id'] = this.bannerId;
    data['banner_name'] = this.bannerName;
    data['banner_image'] = this.bannerImage;
    data['store_id'] = this.storeId;
    data['cat_id'] = this.catId;
    data['type'] = this.type;
    data['title'] = this.title;
    return data;
  }
}

class TopCat {
  String title;
  int catId;
  String image;
  int storeId;
  String description;
  int stfrom;
  int subcatCount;

  TopCat(
      {this.title,
      this.catId,
      this.image,
      this.storeId,
      this.description,
      this.stfrom,
      this.subcatCount});

  TopCat.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    catId = json['cat_id'];
    image = json['image'];
    storeId = json['store_id'];
    description = json['description'];
    stfrom = json['stfrom'];
    subcatCount = json['subcat_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['cat_id'] = this.catId;
    data['image'] = this.image;
    data['store_id'] = this.storeId;
    data['description'] = this.description;
    data['stfrom'] = this.stfrom;
    data['subcat_count'] = this.subcatCount;
    return data;
  }
}

class Recentselling {
  int storeId;
  int stock;
  int varientId;
  int productId;
  String productName;
  String productImage;
  String description;
  int price;
  int mrp;
  String varientImage;
  String unit;
  int quantity;
  String type;
  int count;
  String isFavourite;
  int cartQty;
  int avgrating;
  int countrating;
  double discountper;
  List<Varients> varients;
  List<Images> images;
  List<Tags> tags;

  Recentselling(
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
      this.count,
      this.isFavourite,
      this.cartQty,
      this.avgrating,
      this.countrating,
      this.discountper,
      this.varients,
      this.images,
      this.tags});

  Recentselling.fromJson(Map<String, dynamic> json) {
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
    count = json['count'];
    isFavourite = json['isFavourite'];
    cartQty = json['cart_qty'];
    avgrating = json['avgrating'];
    countrating = json['countrating'];
    discountper = json['discountper'];

    if (json['varients'] != null) {
      varients = new List<Varients>();
      json['varients'].forEach((v) {
        varients.add(new Varients.fromJson(v));
      });
    }

    if (json['images'] != null) {
      images = new List<Images>();
      json['images']?.forEach((v) {
        print('Came Till here 2');
        images.add(Images.fromJson(v));
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
    data['count'] = this.count;
    data['isFavourite'] = this.isFavourite;
    data['cart_qty'] = this.cartQty;
    data['avgrating'] = this.avgrating;
    data['countrating'] = this.countrating;
    data['discountper'] = this.discountper;
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
  double discountper;

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
      this.discountper});

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

class Topselling {
  int storeId;
  int stock;
  int varientId;
  int productId;
  String productName;
  String productImage;
  String description;
  int price;
  int mrp;
  String varientImage;
  String unit;
  int quantity;
  String type;
  int count;
  String isFavourite;
  int cartQty;
  double avgrating;
  int countrating;
  double discountper;
  List<Varients> varients;
  List<Images> images;
  List<Tags> tags;

  Topselling(
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
      this.count,
      this.isFavourite,
      this.cartQty,
      this.avgrating,
      this.countrating,
      this.discountper,
      this.varients,
      this.images,
      this.tags});

  Topselling.fromJson(Map<String, dynamic> json) {
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

    count = json['count'];
    isFavourite = json['isFavourite'];
    cartQty = json['cart_qty'];

    avgrating = json['avgrating'];
    countrating = json['countrating'];
    discountper = json['discountper'];

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
    data['count'] = this.count;
    data['isFavourite'] = this.isFavourite;
    data['cart_qty'] = this.cartQty;
    data['avgrating'] = this.avgrating;
    data['countrating'] = this.countrating;
    data['discountper'] = this.discountper;
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

class Whatsnew {
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
  String isFavourite;
  int cartQty;
  int avgrating;
  int countrating;
  double discountper;
  List<Varients> varients;
  List<Images> images;
  List<Tags> tags;

  Whatsnew(
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
      this.isFavourite,
      this.cartQty,
      this.avgrating,
      this.countrating,
      this.discountper,
      this.varients,
      this.images,
      this.tags});

  Whatsnew.fromJson(Map<String, dynamic> json) {
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
    isFavourite = json['isFavourite'];
    cartQty = json['cart_qty'];
    avgrating = json['avgrating'];
    countrating = json['countrating'];
    discountper = json['discountper'];
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
    data['isFavourite'] = this.isFavourite;
    data['cart_qty'] = this.cartQty;
    data['avgrating'] = this.avgrating;
    data['countrating'] = this.countrating;
    data['discountper'] = this.discountper;
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
