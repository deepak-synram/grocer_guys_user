import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:user/baseurl/baseurlg.dart';
import 'package:user/beanmodel/productbean/subscriber_product_model.dart';

class ApiServices {
  static Future<SubscriberProducts> getSubscribeProductList() async {
    try {
      var response = await http.get(subscriptionUri);
      print("RES:" + response.body.toString());
      var responseJson = json.decode(response.body);
      print('Received Data !!!!!!!!!!!!!!!!!!!!!!!!!!!');
      return SubscriberProducts.fromJson(responseJson);
    } catch (error) {
      return Future.error(error);
    }
  }
}
