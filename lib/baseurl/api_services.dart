import 'dart:convert';

import 'package:user/baseurl/baseurlg.dart';
import 'package:user/beanmodel/productbean/subscriber_product_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<SubscriberProducts> _getSubscribeProductList() async {
    try {
      var response = await http.get(subscriptionUri);
      print("RES:" + response.body.toString());
      var responseJson = json.decode(response.body);
      return SubscriberProducts.fromJson(responseJson);
    } catch (error) {
      return Future.error(error);
    }
  }
}
