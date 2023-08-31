import 'package:toast/toast.dart';
import 'package:zen_flow/app_modules/result/controller/dynamicLink_controller.dart';
import '../utils/app_imports/app_imports.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  var country = storageBox.read(StorageConstants.langCountry) ?? 'US'; // 'US'
  var lang = storageBox.read(StorageConstants.langCode) ?? 'en'; // 'French'
  DynamicController dynamicController = Get.put(DynamicController());

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    langController.changeLanguage(lang.toString(), country.toString());
    dynamicController.initDynamicLinks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build- MyApp');
    ToastContext().init(context);
    return AppAnnotatedRegionWidget(
      child: GetMaterialApp(
        translations: LocalizationModel(),
        fallbackLocale: Locale(country.toString(), lang.toString()),
        useInheritedMediaQuery: false,
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.initialRoute,
        title: 'Zen Flow',
        getPages: AppPages.routes,
        theme: ThemeData.from(
          colorScheme: lightTheme,
        ).copyWith(
          colorScheme: lightTheme,
          dialogTheme: dialogTheme,
          timePickerTheme: timePickerTheme,
          appBarTheme: appBarThemeLight(lightTheme),
          useMaterial3: true,
          textTheme: GoogleFonts.outfitTextTheme(
            ThemeData.light().textTheme,
          ),
          scaffoldBackgroundColor: lightTheme.background,
          dialogBackgroundColor: lightTheme.background,
          navigationBarTheme: navigationBarThemeData(lightTheme),
          applyElevationOverlayColor: true,
          inputDecorationTheme: inputDecorationTheme,
          elevatedButtonTheme: elevatedButtonTheme(
            context,
            lightTheme,
          ),
          extensions: [lightCustomColor],
          dividerTheme: DividerThemeData(
            color: ThemeData.light().dividerColor,
          ),
        ),
        darkTheme: ThemeData.from(
          colorScheme: darkTheme,
        ).copyWith(
          colorScheme: darkTheme,
          dialogTheme: dialogTheme,
          timePickerTheme: timePickerTheme,
          appBarTheme: appBarThemeDark(darkTheme),
          useMaterial3: true,
          textTheme: GoogleFonts.outfitTextTheme(
            ThemeData.dark().textTheme,
          ),
          scaffoldBackgroundColor: darkTheme.background,
          dialogBackgroundColor: darkTheme.background,
          navigationBarTheme: navigationBarThemeData(darkTheme),
          applyElevationOverlayColor: true,
          inputDecorationTheme: inputDecorationTheme,
          elevatedButtonTheme: elevatedButtonTheme(
            context,
            darkTheme,
          ),
          extensions: [darkCustomColor],
          dividerTheme: DividerThemeData(
            color: ThemeData.dark().dividerColor,
          ),
        ),
        themeMode: ThemeMode.system,
      ),
    );
  }
}

// - Keyboard hide by tapping
class AppAnnotatedRegionWidget extends StatelessWidget {
  const AppAnnotatedRegionWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness:
              Theme.of(context).brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark,
          systemNavigationBarContrastEnforced: true,
        ),
        child: child,
      ),
    );
  }
}
