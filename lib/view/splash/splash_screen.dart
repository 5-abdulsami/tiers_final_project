import 'package:flutter/material.dart';
import 'package:tiers_final_project/res/color.dart';
import 'package:tiers_final_project/res/fonts.dart';
import 'package:tiers_final_project/view_model/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child:
                    Image(image: AssetImage('assets/images/splash_icon.png')),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Social Media App',
                style: TextStyle(
                    fontFamily: AppFonts.sfProDisplayBold,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: AppColors.whiteColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
