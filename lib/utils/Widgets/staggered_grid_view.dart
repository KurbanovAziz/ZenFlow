import 'package:zen_flow/Utils/app_imports/app_imports.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class StaggeredGridScreen extends StatelessWidget {
  int index = 0;

  StaggeredGridScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(12),
        child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            itemCount: 100,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(
                      FullScreenImage(
                        imageUrl:
                            "https://picsum.photos/200/300?random=$index'",
                        // heroTag: "my_hero_tag",
                      ),
                      transition: Transition.size);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         FullScreenImage(
                  //             imageUrl: "https://picsum.photos/200/300?random=$index'",
                  //             heroTag: "my_hero_tag",
                  //         ),
                  //   ),
                  // );
                },
                child: Hero(
                  tag: "my_hero_tag",
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: "https://picsum.photos/200/300?random=$index'",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );

              // Container(
              //   decoration: const BoxDecoration(
              //       color: Colors.transparent,
              //       borderRadius: BorderRadius.all(Radius.circular(15))),
              //   child: ClipRRect(
              //     borderRadius: const BorderRadius.all(Radius.circular(15)),
              //     child: FadeInImage.memoryNetwork(
              //       placeholder: kTransparentImage,
              //       image: "https://picsum.photos/200/300?random=$index'",
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // );
            },
            staggeredTileBuilder: (index) {
              return StaggeredTile.count(1, index.isEven ? 1.2 : 1.6);
            }),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  // final String heroTag;

  FullScreenImage({
    super.key,
    required this.imageUrl,
    // required this.heroTag
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Navigator.pop(context);
        },
        child: Hero(
          tag: "my_hero_tag",
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            // color: Colors.black,
            child: Expanded(
              child: ZoomableImage(
                imageUrl: imageUrl,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ZoomableImage extends StatefulWidget {
  final String imageUrl;

  const ZoomableImage({super.key, required this.imageUrl});

  @override
  _ZoomableImageState createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _startingFocalPoint = Offset.zero;
  Offset _previousOffset = Offset.zero;
  Offset _offset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 2.0,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _startingFocalPoint = details.focalPoint;
    _previousOffset = _offset;
    _animationController.stop();
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    if (details.scale != 1.0) {
      double currentScale = _scale;
      double delta = details.scale - _previousScale;
      currentScale += delta;
      currentScale = currentScale.clamp(1.0, 2.0);
      setState(() {
        _scale = currentScale;
      });
      _previousScale = details.scale;
    }
    if (_scale != 1.0) {
      double deltaX = details.focalPoint.dx - _startingFocalPoint.dx;
      double deltaY = details.focalPoint.dy - _startingFocalPoint.dy;
      setState(() {
        _offset = Offset(
          _previousOffset.dx + deltaX / _scale,
          _previousOffset.dy + deltaY / _scale,
        );
      });
    }
  }

  void _handleScaleEnd(ScaleEndDetails details) {
    if (_scale < 1.0) {
      _scale = 1.0;
      _offset = Offset.zero;
    } else if (_scale > 2.0) {
      _scale = 2.0;
    }
    _previousOffset = _offset;
    _animationController.animateTo(_scale,
        duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _handleScaleStart,
      onScaleUpdate: _handleScaleUpdate,
      onScaleEnd: _handleScaleEnd,
      child: Center(
        child: Transform(
          transform: Matrix4.diagonal3Values(_scale, _scale, 1.0),
          alignment: FractionalOffset.center,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
