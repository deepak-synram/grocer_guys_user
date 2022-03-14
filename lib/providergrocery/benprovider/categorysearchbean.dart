import 'package:user/beanmodel/category/categorymodel.dart';
import 'package:user/beanmodel/category/topcategory.dart';
import 'package:user/beanmodel/storefinder/storefinderbean.dart';

class CategorySearchBean{
  bool isSearching;
  StoreFinderData storeFinderData;
  List<CategoryDataModel> data;

  CategorySearchBean({this.isSearching, this.data, this.storeFinderData});

}