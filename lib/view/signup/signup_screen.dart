import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiers_final_project/utils/routes/route_name.dart';
import 'package:tiers_final_project/utils/utils.dart';
import 'package:tiers_final_project/view_model/controller/signup_controller.dart';

import '../../res/color.dart';
import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  final userNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPassFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ChangeNotifierProvider(
            create: (_) => SignupController(),
            child:
                Consumer<SignupController>(builder: (context, provider, child) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Text(
                      'Welcome to our App',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      'Enter your credentials\nto create to your account',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(),
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
                                myController: userNameController,
                                focusNode: userNameFocusNode,
                                onFieldSubmittedValue: (value) {},
                                onValidator: (value) {
                                  return value.isEmpty
                                      ? 'Enter Username'
                                      : null;
                                },
                                obscureText: false,
                                keyboardInputType: TextInputType.name,
                                hint: 'Username',
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              InputTextField(
                                myController: emailController,
                                focusNode: emailFocusNode,
                                onFieldSubmittedValue: (value) {},
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
                                myController: phoneController,
                                focusNode: phoneFocusNode,
                                onFieldSubmittedValue: (value) {},
                                onValidator: (value) {
                                  return value.isEmpty
                                      ? 'Enter Phone Number'
                                      : null;
                                },
                                obscureText: false,
                                keyboardInputType: TextInputType.phone,
                                hint: 'Phone Number',
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
                                        ),
                                ),
                                myController: passwordController,
                                focusNode: passwordFocusNode,
                                onFieldSubmittedValue: (value) {},
                                onValidator: (value) {
                                  return value.isEmpty
                                      ? 'Enter Password'
                                      : null;
                                },
                                obscureText: provider.obscureText,
                                keyboardInputType:
                                    TextInputType.visiblePassword,
                                hint: 'Password',
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
                                        ),
                                ),
                                myController: confirmPassController,
                                focusNode: confirmPassFocusNode,
                                onFieldSubmittedValue: (value) {},
                                onValidator: (value) {
                                  return value.isEmpty
                                      ? 'Enter Password'
                                      : null;
                                },
                                obscureText: provider.obscureText,
                                keyboardInputType:
                                    TextInputType.visiblePassword,
                                hint: 'Retype Password',
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    RoundButton(
                      title: 'REGISTER',
                      onPress: () {
                        if (passwordController.text.toString() !=
                            confirmPassController.text.toString()) {
                          Utils.toastMessage('Passwords donot match!');
                        } else {
                          if (_formKey.currentState!.validate()) {
                            provider.signUp(
                                context,
                                userNameController.text,
                                emailController.text,
                                phoneController.text,
                                passwordController.text);
                          }
                        }
                      },
                      loading: provider.loading,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.loginView);
                      },
                      child: RichText(
                          text: TextSpan(
                        text: "Already have an account?  ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 15),
                        children: [
                          TextSpan(
                            text: 'Log In',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      )),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
