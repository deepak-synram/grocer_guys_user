import 'package:user/beanmodel/productbean/productwithvarient.dart';
import 'package:user/beanmodel/storefinder/storefinderbean.dart';

class SearchProviderBean{
  bool isSearching;
  List<ProductDataModel> searchdata;
  StoreFinderData storeData;

  SearchProviderBean(this.isSearching, this.searchdata, this.storeData);
}