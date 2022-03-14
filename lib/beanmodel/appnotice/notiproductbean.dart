class NotiProductBean {
  dynamic status;
  dynamic productId;
  dynamic clickAction;
  dynamic sound;

  NotiProductBean({this.status, this.productId, this.clickAction, this.sound});

  NotiProductBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    productId = json['product_id'];
    clickAction = json['click_action'];
    sound = json['sound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['product_id'] = this.productId;
    data['click_action'] = this.clickAction;
    data['sound'] = this.sound;
    return data;
  }

  @override
  String toString() {
    return '{\"status\": \"$status\", \"productId\": \"$productId\", \"clickAction\": \"$clickAction\", \"sound\": \"$sound\"}';
  }
}