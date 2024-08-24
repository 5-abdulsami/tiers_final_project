import 'package:flutter/material.dart';
import 'package:tiers_final_project/res/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final Color color, textColor;
  final bool loading;
  RoundButton({
    super.key,
    required this.title,
    required this.onPress,
    this.color = AppColors.primaryButtonColor,
    this.textColor = AppColors.whiteColor,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onPress,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
                : Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 16, color: textColor),
                  )),
      ),
    );
  }
}
