import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:tiers_final_project/firebase_options.dart';
import 'package:tiers_final_project/res/color.dart';
import 'package:tiers_final_project/res/fonts.dart';
import 'package:tiers_final_project/utils/routes/route_name.dart';
import 'package:tiers_final_project/utils/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: AppColors.whiteColor),
    );
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.primaryMaterialColor,
        scaffoldBackgroundColor: AppColors.whiteColor,
        appBarTheme: const AppBarTheme(
          color: AppColors.whiteColor,
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontSize: 22,
              fontFamily: AppFonts.sfProDisplayMedium,
              color: AppColors.primaryTextColor),
        ),
        //Headings Text Theme
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 40,
            fontFamily: AppFonts.sfProDisplayMedium,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w500,
            height: 1.6,
          ),
          displayMedium: TextStyle(
            fontSize: 32,
            fontFamily: AppFonts.sfProDisplayMedium,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w500,
            height: 1.6,
          ),
          displaySmall: TextStyle(
            fontSize: 28,
            fontFamily: AppFonts.sfProDisplayMedium,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w500,
            height: 1.9,
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontFamily: AppFonts.sfProDisplayMedium,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w500,
            height: 1.6,
          ),
          headlineSmall: TextStyle(
            fontSize: 20,
            fontFamily: AppFonts.sfProDisplayMedium,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w200,
            height: 1.0,
          ),
          titleLarge: TextStyle(
            fontSize: 17,
            fontFamily: AppFonts.sfProDisplayBold,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w500,
            height: 1.6,
          ),
          //Body Text Theme
          bodyLarge: TextStyle(
            fontSize: 17,
            fontFamily: AppFonts.sfProDisplayBold,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w700,
            height: 1.6,
          ),
          bodyMedium: TextStyle(
            fontSize: 17,
            fontFamily: AppFonts.sfProDisplayRegular,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w400,
            height: 1.6,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontFamily: AppFonts.sfProDisplayBold,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w500,
            height: 2.26,
          ),
        ),
      ),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
