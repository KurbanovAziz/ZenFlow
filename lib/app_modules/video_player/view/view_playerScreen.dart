// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:zen_flow/utils/app_imports/app_imports.dart';

// class VideoPlayerScreen extends StatefulWidget {
//   final String id;

//   VideoPlayerScreen({super.key, required this.id});
//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   YoutubePlayerController? _controller;
//   bool _isFullScreen = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: widget.id,
//       flags: const YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//       ),
//     );
//     // Set preferred orientations to landscape only
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//   }

//   @override
//   void dispose() {
//     // Reset preferred orientations when the screen is disposed
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: _isFullScreen ? null : AppBar(),
//       body: OrientationBuilder(
//         builder: (context, orientation) {
//           if (orientation == Orientation.landscape) {
//             _isFullScreen = true;
//             SystemChrome.setEnabledSystemUIOverlays([]);
//           } else {
//             _isFullScreen = false;
//             SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
//           }

//           return Stack(
//             children: [
//               YoutubePlayerBuilder(
//                 player: YoutubePlayer(
//                   controller: _controller!,
//                   showVideoProgressIndicator: true,
//                   progressIndicatorColor: AppColors.PRIMARY_COLOR,
//                   progressColors: ProgressBarColors(
//                     playedColor: AppColors.PRIMARY_COLOR,
//                     handleColor: AppColors.PRIMARY_COLOR,
//                   ),
//                   onReady: () {
//                     _controller!.addListener(() {});
//                   },
//                 ),
//                 builder: (context, player) {
//                   return Container(
//                     width: double.infinity,
//                     height: double.infinity,
//                     child: player,
//                   );
//                 },
//               ),
//               Positioned(
//                 top: _isFullScreen ? 16.0 : 20.0,
//                 left: _isFullScreen ? 16.0 : 10.0,
//                 child: _isFullScreen
//                     ? IconButton(
//                         icon: Icon(
//                           Icons.arrow_back,
//                           color: AppColors.WHITE_COLOR,
//                         ),
//                         onPressed: () {
//                           _exitFullScreen();
//                         },
//                       )
//                     : IconButton(
//                         icon: Icon(
//                           Icons.arrow_back,
//                           color: AppColors.WHITE_COLOR,
//                         ),
//                         onPressed: () {
//                           Get.back();
//                         },
//                       ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   void _exitFullScreen() {
//     setState(() {
//       _isFullScreen = false;
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.portraitUp,
//         DeviceOrientation.portraitDown,
//       ]);
//     });
//   }
// }
