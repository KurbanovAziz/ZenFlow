import 'package:transparent_image/transparent_image.dart';

import '../app_imports/app_imports.dart';

class BGDarkCoverImage extends StatelessWidget {
  BGDarkCoverImage(
      {Key? key, required this.child, this.image = '', this.colors})
      : super(key: key);
  Widget child;
  String image;
  Color? colors;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: Get.height,
            width: Get.width,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: image,
              fit: BoxFit.cover,
            )),
        Positioned(
            child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
              color: colors ??=
                  AppColors.PRIMARY_COLOR_OPACITY.withOpacity(.6)),
          child: child,
        ))
      ],
    );
  }
}
