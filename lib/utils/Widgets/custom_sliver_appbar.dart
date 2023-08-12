import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../Themes/AppTheme.dart';

class CustomSliverAppBar extends StatelessWidget {
  final Widget screen;
  Widget child;
  final int selectedIndex;
  final List<String> iconNames;
  final List<Function> onTapFunctions;

  CustomSliverAppBar(
      {this.child = const SizedBox(),
      required this.screen,
      Key? key,
      required this.selectedIndex,
      required this.iconNames,
      required this.onTapFunctions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackOnPrimary,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverFillRemaining(
            child: screen,
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverPersistentHeader(
      delegate: GlassAppBarDelegate(
        selectedIndex,
        iconNames,
        onTapFunctions,
        child: child,
      ),
      pinned: true,
    );
  }
}

class GlassAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight = 130.0;
  final double minHeight = 60.0;
  Widget child;
  final int selectedIndex;
  final List<String> iconNames;
  final List<Function> onTapFunctions;

  GlassAppBarDelegate(this.selectedIndex, this.iconNames, this.onTapFunctions,
      {required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.black.withOpacity(0.8),
              ],
            ),
          ),
          height: ui.lerpDouble(maxHeight, minHeight, shrinkOffset / maxHeight),
        ),
        Positioned(
          top: ui.lerpDouble(60, 50, shrinkOffset / maxHeight),
          left: 0,
          right: 0,
          child: child,
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(.8),
                    Colors.black.withOpacity(.8),
                  ],
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                ),
                color: Colors.black.withOpacity(.8),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    iconNames.length,
                    (index) => InkWell(
                      onTap: () => onTapFunctions[index](),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? theme.primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          IconData(
                            int.parse(iconNames[index]),
                            fontFamily: 'MaterialIcons',
                          ),
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ),
                  )),
            ))
      ],
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
