import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final bool? obscureText;
  final String? label;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final Function(String? value)? onSaved;
  final Function()? onTap;
  final bool? readOnly;
  final bool? enabled;
  const CustomTextFormField({
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled,
    super.key,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.onSaved,
    this.onTap,
    this.readOnly,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    final OutlineInputBorder border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    const Radius borderRadius = Radius.circular(15);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: borderRadius,
          bottomLeft: borderRadius,
          bottomRight: borderRadius,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        inputFormatters: inputFormatters,
        onSaved: onSaved,
        enabled: enabled ?? true,
        onTap: onTap,
        readOnly: readOnly ?? false,
        controller: controller,
        obscureText: obscureText ?? false,
        validator: validator,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 20, color: Colors.black54),
        decoration: InputDecoration(
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith(
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedErrorBorder: border.copyWith(
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          isDense: true,
          labelText: label,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          focusColor: colors.primary,
        ),
      ),
    );
  }
}
