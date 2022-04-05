import 'package:flutter/cupertino.dart';
import 'package:user/Pages/categorypage/view_all_categories.dart';

import 'Pages/About/about_us.dart';
import 'Pages/AccountPage/Coupons/coupon_page.dart';
import 'Pages/AccountPage/account_page.dart';
import 'Pages/AccountPage/refer_earn.dart';
import 'Pages/DrawerPages/my_orders_drawer.dart';
import 'Pages/Subscription/my_subscription_page.dart';
import 'Pages/User/wishlist.dart';
import 'Pages/wallet/new_wallet_ui.dart';

class Constants {
  static int selectedInd = 0;
  static List<String> iconArray = [
    'assets/DrawerIcon/all-category-icon.png',
    'assets/DrawerIcon/my-account.png',
    'assets/DrawerIcon/my-order.png',
    'assets/DrawerIcon/my-subscription.png',
    'assets/DrawerIcon/my-wallet.png',
    'assets/DrawerIcon/wishlist.png',
    'assets/DrawerIcon/coupan.png',
    'assets/DrawerIcon/membership.png',
    'assets/DrawerIcon/live-chat.png',
    'assets/DrawerIcon/refer-_-earn.png',
    'assets/DrawerIcon/about-us.png',
  ];

  static List<String> itemArray = [
    'All Categories',
    'My Account',
    'My Orders',
    'My Subscriptions',
    'My Wallet',
    'WishList',
    'Coupons',
    'Membership',
    'Live Chat',
    'Refer & Earn',
    'About Us'
  ];

  static List<Widget> routeArray = [
    const ViewAllCategory(),
    const AccountPage(),
    MyOrdersDrawer(),
    MySubscriptionPage(),
    NewWalletUI(),
    MyWishList(),
    CouponPage(),
    null,
    null,
    ReferAndEarn(),
    AboutUsPage(),
  ];
}
