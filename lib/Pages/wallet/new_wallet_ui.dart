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
    );
  }

  Widget getTabDetails(BuildContext context) {
    print('This is getting called');
    if (selectedTab == 0) {
      return Container(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0), child: getHistory());
    } else if (selectedTab == 1) {
      return Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: getWalletTab(context));
    } else {
      return Container();
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
