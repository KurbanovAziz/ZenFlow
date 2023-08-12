// import 'package:flutter/material.dart';
// import 'package:zen_flow/app_modules/video_player/controller/video_player_controller.dart';
// import 'package:zen_flow/app_modules/video_player/model/channel_model.dart';
// import 'package:zen_flow/app_modules/video_player/model/video_model.dart';
// import 'package:zen_flow/app_modules/video_player/view/view_playerScreen.dart';
// import 'package:zen_flow/utils/app_imports/app_imports.dart';

// class VideoPlayList extends StatefulWidget {
//   @override
//   _VideoPlayListState createState() => _VideoPlayListState();
// }

// class _VideoPlayListState extends State<VideoPlayList> {
//   Channel? _channel;
//   bool _isLoading = false;
//   final ScrollController _scrollController = ScrollController();
//   @override
//   void initState() {
//     super.initState();
//     _initChannel();
//     _scrollController.addListener(_scrollListener);
//   }

//   _initChannel() async {
//     Channel channel = await APIServiceForYoutube.instance
//         .fetchChannel(channelId: 'UCl0AUXMurZXQBA9tY6YMaWA');
//     setState(() {
//       _channel = channel;
//     });
//   }

//   // _buildProfileInfo() {
//   //   return Container(
//   //     margin: const EdgeInsets.all(20.0),
//   //     padding: const EdgeInsets.all(20.0),
//   //     height: 100.0,
//   //     decoration: const BoxDecoration(
//   //       color: Colors.white,
//   //       boxShadow: [
//   //         BoxShadow(
//   //           color: Colors.black12,
//   //           offset: Offset(0, 1),
//   //           blurRadius: 6.0,
//   //         ),
//   //       ],
//   //     ),
//   //     child: Row(
//   //       children: <Widget>[
//   //         CircleAvatar(
//   //           backgroundColor: Colors.white,
//   //           radius: 35.0,
//   //           backgroundImage: NetworkImage(_channel!.profilePictureUrl!),
//   //         ),
//   //         hSizedBox(),
//   //         Expanded(
//   //           child: Column(
//   //             mainAxisAlignment: MainAxisAlignment.center,
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: <Widget>[
//   //               AppText(
//   //                 text: _channel!.title!,
//   //                 fontWeight: FontWeight.w600,
//   //                 size: 20.0,
//   //               ),
//   //               AppText(
//   //                 text: '${_channel!.subscriberCount} subscribers',
//   //                 fontWeight: FontWeight.w600,
//   //                 size: 16.0,
//   //                 overflow: TextOverflow.ellipsis,
//   //               ),
//   //             ],
//   //           ),
//   //         )
//   //       ],
//   //     ),
//   //   );
//   // }

//   _buildVideo(Video video) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => VideoPlayerScreen(id: video.id!),
//           ),
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
//         padding: const EdgeInsets.all(10.0),
//         height: 110.0,
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               offset: Offset(0, 1),
//               blurRadius: 6.0,
//             ),
//           ],
//         ),
//         child: Row(
//           children: <Widget>[
//             Image(
//               width: 100.0,
//               image: NetworkImage(video.thumbnailUrl!),
//             ),
//             hSizedBox(),
//             Expanded(
//               child: AppText(
//                 text: video.title!,
//                 size: 14.0,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _scrollListener() {
//     if (!_isLoading &&
//         _channel!.videos!.length != int.parse(_channel!.videoCount!) &&
//         _scrollController.position.pixels ==
//             _scrollController.position.maxScrollExtent) {
//       _loadMoreVideos();
//     }
//   }

//   _loadMoreVideos() async {
//     _isLoading = true;
//     print('more videos');
//     List<Video> moreVideos = await APIServiceForYoutube.instance
//         .fetchVideosFromPlaylist(playlistId: _channel!.uploadPlaylistId);
//     List<Video> allVideos = _channel!.videos!..addAll(moreVideos);
//     setState(() {
//       _channel!.videos = allVideos;
//     });
//     _isLoading = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: AppText(
//             text: 'Yoga Playlist',
//             size: AppDimensions.FONT_SIZE_16,
//             fontWeight: FontWeight.w600),
//       ),
//       body: _channel != null
//           ?
//           //  NotificationListener<ScrollNotification>(
//           //     onNotification: (ScrollNotification scrollDetails) {
//           //       if (!_isLoading &&
//           //           _channel!.videos!.length !=
//           //               int.parse(_channel!.videoCount!) &&
//           //           scrollDetails.metrics.pixels ==
//           //               scrollDetails.metrics.maxScrollExtent) {
//           //         _loadMoreVideos();
//           //       }
//           //       return false;
//           //     },
//           //     child:
//           ListView.builder(
//               controller: _scrollController,
//               itemCount: _channel!.videos!.length,
//               itemBuilder: (BuildContext context, int index) {
//                 // if (index == 0) {
//                 //   return _buildProfileInfo();
//                 // }
//                 Video video = _channel!.videos![index];
//                 return _buildVideo(video);
//               },
//             )
//           // )
//           : Center(
//               child: CircularProgressIndicator(
//                 color: AppColors.PRIMARY_COLOR,
//               ),
//             ),
//     );
//   }
// }
