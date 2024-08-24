import 'package:flutter/material.dart';
import 'package:tiers_final_project/res/color.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFieldSubmittedValue;
  final FormFieldValidator onValidator;

  final TextInputType keyboardInputType;
  final String hint;
  final bool obscureText, enable, autoFoucs;
  final Widget suffixIcon;

  const InputTextField({
    super.key,
    required this.myController,
    required this.focusNode,
    required this.onFieldSubmittedValue,
    required this.onValidator,
    this.enable = false,
    this.autoFoucs = false,
    this.suffixIcon = const SizedBox(),
    required this.obscureText,
    required this.keyboardInputType,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        cursorColor: AppColors.cursorColor,
        controller: myController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmittedValue,
        keyboardType: keyboardInputType,
        validator: onValidator,
        obscureText: obscureText,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(height: 0, fontSize: 19),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hint,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(height: 1, color: AppColors.hintColor),
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.textFieldDefaultBorderColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.textFieldFocusBorderColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.textFieldDefaultFocus,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.alertColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
