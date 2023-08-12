import 'package:zen_flow/utils/app_imports/app_imports.dart';

import 'package:intl/intl.dart';

class CalenderScreen extends StatefulWidget {
  CalenderScreen({Key? key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  final GlobalKey<_CalendarState> _calendarKey = GlobalKey<_CalendarState>();
  late DateTime selectedMonth;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    selectedMonth = DateTime.now();
  }

  void onMonthChanged(DateTime newMonth) {
    setState(() {
      selectedMonth = newMonth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BGDarkCoverImage(
        image: AppImages.calenderNetwork,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryAppBar(
              titleText: 'workoutCalender'.tr,
              appbarColor: AppColors.TRANSPARENT_COLOR,
              titleColor: AppColors.WHITE_COLOR,
              isSuffix: false,
              prefixButtonColor: AppColors.TRANSPARENT_COLOR,
              prefixOnTap: () {
                Get.back();
              },
            ),
            Padding(
              padding: AppPaddings.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vSizedBox(),
                  Calendar(
                    selectedMonth: selectedMonth,
                    onMonthChanged: onMonthChanged,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Calendar extends StatefulWidget {
  final DateTime selectedMonth;
  final Function(DateTime) onMonthChanged;
  const Calendar({
    Key? key,
    required this.selectedMonth,
    required this.onMonthChanged,
  }) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  Calendercontroller calendercontroller = Get.put(Calendercontroller());
  late DateTime selectedDate;
  late DateTime currentMonth;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    currentMonth = DateTime(selectedDate.year, selectedDate.month, 1);
  }

  List<DateTime> getCalendarDays(DateTime month) {
    final List<DateTime> calendarDays = [];
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final numEmptyDays = (firstDayOfMonth.weekday - DateTime.sunday) % 7;
    final startDate = firstDayOfMonth.subtract(Duration(days: numEmptyDays));
    for (var i = 0; i < 42; i++) {
      calendarDays.add(startDate.add(Duration(days: i)));
    }
    return calendarDays;
  }

  void selectDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    if (date == selectedDate) {
      calendercontroller.setDateSelected = true;
    } else {
      calendercontroller.setDateSelected = false;
    }
  }

  Future<void> _showMonthYearPicker() async {
    final DateTime? pickedDate = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text(
                'Select Month and Year',
                style: TextStyle(color: Colors.black),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      DropdownButton<int>(
                        value: currentMonth.month,
                        onChanged: (int? month) {
                          if (month != null) {
                            setState(() {
                              currentMonth = DateTime(
                                currentMonth.year,
                                month,
                              );
                            });
                          }
                        },
                        items: [
                          for (var i = 1; i <= 12; i++)
                            DropdownMenuItem<int>(
                              value: i,
                              child: Text(
                                DateFormat('MMMM').format(
                                  DateTime(currentMonth.year, i),
                                ),
                              ),
                            ),
                        ],
                      ),
                      hSizedBox(width: 16),
                      DropdownButton<int>(
                        value: currentMonth.year,
                        onChanged: (int? year) {
                          if (year != null) {
                            setState(() {
                              currentMonth = DateTime(
                                year,
                                currentMonth.month,
                              );
                            });
                          }
                        },
                        items: [
                          for (var i = 2000; i <= 2100; i++)
                            DropdownMenuItem<int>(
                              value: i,
                              child: Text(i.toString()),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(currentMonth);
                    setState(() {});
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );

    if (pickedDate != null) {
      widget.onMonthChanged(DateTime(pickedDate.year, pickedDate.month, 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    final monthFormat = DateFormat('MMMM yyyy');
    final weekdayFormat = DateFormat('E');
    // Access the showMonthYearPicker function from the inherited widget

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Get.height * 0.78,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 05, horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: AppBorderRadius.BORDER_RADIUS_10,
                      color: AppColors.BLACK.withOpacity(0.3),
                    ),
                    child: InkWell(
                      onTap: _showMonthYearPicker,
                      child: Row(
                        children: [
                          AppText(
                            text: monthFormat.format(widget.selectedMonth),
                            size: AppDimensions.FONT_SIZE_16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.WHITE_COLOR,
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_drop_down_sharp,
                            color: AppColors.WHITE_COLOR,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.PRIMARY_COLOR,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                    ),
                    padding: const EdgeInsets.all(05),
                    child: Row(
                      children: [
                        for (var i = 0; i < 7; i++)
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                child: AppText(
                                  text: weekdayFormat.format(
                                    DateTime(2023, 1, i + 1),
                                  ),
                                  color: AppColors.WHITE_COLOR,
                                  size: AppDimensions.FONT_SIZE_14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('AllUserScheduleWorkOut')
                          .doc(
                              FirebaseAuth.instance.currentUser!.uid.toString())
                          .collection('SchedulesWorkOut')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.data == null) {
                          return const Center(child: Text(""));
                        }
                        List<String> scheduleDate = [];
                        for (var index = 0;
                            index < snapshot.data!.docs.length;
                            index++) {
                          if (!scheduleDate.contains(snapshot
                              .data!.docs[index]['schedule_date']
                              .toString()
                              .split(' ')
                              .first)) {
                            scheduleDate.add(snapshot
                                .data!.docs[index]['schedule_date']
                                .toString()
                                .split(' ')
                                .first);
                          }
                        }
                        // print('date:${scheduleDate}');
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.BLACK.withOpacity(0.3),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                          padding: const EdgeInsets.all(05),
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            key: ValueKey<DateTime>(currentMonth),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                            ),
                            itemCount: getCalendarDays(currentMonth).length,
                            itemBuilder: (context, index) {
                              final calendarDays =
                                  getCalendarDays(currentMonth);
                              final date = calendarDays[index];

                              if (date.month != currentMonth.month) {
                                // If the date does not belong to the current month, show an empty container
                                return Container();
                              }
                              final bool isSelectedDate =
                                  date.year == selectedDate.year &&
                                      date.month == selectedDate.month &&
                                      date.day == selectedDate.day;
                              // print(
                              //     "date 2: ${date.year.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}");
                              bool dateExists =
                                  isDateInSchedule(scheduleDate, date);
                              Border? borderStyle =
                                  getBorderStyle(scheduleDate, date);
                              return GestureDetector(
                                onTap: () => selectDate(date),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color:
                                          date == selectedDate || isSelectedDate
                                              ? AppColors.Mint_Green
                                              : Colors.transparent,
                                      border: dateExists ? borderStyle : null
                                      //  scheduleDate.contains(
                                      //         "${date.year.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}")
                                      //     ? const Border(
                                      //         bottom: BorderSide(
                                      //           color: Colors.blue,
                                      //           width:
                                      //               5.0, // Adjust the width as needed
                                      //         ),
                                      //       )
                                      //     : null,
                                      ),
                                  child: Center(
                                    child: Text(
                                      date.day.toString(),
                                      style: TextStyle(
                                        color: date == selectedDate ||
                                                isSelectedDate
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                  vSizedBox(),
                  AppText(
                    text: 'This Month',
                    size: AppDimensions.FONT_SIZE_18,
                    color: AppColors.WHITE_COLOR,
                    fontWeight: FontWeight.w600,
                  ),
                  vSizedBox(),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('AllUserScheduleWorkOut')
                          .doc(
                              FirebaseAuth.instance.currentUser!.uid.toString())
                          .collection('SchedulesWorkOut')
                          .orderBy('schedule_date', descending: false)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: Text(" "));
                        }
                        var scheduleDate = [];
                        for (var index = 0;
                            index < snapshot.data!.docs.length;
                            index++) {
                          if (!scheduleDate.contains(snapshot
                              .data!.docs[index]['schedule_date']
                              .toString()
                              .split(' ')
                              .first)) {
                            scheduleDate.add(snapshot
                                .data!.docs[index]['schedule_date']
                                .toString()
                                .split(' ')
                                .first);
                          }
                        }
                        // print('date:${scheduleDate}');

                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    playscheduleVideo(
                                        snapshot.data!.docs[index]);
                                  },
                                  child: dateTiles(
                                    calendercontroller: calendercontroller,
                                    snapshot: snapshot.data!.docs[index],
                                    scheduleDate: scheduleDate,
                                  ));
                            });
                      }),
                ],
              ),
            ),
          ),
        ),
        AppButton(
            buttonWidth: Get.width,
            buttonName: 'schedule'.tr,
            buttonColor: AppColors.PRIMARY_COLOR,
            textColor: AppColors.WHITE_COLOR,
            onTap: moveToScheduleScreen)
      ],
    );
  }

  playscheduleVideo(var snapshot) {
    if (HelperFunctions()
            .checkDate(DateTime.parse(snapshot['schedule_date'])) ==
        'Past') {
      customSnackBar(
          title:
              "${'dateIsPassed'.tr} ${snapshot['schedule_date'].toString().split('-')[2].split(' ').first} ${HelperFunctions().getMonthName(snapshot['schedule_date'].toString().split('-')[1])}");
    } else if (HelperFunctions()
            .checkDate(DateTime.parse(snapshot['schedule_date'])) ==
        'Future') {
      customSnackBar(
          title:
              "${'dateIsInFuture'.tr} ${snapshot['schedule_date'].toString().split('-')[2].split(' ').first} ${HelperFunctions().getMonthName(snapshot['schedule_date'].toString().split('-')[1])}");
    } else {
      if (snapshot['workout_status'] == ScheduleStatus.success.name) {
        customSnackBar(title: "alreadyBeenDone".tr);
      } else if (snapshot['workout_status'] == ScheduleStatus.failed.name) {
        customSnackBar(title: "sorryYouFailed".tr);
      } else {
        Get.toNamed(Routes.onGoingWorkOut, arguments: {
          "isSchedules": true,
          "videoLink": snapshot['video_link'],
          "audioLink": snapshot['music_link'],
          "selectedTime": snapshot['workout_time'],
          "savasanaTime": snapshot['savasana_time'],
          "audioDuration": '',
          "videoDuration": '',
          "audiotype": snapshot['music_type'],
          "intensityLevel": snapshot['intensity_level'],
          "video_id": snapshot['id'],
          'videotype': snapshot['yoga_type'],
        });
      }
    }
  }

  bool isDateInSchedule(List<String> scheduleDate, DateTime date) {
    String formattedDate =
        "${date.year.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    return scheduleDate.contains(formattedDate);
  }

  Border? getBorderStyle(List<String> scheduleDate, DateTime date) {
    String formattedDate =
        "${date.year.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    if (scheduleDate.contains(formattedDate)) {
      if (date.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
        return const Border(
          bottom: BorderSide(
            color: Colors.red,
            width: 5.0, // Adjust the width as needed
          ),
        );
      } else {
        return const Border(
          bottom: BorderSide(
            color: Colors.blue,
            width: 5.0, // Adjust the width as needed
          ),
        );
      }
    }

    return null;
  }

  moveToScheduleScreen() {
    if (calendercontroller.getDateSelected) {
      if (selectedDate.year > DateTime.now().year) {
        Get.toNamed(Routes.scheduleWWorkOut,
            arguments: {'date': '${selectedDate}'});
      } else {
        if (selectedDate.year == DateTime.now().year) {
          if (selectedDate.month >= DateTime.now().month) {
            if (selectedDate.day >= DateTime.now().day) {
              Get.toNamed(Routes.scheduleWWorkOut,
                  arguments: {'date': '${selectedDate}'});
            } else {
              customSnackBar(title: 'pleaseSelectDay'.tr);
            }
          } else {
            customSnackBar(title: 'pleaseSelectMonth'.tr);
          }
        } else {
          customSnackBar(title: 'pleaseSelectYear'.tr);
        }
      }
    } else {
      customSnackBar(title: 'pleaseSelectDate'.tr);
    }
  }
}
