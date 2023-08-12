import '../Fonts/AppFonts.dart';
import '../app_imports/app_imports.dart';

class UserProfileWidget extends StatelessWidget {
  String userName; // user profile name
  String follower; // user follower
  String following; // user following
  String about; // about user / bio
  String link; // any user link
  String buttonName; // follow button name
  String userProfileImage; // user profile image
  String userCoverImage; // user profile image
  VoidCallback? moreTap; // suffix tap
  VoidCallback? followButtonTap; // follow button tap

  UserProfileWidget(
      {Key? key,
      this.userName = '',
      this.follower = '',
      this.following = '',
      this.about = '',
      this.link = '',
      this.buttonName = '',
      this.userProfileImage = '',
      this.userCoverImage = '',
      this.moreTap,
      this.followButtonTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: Get.height * 0.45,
          child: Stack(
            children: [
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: Image.network(
                  userCoverImage,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  child: Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    end: const Alignment(0.0, -0),
                    begin: const Alignment(0.0, 0.9),
                    colors: <Color>[
                      AppColors.BLACK,
                      AppColors.BLACK.withOpacity(0.0)
                    ],
                  ),
                ),
                child: Container(),
              )),
            ],
          ),
        ),
        Positioned(
          child: Column(
            children: [
              PrimaryAppBar(
                appbarColor: AppColors.TRANSPARENT_COLOR,
                isCenter: true,
                isPrefix: false,
                isDivider: false,
                suffixOnTap: moreTap,
                titleText: userName,
                titleColor: AppColors.WHITE_COLOR,
                suffixPadding: 0,
                suffixButtonColor: AppColors.TRANSPARENT_COLOR,
                suffixIconColor: AppColors.WHITE_COLOR,
                suffixIconImage: AppImages.logo,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      AppText(
                          text: following,
                          color: AppColors.WHITE_COLOR,
                          fontWeight: FontWeights.medium,
                          size: AppDimensions.FONT_SIZE_18),
                      AppText(
                          text: 'following'.tr,
                          color: AppColors.WHITE_COLOR.withOpacity(.7),
                          fontWeight: FontWeights.regular,
                          size: AppDimensions.FONT_SIZE_16),
                    ],
                  ),
                  CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.TRANSPARENT_COLOR,
                      backgroundImage: NetworkImage(
                        userProfileImage,
                      )),
                  Column(
                    children: [
                      AppText(
                          text: follower,
                          color: AppColors.WHITE_COLOR,
                          fontWeight: FontWeights.medium,
                          size: AppDimensions.FONT_SIZE_18),
                      AppText(
                          text: 'follower'.tr,
                          color: AppColors.WHITE_COLOR.withOpacity(.7),
                          fontWeight: FontWeights.regular,
                          size: AppDimensions.FONT_SIZE_16),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: AppText(
                    textAlign: TextAlign.center,
                    text: about,
                    color: AppColors.WHITE_COLOR,
                    fontWeight: FontWeights.regular,
                    size: AppDimensions.FONT_SIZE_14),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.logo,
                    color: AppColors.WHITE_COLOR,
                    height: Get.height * 0.018,
                    width: Get.height * 0.017,
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  AppText(
                      textAlign: TextAlign.center,
                      text: link,
                      color: AppColors.WHITE_COLOR.withOpacity(.7),
                      fontWeight: FontWeights.regular,
                      size: AppDimensions.FONT_SIZE_14),
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              GestureDetector(
                onTap: followButtonTap,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.WHITE_COLOR,
                    borderRadius: AppBorderRadius.BORDER_RADIUS_30,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 8),
                    child: AppText(
                        text: buttonName,
                        color: AppColors.BLACK,
                        fontWeight: FontWeights.medium,
                        size: AppDimensions.FONT_SIZE_16),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

// UserProfileWidget(
// userName: 'Nick John',
// userCoverImage:
// 'https://images.pexels.com/photos/16209425/pexels-photo-16209425.jpeg?auto=compress&cs=tinysrgb&w=1600&lazy=load',
// userProfileImage:
// 'https://images.pexels.com/photos/838413/pexels-photo-838413.jpeg?auto=compress&cs=tinysrgb&w=1600',
// follower: '305',
// following: '1004',
// link: 'https://winnyrearie.ca',
// about:
// "Based in Toronto making fashion pictures for brands, magazine's and also, herself.",
// buttonName: 'Follow',
// moreTap: () {},
// followButtonTap: () {},
// ),
