import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiers_final_project/res/color.dart';
import 'package:tiers_final_project/res/components/input_text_field.dart';
import 'package:tiers_final_project/res/components/round_button.dart';
import 'package:tiers_final_project/utils/routes/route_name.dart';
import 'package:tiers_final_project/utils/utils.dart';
import 'package:tiers_final_project/view_model/controller/login_controller.dart';
import 'package:tiers_final_project/view_model/controller/signup_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ChangeNotifierProvider(
            create: (_) => SignupController(),
            child: Consumer<SignupController>(
              builder: (context, provider, child) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        child: SvgPicture.asset(
                          'assets/images/login.svg',
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        'Welcome Back!',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        'Enter your credentials\nto connect to your account',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.06, bottom: height * 0.005),
                            child: Column(
                              children: [
                                InputTextField(
                                  myController: emailController,
                                  focusNode: emailFocusNode,
                                  onFieldSubmittedValue: (value) {
                                    Utils.fieldFocus(context, emailFocusNode,
                                        passwordFocusNode);
                                  },
                                  onValidator: (value) {
                                    return value.isEmpty ? 'Enter Email' : null;
                                  },
                                  obscureText: false,
                                  keyboardInputType: TextInputType.emailAddress,
                                  hint: 'Email',
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                InputTextField(
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        provider.toggleObscureText();
                                      },
                                      child: provider.obscureText
                                          ? const Icon(
                                              Icons.visibility,
                                              color: AppColors.primaryIconColor,
                                            )
                                          : const Icon(
                                              Icons.visibility_off,
                                              color: AppColors.primaryIconColor,
                                            )),
                                  myController: passwordController,
                                  focusNode: passwordFocusNode,
                                  onFieldSubmittedValue: (value) {},
                                  onValidator: (value) {
                                    return value.isEmpty
                                        ? 'Enter Password'
                                        : null;
                                  },
                                  obscureText: provider.obscureText,
                                  keyboardInputType: TextInputType.emailAddress,
                                  hint: 'Password',
                                ),
                              ],
                            ),
                          )),
                      Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteName.forgotPasswordView);
                            },
                            child: Text(
                              'Forgot Password?',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          )),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      ChangeNotifierProvider(
                        create: (_) => LoginController(),
                        child: Consumer<LoginController>(
                          builder: (context, provider, child) {
                            return RoundButton(
                              loading: provider.loading,
                              title: 'LOGIN',
                              onPress: () {
                                if (_formKey.currentState!.validate()) {
                                  provider.login(context, emailController.text,
                                      passwordController.text);
                                }
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.signupView);
                        },
                        child: RichText(
                            text: TextSpan(
                          text: "Don't have an account?  ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 15),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
