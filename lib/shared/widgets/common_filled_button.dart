import 'package:flutter/material.dart';

import '../../core/constants/provider_constants.dart';
import '../../core/enum/load_status.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_methods.dart';

class CommonFilledButton extends StatelessWidget {
  final bool allowAnimation;
  final void Function()? onPressed;
  final String buttonText;
  final Color? buttonColor;
  final Color buttonTextColor;
  final double? fontSize;
  final FontWeight fontWeight;
  final double? buttonWidth;
  final double? buttonHeight;
  final Color? borderColor;
  final Color? loaderColor;
  final double borderWidth;
  final LoadStatus status;

  const CommonFilledButton({
    super.key,
    this.allowAnimation = true,
    required this.onPressed,
    required this.buttonText,
    this.buttonTextColor = AppColors.whiteColor,
    this.buttonColor,
    this.fontSize,
    this.fontWeight = FontWeight.bold,
    this.buttonWidth,
    this.buttonHeight,
    this.borderColor,
    this.borderWidth = 1.5,
    this.loaderColor = AppColors.whiteColor,
    this.status = LoadStatus.initial,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        CommonMethods.hideKeyboard(context);
        onPressed?.call();
      },
      style: FilledButton.styleFrom(
        backgroundColor: buttonColor ?? AppColors.blackColor,
        minimumSize: Size(
          buttonWidth ?? double.infinity,
          buttonHeight ?? kButtonHeight,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kTextFieldBorderRadius),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth,
          ),
        ),
      ),
      child: Row(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: buttonTextColor,
              fontSize: fontSize ?? 14,
              fontWeight: fontWeight,
            ),
          ),
          Visibility(
            visible: status == LoadStatus.loading,
            child: Transform.scale(
              scale: 0.5,
              child: CircularProgressIndicator(
                color: loaderColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
