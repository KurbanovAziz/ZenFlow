library floating_frosted_bottom_bar;

import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

import '../../Utils/app_imports/app_imports.dart';

class AppBottomBarCall extends StatefulWidget {
  const AppBottomBarCall({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AppBottomBarCall> createState() => _AppBottomBarCallState();
}

class _AppBottomBarCallState extends State<AppBottomBarCall>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  final List<Color> colors = [
    Colors.purple,
    Colors.purple,
    Colors.purple,
    Colors.purple,
    Colors.purple
  ];

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 5, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: FrostedBottomBar(
        width: Get.width,
        height: Get.height * 0.1,
        bottom: 0,
        opacity: 0.6,
        sigmaX: 5,
        sigmaY: 5,
        borderRadius: BorderRadius.circular(0),
        duration: const Duration(milliseconds: 800),
        hideOnScroll: true,
        body: (context, controller) => TabBarView(
          controller: tabController,
          dragStartBehavior: DragStartBehavior.down,
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              height: 100,
              color: AppColors.WHITE_COLOR,
              child: ListView.builder(
                  controller: controller,
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        leading: const Icon(Icons.list),
                        trailing: const Text(
                          "GFG",
                          style: TextStyle(color: Colors.green, fontSize: 15),
                        ),
                        title: Text("List item $index"));
                  }),
            ),
            Container(
              height: 100,
              color: AppColors.PRIMARY_COLOR,
            ),
            Container(
              height: 100,
              color: AppColors.BLACK,
            ),
            Container(
              height: 100,
              color: AppColors.GRAY,
            ),
            Container(
              height: 100,
              color: AppColors.PRIMARY_COLOR,
            ),
          ],
        ),
        child: TabBar(
          indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          controller: tabController,
          indicatorColor: Colors.transparent,
          tabs: [
            TabsIcon(
                icons: Icons.home,
                name: 'Home',
                color: currentPage == 0 ? colors[0] : Colors.white),
            TabsIcon(
                icons: Icons.search,
                name: 'Explore',
                color: currentPage == 1 ? colors[1] : Colors.white),
            TabsIcon(
                icons: Icons.queue_play_next,
                name: 'Post',
                color: currentPage == 2 ? colors[2] : Colors.white),
            TabsIcon(
                icons: Icons.file_download,
                name: 'Activity',
                color: currentPage == 3 ? colors[3] : Colors.white),
            TabsIcon(
                icons: Icons.menu,
                name: 'Profile',
                color: currentPage == 4 ? colors[4] : Colors.white),
          ],
        ),
      ),
    );
  }
}

class TabsIcon extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final IconData icons;
  final String name;

  const TabsIcon(
      {Key? key,
      this.color = Colors.white,
      this.height = 60,
      this.width = 50,
      required this.icons,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icons,
              color: color,
            ),
            AppText(text: name, color: color, size: 12)
          ],
        ),
      ),
    );
  }
}

class FrostedBottomBar extends StatefulWidget {
  final Widget Function(BuildContext context, ScrollController controller) body;
  final Widget child;
  final Color bottomBarColor;
  final double end;
  final double start;
  final double bottom;
  final Duration duration;
  final Curve curve;
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final Alignment alignment;
  final Function()? onBottomBarShown;
  final Function()? onBottomBarHidden;
  final bool reverse;
  final bool scrollOpposite;
  final bool hideOnScroll;
  final StackFit fit;
  final double sigmaX;
  final double sigmaY;
  final double opacity;

  const FrostedBottomBar({
    required this.body,
    required this.child,
    this.bottomBarColor = Colors.black,
    this.end = 0,
    this.start = 2,
    this.bottom = 10,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.linear,
    this.width = 300,
    this.height = 70,
    this.borderRadius = BorderRadius.zero,
    this.alignment = Alignment.bottomCenter,
    this.onBottomBarShown,
    this.onBottomBarHidden,
    this.reverse = false,
    this.scrollOpposite = false,
    this.hideOnScroll = true,
    this.fit = StackFit.loose,
    this.sigmaX = 10,
    this.sigmaY = 10,
    this.opacity = 0.5,
    Key? key,
  }) : super(key: key);

  @override
  _FrostedBottomBarState createState() => _FrostedBottomBarState();
}

class _FrostedBottomBarState extends State<FrostedBottomBar>
    with SingleTickerProviderStateMixin {
  ScrollController scrollBottomBarController = ScrollController();
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late bool isScrollingDown;
  late bool isOnTop;

  @override
  void initState() {
    isScrollingDown = widget.reverse;
    isOnTop = !widget.reverse;
    myScroll();
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, widget.start),
      end: Offset(0, widget.end),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ))
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    _controller.forward();
  }

  void showBottomBar() {
    if (mounted) {
      setState(() {
        _controller.forward();
      });
    }
    if (widget.onBottomBarShown != null) widget.onBottomBarShown!();
  }

  void hideBottomBar() {
    if (mounted && widget.hideOnScroll) {
      setState(
        () {
          _controller.reverse();
        },
      );
    }
    if (widget.onBottomBarHidden != null) widget.onBottomBarHidden!();
  }

  Future<void> myScroll() async {
    scrollBottomBarController.addListener(() {
      if (!widget.reverse) {
        if (scrollBottomBarController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (!isScrollingDown) {
            isScrollingDown = true;
            isOnTop = false;
            hideBottomBar();
          }
        }
        if (scrollBottomBarController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (isScrollingDown) {
            isScrollingDown = false;
            isOnTop = true;
            showBottomBar();
          }
        }
      } else {
        if (scrollBottomBarController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!isScrollingDown) {
            isScrollingDown = true;
            isOnTop = false;
            hideBottomBar();
          }
        }
        if (scrollBottomBarController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (isScrollingDown) {
            isScrollingDown = false;
            isOnTop = true;
            showBottomBar();
          }
        }
      }
    });
  }

  @override
  void dispose() {
    scrollBottomBarController.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: widget.fit,
      alignment: widget.alignment,
      children: [
        BottomBarScrollControllerProvider(
          scrollController: scrollBottomBarController,
          child: widget.body(context, scrollBottomBarController),
        ),
        Positioned(
          bottom: widget.bottom,
          child: SlideTransition(
            position: _offsetAnimation,
            child: ClipRRect(
              borderRadius: widget.borderRadius,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: widget.sigmaX, sigmaY: widget.sigmaY),
                child: Opacity(
                  opacity: widget.opacity,
                  child: Container(
                    height: widget.height,
                    width: widget.width,
                    decoration: BoxDecoration(
                      color: widget.bottomBarColor,
                      borderRadius: widget.borderRadius,
                    ),
                    child: Material(
                      color: widget.bottomBarColor,
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BottomBarScrollControllerProvider extends InheritedWidget {
  final ScrollController scrollController;

  const BottomBarScrollControllerProvider({
    Key? key,
    required Widget child,
    required this.scrollController,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(BottomBarScrollControllerProvider oldWidget) =>
      scrollController != oldWidget.scrollController;

  static BottomBarScrollControllerProvider of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<BottomBarScrollControllerProvider>()!;
}
