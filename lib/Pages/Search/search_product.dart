import 'package:flutter/material.dart';
import 'package:user/Pages/HomePage/product_card.dart';
import 'package:user/Theme/colors.dart';
import 'package:user/baseurl/api_services.dart';
import 'package:user/beanmodel/searchmodel/searchkeyword.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({Key key}) : super(key: key);
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  String searchString = '';
  TextEditingController controller = TextEditingController();
  ProductSearchModel psm;
  int currentDataSize = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kMainColor,
          title: Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color(0xfff8f8f8), width: 1),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xfff8f8f8),
                  ),
                  BoxShadow(
                    color: Color(0xfff8f8f8),
                  )
                ]),
            child: TextField(
              controller: controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.name,
              onChanged: (value) async {
                searchString = value;
              },
              decoration: InputDecoration(
                suffix: IconButton(
                  onPressed: () {
                    controller.clear();
                    FocusScope.of(context).unfocus();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
                fillColor: Colors.white,
                prefixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  onPressed: () async {
                    psm = await ApiServices.getProductFromKeyword(
                        searchString, '3', '');
                    print(psm.data);
                    setState(() {
                      if (psm.data != null) currentDataSize = psm.data.length;
                    });
                  },
                ),
                hintText: 'Search for products .....',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              ),
            ),
          ),
        ),
        body: Container(
          child: currentDataSize != 0
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.8,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                  ),
                  itemBuilder: (context, index) {
                    return ProductCard(
                      total: 10,
                      locModel: null,
                      catP: null,
                      locale: null,
                      index: index,
                      title: psm.data[index].productName,
                      image: psm.data[index].productImage,
                      subTitle: '500g',
                      symbol: '\u{20B9}',
                      previousPrice: '35',
                      newPrice: '36.55',
                    );
                  },
                  itemCount: psm.data.length,
                )
              : Container(),
        ));
  }
}
