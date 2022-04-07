import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/baseurl/baseurlg.dart';
import 'package:user/beanmodel/category/category_products_model.dart';
import 'package:user/beanmodel/productbean/product_details_model.dart';
import 'package:user/beanmodel/productbean/subscriber_product_model.dart';
import 'package:user/beanmodel/searchmodel/searchkeyword.dart';
import 'package:user/beanmodel/singleapibean.dart';

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
        body: {'keyword': keyword, 'store_id': '3'},
      );
      print("RESPONSE IS -----> :" + response.body.toString());
      var responseJson = json.decode(response.body);
      return ProductSearchModel.fromJson(responseJson);
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<List<TopCat>> getTopCat(String storeId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await http.post(oneApiUri, body: {
        'store_id': '$storeId'
      }, headers: {
        'Authorization': 'Bearer ${prefs.getString('accesstoken')}'
      });
      print(response.body);
      SingleApiHomePage data1 =
          SingleApiHomePage.fromJson(jsonDecode(response.body));
      return data1.topCat;
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<CategoryProductsModel> getCategoryProducts(
      String storeId, String catId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await http.post(categoryProductsUri, body: {
        'store_id': storeId,
        'cat_id': catId
      }, headers: {
        'Authorization': 'Bearer ${prefs.getString('accesstoken')}'
      });
      print(response.body);
      CategoryProductsModel data1 =
          CategoryProductsModel.fromJson(jsonDecode(response.body));
      return data1;
    } catch (error) {
      print(error);
      return Future.error(error);
    }
  }
}
