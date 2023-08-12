// ignore_for_file: file_names, avoid_print, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSlider extends StatefulWidget {
  final double height;
  final double width;
  final double aspectRatio;
  final List imageList;
  final int autoPlayInterval;
  final int autoPlayAnimationDuration;
  final bool autoPlay;
  final bool pauseAutoPlayInFiniteScroll;
  final double borderRadius;

  AppSlider({
    Key? key,
    this.borderRadius = 20,
    this.height = 200,
    this.aspectRatio = 16 / 9,
    this.width = 150,
    this.autoPlayInterval = 2,
    required this.imageList,
    this.autoPlayAnimationDuration = 800,
    this.autoPlay = true,
    this.pauseAutoPlayInFiniteScroll = false,
  }) : super(key: key);

  @override
  State<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    print("productImage:   ${widget.imageList}");
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: widget.height,
                  //  aspectRatio: widget.aspectRatio,
                  disableCenter: false,
                  viewportFraction: 1,
                  initialPage: selectedIndex,
                  enableInfiniteScroll: false,
                  pauseAutoPlayInFiniteScroll:
                      widget.pauseAutoPlayInFiniteScroll,
                  reverse: false,
                  autoPlay: widget.autoPlay,
                  autoPlayInterval: Duration(seconds: widget.autoPlayInterval),
                  autoPlayAnimationDuration:
                      Duration(milliseconds: widget.autoPlayAnimationDuration),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value, chnage) {
                    setState(() {
                      print(value);
                      selectedIndex = value;
                    });
                  }),
              items: widget.imageList
                  .map(
                    (item) => ClipRRect(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      child: CachedNetworkImage(
                        imageUrl: "${item}",
                        width: Get.width * 0.9,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress)),
                        errorWidget: (context, url, error) => Container(),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
        // DotsIndicator(
        //   dotsCount: widget.imageList.length,
        //   position: double.parse('$selectedIndex'),
        //   decorator: DotsDecorator(
        //     color: AppColors.GRAY, // Inactive color
        //     activeColor: AppColors.PRIMARY_COLOR,
        //   ),
        // ),
      ],
    );
  }
}
