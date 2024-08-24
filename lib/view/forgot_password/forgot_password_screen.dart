import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiers_final_project/view_model/controller/forgot_controller.dart';

import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.04,
              ),
              Text(
                'Frogot Password?',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                'Enter your email to\nrecover your password',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
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
                      ],
                    ),
                  )),
              SizedBox(
                height: height * 0.03,
              ),
              ChangeNotifierProvider(
                create: (_) => FrogotPasswordController(),
                child: Consumer<FrogotPasswordController>(
                  builder: (context, provider, child) {
                    return RoundButton(
                      loading: provider.loading,
                      title: 'RECOVER',
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          provider.forgotPassword(
                              context, emailController.text);
                        }
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
