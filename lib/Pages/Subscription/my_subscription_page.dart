import 'package:flutter/material.dart';
import 'package:user/Pages/Other/app_bar.dart';
import 'package:user/Pages/Subscription/subscription_card.dart';
import 'package:user/Pages/Subscription/subscription_data_model.dart';

class MySubscriptionPage extends StatefulWidget {
  const MySubscriptionPage({Key key}) : super(key: key);

  @override
  _MySubscriptionPageState createState() => _MySubscriptionPageState();
}

class _MySubscriptionPageState extends State<MySubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: const CustomAppBar(title: 'My Subscriptions'),
        body: ListView.builder(
          padding: const EdgeInsets.all(5),
          itemBuilder: (context, index) {
            return SubscriptionCard(
              sdm: SubscriptionDataModel('Brocolli', '1', '500 g', '\$25',
                  'assets/ProductImages/Garlic.png', 'Alternate Day'),
              isMiniCard: true,
            );
          },
          itemCount: 5,
        ));
  }
}
