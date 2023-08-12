// import 'package:audioplayers/audioplayers.dart' as audio;
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import '../../../utils/app_imports/app_imports.dart';

// class ScheduleVideoPlayer extends StatefulWidget {
//   const ScheduleVideoPlayer({super.key});

//   @override
//   State<ScheduleVideoPlayer> createState() => _ScheduleVideoPlayerState();
// }

// class _ScheduleVideoPlayerState extends State<ScheduleVideoPlayer> {
//   double containerHeight = 0.4;
//   // Initial height
//   HomeController homeController = Get.find();
//   OnGoingWorkoutController onGoingWorkoutController =
//       Get.put(OnGoingWorkoutController());
//   YoutubePlayerController? _controller;
//   bool _isFullScreen = false;
//   String videoId = '';

//   int totalYogaMinutes =
//       0; // Replace 100 with your desired total number of minutes
//   int yogaHours = 0;
//   int yogaMinutes = 0;
//   int yogaSeconds = 0;

//   int totalSavasanaMinutes =
//       0; // Replace 100 with your desired total number of minutes
//   int savasanaHours = 0;
//   int savasanaMinutes = 0;
//   int savasanaSeconds = 0;
//   Timer? countdownTimer;
//   Timer? secondTimer;
//   bool isVideoPlaying = false;
//   final musicplayer = audio.AudioPlayer();
//   String? audioType;
//   String? completedTime;

//   @override
//   void initState() {
//     audioType = Get.arguments['audiotype'];
//     totalYogaMinutes = int.parse(Get.arguments['selectedTime']);
//     playMusic();
//     totalSavasanaMinutes =
//         int.parse(Get.arguments['savasanaTime'].toString().split(' ').first);
//     videoId = YoutubePlayer.convertUrlToId(Get.arguments['videoLink'])!;
//     print("video $videoId");
//     _controller = YoutubePlayerController(
//       initialVideoId: videoId,
//       flags: YoutubePlayerFlags(
//         autoPlay: true,
//         mute: onGoingWorkoutController.getVideoMute,
//         hideControls: true,
//       ),
//     );
//     yogaConvertMinutesToHoursMinutesSeconds();
//     savasanaConvertMinutesToHoursMinutesSeconds();

//     // _controller!.addListener(() {
//     //   if (_controller!.value.playerState == PlayerState.playing) {
//     //     setState(() {
//     //       isVideoPlaying = true;
//     //     });

//     //   } else {
//     //     setState(() {
//     //       isVideoPlaying = false;
//     //     });
//     //   }

//     // });
//     playMusic();
//     startCountdown();
//     // startCountdown();
//     super.initState();
//   }

//   playMusic() async {
//     musicplayer.play(audio.UrlSource(Get.arguments['audioLink']));
//     musicplayer.setReleaseMode(audio.ReleaseMode.loop);
//     await musicplayer.setVolume(0.5);
//   }

//   void yogaConvertMinutesToHoursMinutesSeconds() {
//     yogaHours = totalYogaMinutes ~/ 60;
//     int remainingMinutes = totalYogaMinutes % 60;
//     yogaMinutes = remainingMinutes;
//     yogaSeconds = 0;

//     completedTime =
//         '$yogaHours:${yogaMinutes.toString().padLeft(2, '0')}:${yogaSeconds.toString().padLeft(2, '0')}';
//   }

//   void savasanaConvertMinutesToHoursMinutesSeconds() {
//     savasanaHours = totalSavasanaMinutes ~/ 60;
//     int remainingMinutes = totalSavasanaMinutes % 60;
//     savasanaMinutes = remainingMinutes;
//     savasanaSeconds = 0;
//   }

//   void startCountdown() {
//     const oneSecond = Duration(seconds: 1);
//     countdownTimer = Timer.periodic(oneSecond, (Timer t) {
//       setState(() {
//         if (totalYogaMinutes > 0) {
//           if (yogaSeconds > 0) {
//             yogaSeconds--;
//           } else {
//             if (yogaMinutes > 0) {
//               yogaMinutes--;
//               yogaSeconds = 59;
//             } else {
//               if (yogaHours > 0) {
//                 yogaHours--;
//                 yogaMinutes = 59;
//                 yogaSeconds = 59;
//               } else {
//                 _controller!.pause();
//                 startSecondTimer(); // Start the second timer function here
//                 t.cancel(); // Stop the countdown timer when the countdown reaches 00:00:00
//               }
//             }
//           }
//         } else {
//           t.cancel(); // Stop the timer when the countdown reaches 0 (or any other condition you desire)
//         }
//       });
//     });
//   }

//   void startSecondTimer() {
//     const twoSeconds = Duration(seconds: 1);
//     secondTimer = Timer.periodic(twoSeconds, (Timer t) {
//       setState(() {
//         if (totalSavasanaMinutes > 0) {
//           if (savasanaSeconds > 0) {
//             savasanaSeconds--;
//           } else {
//             if (savasanaMinutes > 0) {
//               savasanaMinutes--;
//               savasanaSeconds = 59;
//             } else {
//               if (savasanaHours > 0) {
//                 savasanaHours--;
//                 savasanaMinutes = 59;
//                 savasanaSeconds = 59;
//               } else {
//                 t.cancel(); // Stop the second timer when the countdown reaches 00:00:00
//                 musicplayer.pause();
//                 musicplayer.stop();
//                 Get.toNamed(Routes.resultView, arguments: {
//                   'yogaStatus': true,
//                   'WarkoutTime': Get.arguments['selectedTime'],
//                 });
//                 onGoingWorkoutController.setUserProgress(
//                   sessionDuration: completedTime,
//                   sessionStatus: SessionStatus.complete.name,
//                 );
//               }
//             }
//           }
//         } else {
//           print('Starting else');
//           t.cancel(); // Stop the second timer when the countdown reaches 0 (or any other condition you desire)
//         }
//       });
//     });
//   }

//   void pauseTimer() {
//     if (countdownTimer != null && !onGoingWorkoutController.getTimerPaused) {
//       countdownTimer!.cancel();
//       onGoingWorkoutController.setTimerPaused = true;
//     }
//   }

//   void resumeTimer() {
//     if (onGoingWorkoutController.getTimerPaused) {
//       startCountdown();
//       onGoingWorkoutController.setTimerPaused = false;
//     }
//   }

//   @override
//   void dispose() {
//     secondTimer?.cancel();
//     countdownTimer?.cancel();
//     musicplayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: AppColors.Green,
//       body: WillPopScope(
//         onWillPop: willPopScope,
//         child: BGDarkCoverImage(
//             image: AppImages.homeImageNetwork,
//             child: Stack(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Visibility(
//                       visible: onGoingWorkoutController.getVideoFullScreen
//                           ? false
//                           : true,
//                       child: PrimaryAppBar(
//                         titleText: 'Love',
//                         appbarColor: AppColors.TRANSPARENT_COLOR,
//                         titleColor: AppColors.WHITE_COLOR,
//                         isSuffix: false,
//                         isPrefix: false,
//                         prefixButtonColor: AppColors.TRANSPARENT_COLOR,
//                       ),
//                     ),
//                     Stack(
//                       children: [
//                         YoutubePlayerBuilder(
//                           player: YoutubePlayer(
//                             controller: _controller!,
//                             showVideoProgressIndicator: false,
//                             progressIndicatorColor: AppColors.PRIMARY_COLOR,
//                             progressColors: ProgressBarColors(
//                               playedColor: AppColors.PRIMARY_COLOR,
//                               handleColor: AppColors.PRIMARY_COLOR,
//                             ),
//                             onReady: () {
//                               _controller!.addListener(() {});
//                             },
//                           ),
//                           builder: (context, player) {
//                             return Container(
//                               width: Get.width, //double.infinity,
//                               height:
//                                   !onGoingWorkoutController.getVideoFullScreen
//                                       ? Get.height * 0.4
//                                       : Get.height,
//                               child: player,
//                             );
//                           },
//                         ),
//                         Positioned(
//                             bottom: 15,
//                             right: 60,
//                             child: Obx(() => GestureDetector(
//                                   onTap: () {
//                                     if (onGoingWorkoutController.getVideoMute ==
//                                         true) {
//                                       onGoingWorkoutController.setVideoMute =
//                                           false;
//                                       _controller!.unMute();
//                                     } else {
//                                       onGoingWorkoutController.setVideoMute =
//                                           true;
//                                       _controller!.mute();
//                                     }
//                                   },
//                                   child: Icon(
//                                     onGoingWorkoutController.getVideoMute
//                                         ? Icons.volume_off_rounded
//                                         : Icons.volume_up,
//                                     color: AppColors.WHITE_COLOR,
//                                   ),
//                                 ))),
//                         Positioned(
//                             bottom: 15,
//                             right: 20,
//                             child:
//                                 //  Obx(() =>

//                                 GestureDetector(
//                               onTap: () {
//                                 if (onGoingWorkoutController
//                                         .getVideoFullScreen ==
//                                     true) {
//                                   onGoingWorkoutController.setVideoFullScreen =
//                                       false;
//                                   _controller!.toggleFullScreenMode();
//                                 } else {
//                                   onGoingWorkoutController.setVideoFullScreen =
//                                       true;
//                                   _controller!.toggleFullScreenMode();
//                                 }
//                               },
//                               child: Icon(
//                                 Icons.screen_rotation_outlined,
//                                 color: AppColors.WHITE_COLOR,
//                               ),
//                             )
//                             // )
//                             )
//                       ],
//                     ),
//                   ],
//                 ),
//                 Visibility(
//                   visible: onGoingWorkoutController.getVideoFullScreen
//                       ? false
//                       : true,
//                   child: Positioned(
//                     bottom: 0,
//                     top: 0,
//                     right: 0,
//                     left: 0,
//                     child: DraggableScrollableSheet(
//                       initialChildSize: 0.5,
//                       maxChildSize: 0.5,
//                       minChildSize: 0.5,
//                       builder: (context, scrollController) {
//                         return AnimatedContainer(
//                           duration: const Duration(milliseconds: 200),
//                           curve: Curves.easeInOut,
//                           height: Get.height * containerHeight,
//                           width: Get.width,
//                           padding: AppPaddings.defaultPadding,
//                           decoration: BoxDecoration(
//                             borderRadius: AppBorderRadius.BORDER_RADIUS_10,
//                             color: AppColors.BLACK.withOpacity(0.4),
//                           ),
//                           child: SingleChildScrollView(
//                             controller: scrollController,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 vSizedBox(height: 10),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       width: 40,
//                                       height: 8,
//                                       decoration: BoxDecoration(
//                                         color: AppColors.GRAY,
//                                         borderRadius:
//                                             AppBorderRadius.BORDER_RADIUS_30,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 vSizedBox(height: 8),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     workoutTimeWigdet(
//                                         title: 'workoutTime'.tr,
//                                         time:
//                                             '$yogaHours:${yogaMinutes.toString().padLeft(2, '0')}:${yogaSeconds.toString().padLeft(2, '0')}'),
//                                     workoutTimeWigdet(
//                                         title: 'shavasanaTime'.tr,
//                                         time:
//                                             '$savasanaHours:${savasanaMinutes.toString().padLeft(2, '0')}:${savasanaSeconds.toString().padLeft(2, '0')}',
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end)
//                                   ],
//                                 ),
//                                 vSizedBox(height: 32),
//                                 AppText(
//                                     text: 'selectmusic'.tr,
//                                     size: AppDimensions.FONT_SIZE_18,
//                                     color: AppColors.WHITE_COLOR),
//                                 vSizedBox(),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     AppText(
//                                         text: audioType!,
//                                         size: AppDimensions.FONT_SIZE_18,
//                                         color: AppColors.PRIMARY_COLOR),
//                                     InkWell(
//                                       onTap: () {
//                                         if (onGoingWorkoutController
//                                             .getMusicPlaying) {
//                                           musicplayer.pause();

//                                           onGoingWorkoutController
//                                               .setMusicPlaying = false;
//                                         } else {
//                                           musicplayer.resume();

//                                           onGoingWorkoutController
//                                               .setMusicPlaying = true;
//                                         }
//                                       },
//                                       child: Obx(() => Icon(
//                                             onGoingWorkoutController
//                                                     .getMusicPlaying
//                                                 ? Icons.volume_up
//                                                 : Icons.volume_off,
//                                             color: AppColors.WHITE_COLOR,
//                                           )),
//                                     )
//                                   ],
//                                 ),
//                                 vSizedBox(height: 32),
//                                 AppButton(
//                                   buttonName:
//                                       onGoingWorkoutController.getTimerPaused ==
//                                               true
//                                           ? 'start'.tr
//                                           : 'stop'.tr,
//                                   buttonWidth: Get.width,
//                                   buttonColor: AppColors.PRIMARY_COLOR,
//                                   textColor: AppColors.WHITE_COLOR,
//                                   onTap: () {
//                                     if (_controller!.value.isPlaying &&
//                                         onGoingWorkoutController
//                                                 .getTimerPaused ==
//                                             false) {
//                                       _controller!.pause();
//                                       musicplayer.pause();
//                                       pauseTimer();
//                                     } else {
//                                       _controller!.play();
//                                       musicplayer.resume();
//                                       resumeTimer();
//                                     }
//                                     setState(() {});
//                                   },
//                                 ),
//                                 vSizedBox(height: 10),
//                                 AppButton(
//                                   buttonName: 'cancelTraining'.tr,
//                                   buttonWidth: Get.width,
//                                   buttonColor: AppColors.TRANSPARENT_COLOR,
//                                   textColor: AppColors.WHITE_COLOR,
//                                   onTap: () {
//                                     willPopScope();
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             )),
//       ),
//     );
//   }

//   workoutTimeWigdet(
//       {required title,
//       required String time,
//       CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start}) {
//     return Column(
//       crossAxisAlignment: crossAxisAlignment,
//       children: [
//         AppText(
//           text: title,
//           size: AppDimensions.FONT_SIZE_17,
//           fontWeight: FontWeight.w500,
//           color: AppColors.WHITE_COLOR,
//         ),
//         vSizedBox(height: 8),
//         AppText(
//           text: time,
//           size: AppDimensions.FONT_SIZE_24,
//           fontWeight: FontWeight.bold,
//           color: AppColors.PRIMARY_COLOR,
//         )
//       ],
//     );
//   }

//   Future<bool> willPopScope() async {
//     Get.bottomSheet(
//         Container(
//           padding: AppPaddings.defaultPadding,
//           decoration: BoxDecoration(
//               color: AppColors.WHITE_COLOR,
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(16),
//                 topRight: Radius.circular(16),
//               )),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               AppText(
//                 text: 'cancelTheTraining'.tr,
//                 fontWeight: FontWeight.w500,
//                 size: AppDimensions.FONT_SIZE_16,
//               ),
//               vSizedBox(),
//               Row(
//                 children: [
//                   Expanded(
//                     child: AppButton(
//                         buttonName: 'yes'.tr,
//                         buttonColor: AppColors.PRIMARY_COLOR,
//                         textColor: AppColors.WHITE_COLOR,
//                         onTap: () {
//                           Get.back();
//                           musicplayer.pause();
//                           musicplayer.stop();
//                           _controller!.pause();
//                           Get.toNamed(Routes.resultView, arguments: {
//                             'yogaStatus': false,
//                             'WarkoutTime':
//                                 '$yogaHours:${yogaMinutes.toString().padLeft(2, '0')}:${yogaSeconds.toString().padLeft(2, '0')}',
//                           });

//                           onGoingWorkoutController.setUserProgress(
//                               sessionDuration:
//                                   '$yogaHours:${yogaMinutes.toString().padLeft(2, '0')}:${yogaSeconds.toString().padLeft(2, '0')}',
//                               sessionStatus: SessionStatus.cancel.name);
//                         }),
//                   ),
//                   hSizedBox(),
//                   Expanded(
//                     child: AppButton(
//                         buttonName: 'no'.tr,
//                         buttonColor: AppColors.PRIMARY_COLOR,
//                         textColor: AppColors.WHITE_COLOR,
//                         onTap: () {
//                           Get.back();
//                         }),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//         isScrollControlled: true);
//     return Future.value(false);
//   }
// }
