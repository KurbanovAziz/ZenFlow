import '../../Utils/app_imports/app_imports.dart';
import '../Fonts/AppFonts.dart';

class ActivityTileWidget extends StatelessWidget {
  String userImage; // user image
  String otherProfileImage; // otherProfile image
  String name; // user name
  String comment; // comment data
  String time; // notification time
  String followButtonName; // when user follow other string change
  bool isComment; // if comment then show comment widget
  VoidCallback? profileTap; // user profile tap
  VoidCallback? followTap; // follow button tap
  VoidCallback? likeTap; // like button tap
  VoidCallback? commentTap; // reply/comment tap

  ActivityTileWidget({
    Key? key,
    this.userImage = '',
    this.otherProfileImage = '',
    this.name = '',
    this.comment = '',
    this.followButtonName = '',
    this.time = '',
    this.isComment = false,
    this.followTap,
    this.profileTap,
    this.likeTap,
    this.commentTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: profileTap,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        ),
        hSizedBox(width: Get.width * 0.02),
        Padding(
          padding: EdgeInsets.only(top: isComment ? 0 : 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width * 0.6,
                child: Wrap(
                  children: [
                    GestureDetector(
                      onTap: profileTap,
                      child: AppText(
                          text: "$name ",
                          color: AppColors.WHITE_COLOR.withOpacity(.6),
                          size: AppDimensions.FONT_SIZE_14,
                          fontWeight: FontWeights.medium),
                    ),
                    AppText(
                        text: isComment ? 'commented' : 'is following you',
                        color: AppColors.WHITE_COLOR,
                        size: AppDimensions.FONT_SIZE_14,
                        fontWeight: FontWeights.regular),
                  ],
                ),
              ),
              isComment
                  ? SizedBox(
                      width: Get.width * 0.6,
                      child: Wrap(
                        children: [
                          AppText(
                              text: comment,
                              color: AppColors.WHITE_COLOR,
                              size: AppDimensions.FONT_SIZE_14,
                              fontWeight: FontWeights.regular),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                height: Get.height * 0.002,
              ),
              isComment
                  ? SizedBox(
                      width: Get.width * 0.6,
                      child: Wrap(
                        children: [
                          AppText(
                              text: time,
                              color: AppColors.WHITE_COLOR.withOpacity(.6),
                              size: AppDimensions.FONT_SIZE_14,
                              fontWeight: FontWeights.regular),
                          SizedBox(
                            width: Get.width * 0.1,
                          ),
                          GestureDetector(
                            onTap: commentTap,
                            child: AppText(
                                text: 'Reply',
                                color: AppColors.WHITE_COLOR.withOpacity(.6),
                                size: AppDimensions.FONT_SIZE_14,
                                fontWeight: FontWeights.regular),
                          ),
                          SizedBox(
                            width: Get.width * 0.1,
                          ),
                          GestureDetector(
                            onTap: likeTap,
                            child: Icon(
                              Icons.favorite_border_rounded,
                              size: 18,
                              color: AppColors.WHITE_COLOR.withOpacity(.6),
                            ),
                          ),
                        ],
                      ),
                    )
                  : AppText(
                      text: time,
                      color: AppColors.WHITE_COLOR.withOpacity(.6),
                      size: AppDimensions.FONT_SIZE_14,
                      fontWeight: FontWeights.regular),
            ],
          ),
        ),
        const Spacer(),
        isComment
            ? ClipRRect(
                borderRadius: AppBorderRadius.BORDER_RADIUS_05,
                child: Image.network(
                  otherProfileImage,
                  fit: BoxFit.cover,
                  height: Get.height * 0.06,
                  width: Get.height * 0.06,
                ),
              )
            : InkWell(
                onTap: followTap,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.WHITE_COLOR,
                      borderRadius: AppBorderRadius.BORDER_RADIUS_30),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 8),
                    child: AppText(
                        text: followButtonName, fontWeight: FontWeights.medium),
                  ),
                ),
              )
      ],
    );
  }
}


// ActivityTileWidget(
// userImage: "https://picsum.photos/200/300?random=$index'",
// name: 'Nick John',
// time: '3.10',
// isComment: true,
// followButtonName: 'follow',
// comment: 'bjfjhkdgfjhdsgfjdgfhjdfdfdjfhdkbjfjhkdgfjhdsgfjdgfhjdfdfdjfhdkbjfjhkdgfjhdsgfjdgfhjdfdfdjfhdkbjfjhkdgfjhdsgfjdgfhjdfdfdjfhdkbjfjhkdgfjhdsgfjdgfhjdfdfdjfhdk',
// otherProfileImage:
// 'https://images.pexels.com/photos/2773977/pexels-photo-2773977.jpeg?auto=compress&cs=tinysrgb&w=1600',
// ),