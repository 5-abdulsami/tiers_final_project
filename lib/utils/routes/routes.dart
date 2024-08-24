import 'package:flutter/material.dart';
import 'package:tiers_final_project/utils/routes/route_name.dart';
import 'package:tiers_final_project/view/dashboard/dashboard_screen.dart';
import 'package:tiers_final_project/view/forgot_password/forgot_password_screen.dart';
import 'package:tiers_final_project/view/login/login_screen.dart';
import 'package:tiers_final_project/view/signup/signup_screen.dart';
import 'package:tiers_final_project/view/splash/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.loginView:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteName.signupView:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case RouteName.dashboardView:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case RouteName.forgotPasswordView:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
