// // ignore_for_file: avoid_print, unnecessary_brace_in_string_interps
//
// import 'dart:io';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
//
// import '../Themes/AppColors.dart';
//
// Widget customImage(
//     {required String imageUrl,
//     var radius = 10.0,
//     var width = 100.0,
//     var height = 100.0}) {
//   print('get image url this $imageUrl');
//   return imageUrl.contains('cache')
//       ? Container(
//           height: height,
//           width: width,
//           decoration: BoxDecoration(
//               border: Border.all(color: AppColors.WHITE_COLOR, width: 2),
//               color: AppColors.GRAY,
//               borderRadius: BorderRadius.circular(radius),
//               image: DecorationImage(
//                   image: FileImage(File(imageUrl)), fit: BoxFit.cover)),
//         )
//       : Container(
//           height: height,
//           width: width,
//           decoration: BoxDecoration(
//             border: Border.all(color: AppColors.WHITE_COLOR, width: 2),
//             color: AppColors.GRAY,
//             shape: radius == 100.0 ? BoxShape.circle : BoxShape.rectangle,
//             borderRadius:
//                 radius == 100.0 ? null : BorderRadius.circular(radius),
//             image: DecorationImage(
//               image: NetworkImage(imageUrl.contains('https')
//                   ? imageUrl
//                   : ApiConstant.img_base_url + imageUrl),
//               fit: BoxFit.cover,
//               onError: (exception, stackTrace) {
//                 print('error in image $exception');
//                 print('error in image ${stackTrace}');
//                 Image.asset(AppImages.clock);
//               },
//             ),
//           ),
//           // child: FittedBox(
//           //   child: ClipRRect(
//           //     borderRadius: ,
//           //     child: Image.network(ApiConstant.img_base_url + imageUrl)),
//           //   fit: BoxFit.fill,
//           // ),
//         );
// }
// // child: ClipRRect(
//           //   borderRadius: BorderRadius.circular(radius),
//           //   child: imageUrl.contains('cache')
//           //       ? Image.file(
//           //           File(
//           //             imageUrl,
//           //           ),
//           //           errorBuilder: (context, error, stackTrace) {
//           //             return takeHairLoading();
//           //           },
//           //           // frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
//           //           //   return Image.asset(AppImages.placeHolder);
//           //           // },
//           //           fit: BoxFit.cover,
//           //         )
//           //       : CachedNetworkImage(
//           //           imageUrl: ApiConstant.img_base_url + imageUrl,
//           //           fit: BoxFit.fill,
//           //           // progressIndicatorBuilder: (context, url, progress) {
//           //           //   return takeHairLoading();
//           //           // },
//           //           errorWidget: (context, url, error) {
//           //             return Image.asset(AppImages.placeHolder);
//           //           },
//           //           placeholder: (context, url) {
//           //             return Image.asset(AppImages.placeHolder);
//           //           },
//           //         ),
//           // ),
