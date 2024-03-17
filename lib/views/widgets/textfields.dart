import 'package:flutter/material.dart';

import '../../../helper/theme.dart';

class AppTextField extends StatefulWidget {
  const AppTextField(
      {super.key,
      required this.controller,
      this.onChanged,
      this.onTap,
      this.onSubmitted,
      this.keyboardType,
      this.suffix,
      this.fieldName,
      this.autofocus,
      this.hintText});
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function(String)? onSubmitted;
  final TextInputType? keyboardType;
  final String? hintText;
  final bool? autofocus;
  final Widget? suffix;
  final String? fieldName;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.fieldName != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              widget.fieldName!,
              style: AppTextStyle.text.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        SizedBox(
          height: 50,
          child: TextField(
            controller: widget.controller,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            autofocus: widget.autofocus ?? false,
            onSubmitted: widget.onSubmitted,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            style: const TextStyle(
              color: Color(0xFF432A19),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              suffixIcon: widget.suffix,
              enabledBorder: widget.controller.text.isNotEmpty
                  ? OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(10.0),
                    )
                  : null,
              contentPadding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
              hintText: widget.hintText,
            ),
          ),
        ),
      ],
    );
  }
}
