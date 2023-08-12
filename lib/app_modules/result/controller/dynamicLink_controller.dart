import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'package:flutter_share/flutter_share.dart';
import 'package:share_plus/share_plus.dart';
import '../../../utils/app_imports/app_imports.dart';

class DynamicController extends GetxController {
  // bool _isCreatingLink = false;
  var isCreatingLink = true.obs;
  String kUriPrefix = 'https://zenflow.page.link';
  String link = 'https://owner.foodageapp.com/';

  // https://zenflow.page.link/post

  var isLoading = false.obs;

  // reportPost({
  //   String reportId = '',
  //   String postId = '',
  // }) async {
  //   debugPrint('-------report post request--------');

  //   isLoading(true);
  //   try {
  //     var response = await ApiManager().requestAPi(
  //       AppConstants.reportPostUrl,
  //       data: {
  //         'post_id': postId,
  //         'report_id': reportId,
  //       },
  //     );

  //     print('report post Response: $response');

  //     var jsonData = jsonDecode(response);

  //     if (jsonData['status']) {
  //       isLoading(false);
  //       Get.back();
  //       customToastView(title: '${jsonData['message']}');
  //     } else {
  //       isLoading(false);
  //       customToastView(title: '${jsonData['message']}');
  //     }

  //     // isPressing.value = false;
  //   } catch (e) {
  //     isLoading(false);
  //   } finally {
  //     Future.delayed(Duration(seconds: 3), () async {
  //       isLoading(false);
  //     });
  //   }
  // }

  var linkUrl = ''.obs;
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<void> buildDynamicLinks(
      String title, String resturantName, String image, String docId) async {
    print("buildDynamicLinks data");
    print("title: $title");
    print("resturantName: $resturantName");
    print(
        "image url: ${Uri.parse(/*'https://cdn2.hubspot.net/hubfs/53/parts-url.jpg'*/
            Uri.encodeFull("$image"))}");
    print("docId: $docId");
    print("buildDynamicLinks link: $link$docId&efr=1");
    // String url = "http://osam.page.link";
//image='https://imagedelivery.net/v63K3l_x0dOGnSbYKYmQrg/6db724eb-b6e4-4963-7ad2-a29152f46400/publics';
    print("buildDynamicLinks: ${Uri.parse('$link$docId')}");
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: kUriPrefix,
      link: Uri.parse('$link$docId&efr=1'),
      // link: Uri.parse(link),
      androidParameters: AndroidParameters(
        fallbackUrl: Uri.tryParse(
            'https://play.google.com/store/apps/details?id=com.digixvalley.foodage'),
        packageName: 'com.yoga.flow.workout.go.beginners.weight.loss.app',
        minimumVersion: 0,
      ),
      iosParameters: IOSParameters(
        appStoreId: Config.appleId,
        fallbackUrl: Uri.tryParse(
            'https://apps.apple.com/us/app/foodage-find-food-reviews/id1620709672'),
        bundleId: "com.yoga.flow.workout.go.beginners.weight.loss.app",
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
          description: resturantName,
          imageUrl: Uri.parse(Uri.encodeFull("$image")),
          // : Uri.parse(
          //     'https://firebasestorage.googleapis.com/v0/b/foodageapppro.appspot.com/o/FoodageLogo%2Flogo.png?alt=media&token=0dd896db-7ea6-4ff3-b853-6e11de6ffdc5'),
          title: title),
    );

    // final ShortDynamicLink dynamicUrl = await parameters.buildShortLink();

    final ShortDynamicLink dynamicUrl = await dynamicLinks.buildShortLink(
      parameters,
    );

    //final  dynamicLink= await dynamicLinks .buildLink(parameters);
    // url = shortLink.shortUrl;

    String? desc = dynamicUrl.shortUrl.toString();

    print("buildDynamicLinks  desc: ${desc}");

    await Share.share(
      desc,
      subject: title,
    );
  }

  // final postController = Get.put(NotificationController());

  Future<void> initDynamicLinks(BuildContext context) async {
    debugPrint('------------ initDynamicLinks -----------');

    // String link = 'https://dynamic-link-domain/ke2Qa';

    // final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getDynamicLink(Uri.parse(kUriPrefix));

    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      // Example of using the dynamic link to push the user to a different screen
      // Navigator.pushNamed(context, deepLink.path);

      debugPrint('initialLink Not null ${deepLink.path}');

      // final Uri? deeplink = dynamicLinkData.link;

      List<String> sepeatedLink = [];

      sepeatedLink.addAll(deepLink.path.split('/'));

      debugPrint("initialLink ${sepeatedLink[1]}");
      // await postController.getpostDetails(postId: sepeatedLink[1].toString());
      // Get.to(PostDetails(selectedIndex: 0, postId: sepeatedLink[1].toString()));
      // await postController.getPostsDetailApiRequest(sepeatedLink[1], context);
      return;
      // handleMyLink(deepLink);
    } else {
      debugPrint('initialLink null');
    }

    // if App is in Open listen will work to navigate
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
      // Navigator.pushNamed(context, dynamicLinkData.link.path);

      // debugPrint('onLink.listen: - ${dynamicLinkData.link.path}');

      debugPrint('FirebaseDynamicLinks onLink -  ${dynamicLinkData.link.path}');
      debugPrint(
          'FirebaseDynamicLinks onLink data -  ${dynamicLinkData.asMap()}');

      // final Uri? deeplink = dynamicLinkData.link;

      List<String> sepeatedLink = [];

      sepeatedLink.addAll(dynamicLinkData.link.path.split('/'));

      debugPrint("initialLink ${sepeatedLink[1]}");
      // await postController.getpostDetails(postId: sepeatedLink[1].toString());
      // debugPrint("post data: ${postController.postData}");
      // if (postController.postData != null) {
      //   // Get.to(
      //   //     PostDetails(selectedIndex: 0, postId: sepeatedLink[1].toString()));
      // }
      // await postController.getPostsDetailApiRequest(sepeatedLink[1], context);
      // return;
    }).onError((error) {
      // Handle errors

      print(
          " FirebaseDynamicLinks.instance.onLink.listen: ${error.toString()}");
    });
  }

  void handleMyLink(Uri url) {
    debugPrint('------------ handleMyLink -------------');

    List<String> sepeatedLink = [];

    /// osama.link.page/Hellow --> osama.link.page and Hellow
    sepeatedLink.addAll(url.path.split('/'));

    debugPrint("The Token that i'm interesed in is ${sepeatedLink[1]}");

    // Get.to(()=>Container();
  }

  // - updateUrl
  updateUrl(value) {
    linkUrl.value = value;
    update();
  }

  // - sharePost
  Future<void> sharePost() async {
    await FlutterShare.share(
      title: 'Foodage - Find Food Reviews',
      text: 'Foodage - Find Food Reviews',
      linkUrl: linkUrl.value.toString(),
    );
  }
}
