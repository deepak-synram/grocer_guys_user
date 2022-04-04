import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/baseurl/baseurlg.dart';
import 'package:user/beanmodel/productbean/product_details_model.dart';
import 'package:user/beanmodel/productbean/subscriber_product_model.dart';
import 'package:user/beanmodel/searchmodel/searchkeyword.dart';

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

  static Future<ProductDetailsModel> getProductDetail(String productId) async {
    try {
      var response = await http.post(
        productDetailsUri,
        body: jsonEncode(
          <String, String>{'product_id': productId},
        ),
      );
      print("RESPONSE IS -----> :" + response.body.toString());
      var responseJson = json.decode(response.body);
      print('Received Data !!!!!!!!!!!!!!!!!!!!!!!!!!!');
      return ProductDetailsModel.fromJson(responseJson);
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<ProductSearchModel> getProductFromKeyword(
      String keyword, String storeID, String byName) async {
    try {
      print('API has been hit !~!!');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String userId = '${preferences.getInt('user_id')}';
      print('The User Id is : $userId');
      print('The storeID is $storeID');
      print('The keyword is $keyword');
      var response = await http.post(
        productSearchUri,
        body: jsonEncode(
          <String, String>{'keyword': keyword, 'store_id': '3'},
        ),
      );
      print("RESPONSE IS -----> :" + response.body.toString());
      var responseJson = json.decode(response.body);
      return ProductSearchModel.fromJson(responseJson);
    } catch (error) {
      return Future.error(error);
    }
  }
}
