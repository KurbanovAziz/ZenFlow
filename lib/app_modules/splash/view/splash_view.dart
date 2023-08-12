import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zen_flow/Utils/app_imports/app_imports.dart';
import 'package:zen_flow/utils/constants/app_constants.dart';

import '../../../config/binding_routing/app_pages.dart';
import '../../authentication/sign_login_screen.dart/view/sign_login_screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  Future startAnimation() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(milliseconds: 3500));
    setState(() {
      animate = true;
    });

    await Future.delayed(const Duration(milliseconds: 3500));
    // Get.offAllNamed(Routes.loginView);
    if (prefs.getString(AppConstants.isLogin) == 'true') {
      Get.toNamed(Routes.homeView);
    } else {
      Get.to(LoginSignUpScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BGDarkCoverImage(
      image: AppImages.splashImageNetwork,
      child: Center(
        child: SvgPicture.asset(AppImages.logo),
      ),
    ));
  }
}
