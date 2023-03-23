import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_pay/constants/colors.dart';
import 'package:smart_pay/constants/image_assets.dart';

class SmartPayTextFormField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final bool isPassword;
  final TextInputType? keyBoardType;
  final String? Function(String?)? validator;
  final String? hintText;
  const SmartPayTextFormField(
      {super.key,
      this.keyBoardType,
      this.isPassword = false,
      this.textEditingController,
      this.hintText,
      this.validator});

  @override
  State<SmartPayTextFormField> createState() => _SmartPayTextFormFieldState();
}

class _SmartPayTextFormFieldState extends State<SmartPayTextFormField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
      keyboardType: widget.keyBoardType,
      controller: widget.textEditingController,
      obscureText: widget.isPassword && isObscure ? true : false,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: isObscure
                      ? SvgPicture.asset(
                          AppImages.eyeOff,
                        )
                      : SvgPicture.asset(AppImages.eyeOn),
                ),
              )
            : const SizedBox(),
        fillColor: AppColors.formGrey,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.red)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.textFormBorderGrey)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.red)),
      ),
    );
  }
}
