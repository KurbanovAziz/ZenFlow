import 'package:flutter/material.dart';

class ContainerCorner extends StatelessWidget {
  final Function? onTap;
  final Function? onLongPress;
  final Function? onLongPressEnd;
  final Widget? child;
  final Color? color;
  final Color? shadowColor;
  final List<Color> colors;
  final Color? borderColor;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final double? borderWidth;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? marginAll;
  final Alignment? alignment;
  final double? marginTop;
  final double? marginLeft;
  final double? marginRight;
  final double? marginBottom;
  final double? radiusTopRight;
  final double? radiusBottomRight;
  final double? radiusTopLeft;
  final double? radiusBottomLeft;
  final double? blurRadius;
  final double? spreadRadius;
  final bool? setShadowToBottom;
  final double? shadowColorOpacity;
  final String? imageDecoration;
  final EdgeInsetsGeometry? padding;

  const ContainerCorner({
    Key? key,
    this.child,
    this.alignment,
    this.marginAll,
    this.marginTop = 0,
    this.marginLeft = 0,
    this.marginRight = 0,
    this.marginBottom = 0,
    this.imageDecoration,
    this.width,
    this.height,
    this.color,
    this.colors = const [Colors.transparent, Colors.transparent],
    this.shadowColor,
    this.borderColor = Colors.transparent,
    this.borderRadius,
    this.radiusTopRight = 0,
    this.radiusBottomRight = 0,
    this.radiusTopLeft = 0,
    this.radiusBottomLeft = 0,
    this.borderWidth = 1,
    this.blurRadius = 10,
    this.spreadRadius = 1,
    this.begin = Alignment.centerLeft, //Alignment.topCenter,
    this.end = Alignment.centerRight, //Alignment.bottomCenter,
    this.setShadowToBottom = false,
    this.onTap,
    this.onLongPress,
    this.onLongPressEnd,
    this.shadowColorOpacity = 1,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      onLongPress: onLongPress as void Function()?,
      onLongPressEnd: (long) => onLongPressEnd as void Function()?,
      child: Container(
        padding: padding,
        height: height,
        width: width,
        alignment: alignment,
        margin: EdgeInsets.only(
            left: marginAll != null ? marginAll! : marginLeft!,
            top: marginAll != null ? marginAll! : marginTop!,
            bottom: marginAll != null ? marginAll! : marginBottom!,
            right: marginAll != null ? marginAll! : marginRight!),
        decoration: BoxDecoration(
          image: imageDecoration != null
              ? DecorationImage(
                  fit: BoxFit.cover, image: AssetImage(imageDecoration!))
              : null,
          color: color != null ? color! : null,
          gradient: color != null
              ? null
              : LinearGradient(
                  colors: colors,
                  begin: begin,
                  end: end,
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: shadowColor != null
                    ? shadowColor!.withOpacity(shadowColorOpacity!)
                    : Colors.transparent,
                blurRadius: blurRadius!,
                spreadRadius: spreadRadius!,
                offset: setShadowToBottom!
                    ? const Offset(0, 5)
                    : const Offset(0.0, 0.75) //offset: Offset(0,10),
                )
          ],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(
                  borderRadius != null ? borderRadius! : radiusTopRight!),
              bottomRight: Radius.circular(
                  borderRadius != null ? borderRadius! : radiusBottomRight!),
              topLeft: Radius.circular(
                  borderRadius != null ? borderRadius! : radiusTopLeft!),
              bottomLeft: Radius.circular(
                  borderRadius != null ? borderRadius! : radiusBottomLeft!)),
          border: Border.all(
            width: borderWidth!,
            color: borderColor!,
          ),
        ),
        child: child,
      ),
    );
  }
}
