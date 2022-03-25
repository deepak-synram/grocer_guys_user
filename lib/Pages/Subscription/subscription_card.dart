import 'package:flutter/material.dart';
import 'package:user/Pages/Subscription/pause_subscription.dart';
import 'package:user/Pages/Subscription/subscription_data_model.dart';
import 'package:user/Theme/colors.dart';

class SubscriptionCard extends StatefulWidget {
  // const SubscriptionCard(
  //     {Key key,
  //     this.duration,
  //     this.sTitle,
  //     this.quantity,
  //     this.weight,
  //     this.price,
  //     this.productImage})
  //     : super(key: key);
  // final String duration;
  // final String sTitle;
  // final String quantity;
  // final String weight;
  // final String price;
  // final String productImage;
  final SubscriptionDataModel sdm;
  final bool isMiniCard;
  const SubscriptionCard({
    Key key,
    @required this.sdm,
    @required this.isMiniCard,
  }) : super(key: key);

  @override
  _SubscriptionCardState createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(6),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 18.0,
                    color: kBlackColor,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Subscription : ',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: widget.sdm.duration,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            ListTile(
              leading: Image.asset(
                widget.sdm.productImgUrl,
                width: 120,
                height: 120,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.sdm.productName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    widget.sdm.weight,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Qty : ${widget.sdm.quantity}',
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 3),
                  RichText(
                    text: TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: TextStyle(
                        color: kBlackColor,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Subscription Price : ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        TextSpan(
                            text: widget.sdm.price,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (widget.isMiniCard) ...[
              const Divider(thickness: 2),
            ],
            if (widget.isMiniCard) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      print('Modify Clicked');
                    },
                    child: Chip(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.green[800], width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(5),
                      label: Text(
                        'MODIFY',
                        style:
                            TextStyle(color: Colors.green[800], fontSize: 14),
                      ),
                      avatar: Icon(
                        Icons.calendar_today,
                        size: 15,
                        color: Colors.green[800],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Delete Clicked');
                    },
                    child: Chip(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.red[900], width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(5),
                      label: Text(
                        'DELETE',
                        style: TextStyle(color: Colors.red[900], fontSize: 14),
                      ),
                      avatar: Icon(
                        Icons.delete,
                        size: 15,
                        color: Colors.red[900],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          PauseSubscriptionPage(sdm: widget.sdm),
                    )),
                    child: Chip(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue[900], width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(5),
                      label: Text(
                        'PAUSE',
                        style: TextStyle(color: Colors.blue[900], fontSize: 14),
                      ),
                      avatar: Icon(
                        Icons.pause,
                        size: 15,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 3),
          ],
        ),
      ),
    );
  }
}
