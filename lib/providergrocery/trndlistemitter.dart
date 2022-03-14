import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/beanmodel/productbean/productwithvarient.dart';
import 'package:user/providergrocery/benprovider/trndproviderbean.dart';

class TopRecentNewDealProvider extends Cubit<TopRecentNewDataBean>{
  TopRecentNewDealProvider() : super(TopRecentNewDataBean(data: null,index: 0));

  void hitTopRecentNewDealPro(List<ProductDataModel> pData, int index) async{
    emit(TopRecentNewDataBean(data: pData,index: index));
  }

}