// import 'package:flutter/material.dart';
// import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
// import 'package:user/Theme/colors.dart';

// class TutorialOverlay extends ModalRoute<void> {
//   String image;

//   @override
//   Duration get transitionDuration => const Duration(milliseconds: 500);

//   @override
//   bool get opaque => false;

//   @override
//   bool get barrierDismissible => false;

//   @override
//   Color get barrierColor => Colors.black.withOpacity(0.5);

//   @override
//   String get barrierLabel => null;

//   @override
//   bool get maintainState => true;

//   @override
//   Widget buildPage(
//     BuildContext context,
//     Animation<double> animation,
//     Animation<double> secondaryAnimation,
//   ) {
//     // This makes sure that text and other content follows the material style
//     return Material(
//       type: MaterialType.transparency,
//       // make sure that the overlay content is not cut off
//       child: SafeArea(
//         child: _buildOverlayContent(context),
//       ),
//     );
//   }

//   Widget _buildOverlayContent(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: ImageSlideshow(
//           width: MediaQuery.of(context).size.width * 0.8,
//           height: 200,
//           initialPage: 0,
//           indicatorColor: kNavigationButtonColor,
//           indicatorBackgroundColor: kWhiteColor,
//           children: ['apiData.dataModel.banner']
//               .map(
//                 (BannerDataModel dataModel) => ClipRRect(
//                   borderRadius: BorderRadius.circular(5),
//                   child: CachedNetworkImage(
//                     imageUrl: '${dataModel.banner_image}',
//                     placeholder: (context, url) => Align(
//                       widthFactor: 50,
//                       heightFactor: 50,
//                       alignment: Alignment.center,
//                       child: Container(
//                         padding: const EdgeInsets.all(5.0),
//                         width: 50,
//                         height: 180,
//                         child: const Center(child: CircularProgressIndicator()),
//                       ),
//                     ),
//                     errorWidget: (context, url, error) => Image.asset(
//                       'assets/icon.png',
//                       fit: BoxFit.fill,
//                     ),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               )
//               .toList(),
//           onPageChanged: (value) {},
//           autoPlayInterval: 3000,
//           isLoop: true,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation, Widget child) {
//     // You can add your own animations for the overlay content
//     return FadeTransition(
//       opacity: animation,
//       child: ScaleTransition(
//         scale: animation,
//         child: child,
//       ),
//     );
//   }
// }
