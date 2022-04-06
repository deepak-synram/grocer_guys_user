import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/Pages/Other/app_bar.dart';
import 'package:user/Theme/colors.dart';

class NewWalletUI extends StatefulWidget {
  const NewWalletUI({Key key}) : super(key: key);

  @override
  _NewWalletUIState createState() => _NewWalletUIState();
}

class _NewWalletUIState extends State<NewWalletUI> {
  var selectedTab = 0;

  void changeTab(int tabSelected) {
    if (tabSelected != selectedTab) {
      setState(() {
        selectedTab = tabSelected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 200),
        child: SizedBox(
          height: 130,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const CustomAppBar(
                title: 'My Wallet',
              ),
              Align(
                alignment: const Alignment(0.0, 2.5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 80,
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Center(
                      child: ListTile(
                        leading: Column(
                          children: const [
                            Text(
                              'Available Balance',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '\$ 2000.23',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            )
                          ],
                        ),
                        trailing: Image.asset(
                          'assets/wallet/Group 1473.png',
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
        child: Column(
          children: [
            const SizedBox(height: 60),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      changeTab(0);
                    },
                    child: const WalletTabs(
                      imageName: '898',
                      title: 'History',
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.grey,
                  ),
                  GestureDetector(
                    onTap: () {
                      changeTab(1);
                    },
                    child: const WalletTabs(
                      imageName: '1478',
                      title: 'Wallet',
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.grey,
                  ),
                  GestureDetector(
                    onTap: () {
                      changeTab(2);
                    },
                    child: const WalletTabs(
                      imageName: '1481',
                      title: 'Spent Analysis',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(child: getTabDetails(context))
          ],
        ),
      ),
      // TODO: This needs to be made functional currently copied it from newhomeview.dart
      // bottomNavigationBar: selectedTab == 0
      //     ? BottomAppBar(
      //         notchMargin: 30.0,
      //         // clipBehavior: Clip.antiAlias,
      //         shape: const CircularNotchedRectangle(),
      //         color: kMainColor,
      //         child: SizedBox(
      //           height: 60,
      //           child: Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
      //             child: Row(
      //               // crossAxisAlignment: CrossAxisAlignment.center,
      //               mainAxisSize: MainAxisSize.max,
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [
      //                 GestureDetector(
      //                   onTap: () {
      //                     // hintText = ;
      //                     // setState(() {
      //                     //   Constants.selectedInd = 0;
      //                     //
      //                     // });
      //                   },
      //                   behavior: HitTestBehavior.opaque,
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       // Icon(
      //                       //   Icons.home,
      //                       //   color: (Constants.selectedInd == 0)
      //                       //       ? kMainColor
      //                       //       : kMainTextColor,
      //                       // ),
      //                       Image.asset(
      //                         'assets/ic_home.png',
      //                         width: 20,
      //                         height: 20,
      //                         color: (Constants.selectedInd == 0)
      //                             ? kWhiteColor
      //                             : kNavigationButtonColor,
      //                       ),
      //                       Text(
      //                         "Home",
      //                         style: TextStyle(
      //                             color: (Constants.selectedInd == 0)
      //                                 ? kWhiteColor
      //                                 : kNavigationButtonColor),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //                 GestureDetector(
      //                   onTap: () {
      //                     // searchP.emitSearchNull();
      //
      //                     // hintText = ;
      //                     // setState(() {
      //                     //   Constants.selectedInd = 2;
      //                     // });
      //                   },
      //                   behavior: HitTestBehavior.opaque,
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       // Icon(
      //                       //   Icons.search,
      //                       //   color: (Constants.selectedInd == 2)
      //                       //       ? kMainColor
      //                       //       : kMainTextColor,
      //                       // ),
      //                       Image.asset(
      //                         'assets/ic_order.png',
      //                         width: 20,
      //                         height: 20,
      //                         color: (Constants.selectedInd == 1)
      //                             ? kWhiteColor
      //                             : kNavigationButtonColor,
      //                       ),
      //
      //                       Text(
      //                         "Order",
      //                         style: TextStyle(
      //                             color: (Constants.selectedInd == 1)
      //                                 ? kWhiteColor
      //                                 : kNavigationButtonColor),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //                 const SizedBox(width: 10),
      //                 GestureDetector(
      //                   onTap: () {
      //                     // Navigator.of(context)
      //                     //     .pushNamed(PageRoutes.yourbasket)
      //                     //     .then((value) {
      //                     //   navBottomProvider.hitBottomNavigation(
      //                     //       0,
      //                     //       appbarTitle,
      //                     //       '${locale.searchOnGoGrocer}$appname');
      //                     //   // hintText = ;
      //                     // });
      //
      //                     // setState(() {
      //                     //   // Constants.selectedInd = 0;
      //                     // });
      //                   },
      //                   behavior: HitTestBehavior.opaque,
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       BlocBuilder<CartCountProvider, int>(
      //                           builder: (context, cartCount) {
      //                         // return Badge(
      //                         //   padding: const EdgeInsets.all(5),
      //                         //   animationDuration:
      //                         //       const Duration(milliseconds: 300),
      //                         //   animationType: BadgeAnimationType.slide,
      //                         //   badgeContent: Text(
      //                         //     cartCount.toString(),
      //                         //     style: TextStyle(
      //                         //         color: kWhiteColor, fontSize: 10),
      //                         //   ),
      //                         //   child:
      //                         return Padding(
      //                           padding: const EdgeInsets.only(left: 30.0),
      //                           child: Image.asset(
      //                             'assets/ic_wallet.png',
      //                             width: 20,
      //                             height: 20,
      //                             color: (Constants.selectedInd == 2)
      //                                 ? kWhiteColor
      //                                 : kNavigationButtonColor,
      //
      //                             // Icon(
      //                             //   Icons.shopping_basket,
      //                             //   color: kMainTextColor,
      //                             // ),
      //                           ),
      //                         );
      //                       }),
      //                       Padding(
      //                         padding: const EdgeInsets.only(left: 30.0),
      //                         child: Text(
      //                           "Wallet",
      //                           style: TextStyle(
      //                             color: (Constants.selectedInd == 2)
      //                                 ? kWhiteColor
      //                                 : kNavigationButtonColor,
      //                           ),
      //                         ),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //                 GestureDetector(
      //                   onTap: () {
      //                     // if (Constants.selectedInd != 0 &&
      //                     //     Constants.selectedInd != 1 &&
      //                     //     Constants.selectedInd != 2 &&
      //                     //     Constants.selectedInd != 3) {
      //                     //   cartCountP.hitCounter();
      //                     // }
      //                   },
      //                   behavior: HitTestBehavior.opaque,
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       // Icon(
      //                       //   Icons.account_box_outlined,
      //                       //   color: (Constants.selectedInd == 3)
      //                       //       ? kMainColor
      //                       //       : kMainTextColor,
      //                       // ),
      //                       Image.asset(
      //                         'assets/ic_account.png',
      //                         width: 20,
      //                         height: 20,
      //                         color: (Constants.selectedInd == 3)
      //                             ? kWhiteColor
      //                             : kNavigationButtonColor,
      //                       ),
      //
      //                       Text(
      //                         "Account",
      //                         style: TextStyle(
      //                             color: (Constants.selectedInd == 3)
      //                                 ? kWhiteColor
      //                                 : kNavigationButtonColor),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       )
      //     : null,
      // // TODO: This needs to be set copied it from newhomeview.dart
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: selectedTab == 0
      //     ? Transform.translate(
      //         offset: const Offset(0.0, 10.0),
      //         child: SizedBox(
      //           height: 70.0,
      //           width: 70.0,
      //           child: FittedBox(
      //             child: FloatingActionButton(
      //               backgroundColor: kTransparentColor,
      //               onPressed: () => Navigator.of(context).push(
      //                 MaterialPageRoute(
      //                   builder: (context) => YourBasket(),
      //                 ),
      //               ),
      //               child: Image.asset(
      //                 'assets/ic_floating.png',
      //               ),
      //             ),
      //           ),
      //         ),
      //       )
      //     : null,
    );
  }

  Widget getTabDetails(BuildContext context) {
    if (selectedTab == 0) {
      return Container(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0), child: getHistory());
    } else if (selectedTab == 1) {
      return Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: getWalletTab(context));
    } else {
      return Container(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: getSpentAnalysisTab());
    }
  }
}

Widget getHistory() {
  return ListView.separated(
    itemBuilder: (context, index) {
      if (index == 0 || index == 4) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Text(
            'January 2022',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      } else {
        return ListTile(
          leading: const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/wallet/Group 1482.png'),
          ),
          title: const Text('Money added to'),
          subtitle: const Text('30 Jan,5:30 PM'),
          trailing: SizedBox(
            height: 70,
            width: 100,
            child: Column(
              children: [
                const Text(
                  '\$ 1014.23',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: const [
                    Text(
                      'Successful',
                      style: TextStyle(color: Colors.green),
                    ),
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      color: Colors.green,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }
    },
    itemCount: 8,
    separatorBuilder: (BuildContext context, int index) {
      if (index == 0 || index == 3 || index == 4) {
        return Container();
      } else {
        return const Divider(
          thickness: 1,
        );
      }
    },
  );
}

Widget getWalletTab(BuildContext context) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey[300])),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: Image.asset(
              'assets/rupee.png',
              height: 20,
              width: 20,
            ),
            hintText: 'Enter Your Amount',
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      SizedBox(
        height: 50,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 40,
              child: Chip(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey[300], width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(5),
                label: Text(
                  '\u{20B9} ${500 * (index + 1)}',
                  style: TextStyle(color: Colors.green[800], fontSize: 14),
                ),
                // avatar: Icon(
                //   Icons.calendar_today,
                //   size: 15,
                //   color: Colors.green[800],
                // ),
              ),
            );
          },
          itemCount: 5,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 5,
            );
          },
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            child: const Text("Make Payment",
                style: TextStyle(fontSize: 16, color: Colors.white)),
            style: ButtonStyle(

                // foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(kMainColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ))),
            onPressed: () => null),
      )
    ],
  );
}

Widget getSpentAnalysisTab() {
  return ListView.separated(
    itemBuilder: (context, index) {
      return const ListTile(
        leading: Text(
          '#FGH456X',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          '\$1014.23',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    },
    itemCount: 8,
    separatorBuilder: (BuildContext context, int index) {
      return const Divider(
        thickness: 1,
      );
    },
  );
}

class WalletTabs extends StatelessWidget {
  final String imageName;
  final String title;
  const WalletTabs({
    Key key,
    this.imageName,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/wallet/Group $imageName.png'),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(title),
      ],
    );
  }
}
