import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/provider_constants.dart';
import '../../core/enum/load_status.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_methods.dart';

class CommonTextField extends StatefulWidget {
  final bool allowAnimation;
  final AutovalidateMode? autoValidateMode;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool autofocus;
  final bool expands;
  final bool readOnly;
  final bool enabled;
  final bool filled;
  Color? filledColor;
  final TextEditingController? textEditingController;
  final Color textColor;
  final TextAlign textAlign;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final EdgeInsets contentPadding;

  final double? letterSpacing;
  final double? wordSpacing;
  final double? inputFontSize;
  final FontWeight inputFontWeight;
  final double? headerFontSize;
  final FontWeight? headerFontWeight;
  final String fontFamily;
  final String? headerText;
  final String? counterText;
  final String? labelText;
  final String? hintText;
  final bool? showLabelText;
  final Color? hintColor;
  final Color? labelColor;
  final Color? floatLabelColor;
  final double? hintFontSize;
  final double? labelFontSize;
  final FontWeight? hintFontWeight;
  final FontWeight? labelWeight;
  final Color? borderColor;
  final Color enabledBorderColor;
  final double borderRadius;
  final Function? onEditingComplete;
  final Function? onFieldSubmitted;
  final Function(String)? onChanged;
  final Function? onTap;

  final LoadStatus? loadStatus;

  final bool allowValidation;
  final String? errorMessage;
  final String? validationMessage;
  final String? validationRegex;
  final int? value;
  final int? length;
  final int? maxLength;
  final String? prefixText;
  final String? lengthMessage;
  final FocusNode? focusNode;
  final int? minLines;
  final int? maxLines;
  final List<TextInputFormatter> inputFormat;
  final TextInputType textInputType;

  final TextInputAction textInputAction;
  final FocusNode? nextFocusNode;
  final TextCapitalization textCapitalization;

  CommonTextField({
    super.key,
    this.allowAnimation = false,
    this.autoValidateMode,
    this.autofocus = false,
    this.expands = false,
    this.readOnly = false,
    this.enabled = true,
    this.filled = false,
    this.enabledBorderColor = AppColors.transparentColor,
    this.filledColor,
    this.textEditingController,
    this.textColor = AppColors.blackColor,
    this.labelColor,
    this.floatLabelColor,
    this.textAlign = TextAlign.start,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 24, vertical: 21),
    this.letterSpacing,
    this.wordSpacing,
    this.inputFontSize,
    this.floatingLabelBehavior,
    this.inputFontWeight = FontWeight.bold,
    this.headerFontSize,
    this.headerFontWeight,
    this.fontFamily = 'Roboto',
    this.headerText,
    this.counterText,
    this.labelText,
    this.hintText,
    this.showLabelText = false,
    this.hintColor,
    this.hintFontSize,
    this.labelFontSize,
    this.hintFontWeight,
    this.labelWeight = FontWeight.w500,
    this.borderColor = AppColors.blackColor,
    this.borderRadius = kTextFieldBorderRadius,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onChanged,
    this.onTap,
    this.allowValidation = true,
    this.errorMessage,
    this.validationMessage,
    this.validationRegex,
    this.value,
    this.length,
    this.prefixText,
    this.lengthMessage,
    this.focusNode,
    this.minLines,
    this.maxLines,
    this.loadStatus = LoadStatus.initial,
    this.maxLength,
    this.inputFormat = const [],
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.nextFocusNode,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  var isFilled = true;

  @override
  void initState() {
    super.initState();
    _onFocusNodeEvent();
    widget.focusNode?.addListener(_onFocusNodeEvent);
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_onFocusNodeEvent);
    super.dispose();
  }

  void _onFocusNodeEvent() {
    if (mounted) {
      bool newState = widget.focusNode?.hasFocus ?? false;
      setState(() => isFilled = !newState);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.loadStatus == LoadStatus.loading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            autovalidateMode: widget.autoValidateMode,
            magnifierConfiguration: TextMagnifierConfiguration.disabled,
            validator: (text) {
              if (widget.textEditingController!.text.trim().isEmpty && widget.allowValidation) {
                return widget.errorMessage ?? "Invalid errorMessage";
              } else if (widget.value != null &&
                  (int.parse(widget.textEditingController!.text.trim()) > widget.value!)) {
                return widget.validationMessage ?? "Invalid value";
              } else if (widget.length != null && widget.lengthMessage != null) {
                if (widget.textEditingController!.text.trim().length < widget.length! ||
                    widget.textEditingController!.text.trim().length > widget.length!) {
                  return widget.lengthMessage;
                }
              } else if (widget.validationRegex != null) {
                if (!RegExp(widget.validationRegex!).hasMatch(text!.trim())) {
                  return widget.validationMessage ?? "Invalid Validation Message";
                }
              }
              return null;
            },
            textAlign: widget.textAlign,
            controller: widget.textEditingController,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            expands: widget.expands,
            obscureText: widget.obscureText,
            obscuringCharacter: "*",
            autofocus: widget.autofocus,
            focusNode: widget.focusNode,
            maxLength: widget.maxLength,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            keyboardType: widget.textInputType,
            textInputAction: widget.textInputAction,
            textCapitalization: widget.textCapitalization,
            inputFormatters: widget.inputFormat.isEmpty ? null : widget.inputFormat,
            decoration: InputDecoration(
              contentPadding: widget.contentPadding,
              alignLabelWithHint: true,
              focusColor: AppColors.whiteColor,
              floatingLabelBehavior: widget.floatingLabelBehavior ?? FloatingLabelBehavior.auto,
              floatingLabelStyle: TextStyle(
                color: widget.floatLabelColor ?? AppColors.blackColor.withValues(alpha: 0.60),
                fontSize: widget.labelFontSize ?? 12,
                fontWeight: widget.labelWeight,
                fontFamily: widget.fontFamily,
              ),
              labelText: widget.labelText,
              counter: const SizedBox.shrink(),
              fillColor: AppColors.whiteColor,
              filled: isFilled,
              hintText: widget.hintText,
              labelStyle: TextStyle(
                color: AppColors.blackColor.withValues(alpha: 0.24),
                fontSize: widget.hintFontSize ?? 14,
                fontWeight: widget.hintFontWeight ?? FontWeight.w500,
                letterSpacing: widget.letterSpacing,
                fontFamily: widget.fontFamily,
                wordSpacing: widget.wordSpacing,
              ),
              errorStyle: const TextStyle(color: AppColors.redColor),
              errorMaxLines: 3,
              prefixIcon: widget.prefixIcon == null
                  ? null
                  : Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0), child: widget.prefixIcon),
              suffixIcon: Padding(padding: const EdgeInsets.only(right: 10), child: widget.suffixIcon),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(color: widget.borderColor ?? AppColors.whiteColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(color: widget.enabledBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(color: widget.borderColor ?? AppColors.blackColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: const BorderSide(color: AppColors.redColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: const BorderSide(color: AppColors.redColor),
              ),
            ),
            cursorColor: AppColors.hintColor,
            style: TextStyle(
              fontSize: widget.inputFontSize ?? 14,
              color: widget.enabled == false ? widget.textColor.withOpacity(0.3) : widget.textColor,
              fontWeight: widget.inputFontWeight,
              fontFamily: widget.fontFamily,
              letterSpacing: widget.letterSpacing,
              wordSpacing: widget.wordSpacing,
            ),
            onChanged: (val) {
              widget.onChanged?.call(val);
              setState(() => isFilled = false);
            },
            onTap: () {
              widget.onTap?.call();
            },
            onEditingComplete: () {
              widget.onEditingComplete?.call();
            },
            onFieldSubmitted: (value) {
              widget.onFieldSubmitted?.call(value);
              if (widget.textInputAction == TextInputAction.next && widget.nextFocusNode != null) {
                FocusScope.of(context).requestFocus(widget.nextFocusNode);
              } else if (widget.textInputAction == TextInputAction.done) {
                CommonMethods.hideKeyboard(context);
              }
            },
            onTapOutside: (event) => CommonMethods.hideKeyboard(context),
          ),
        ],
      ),
    );
  }
}
