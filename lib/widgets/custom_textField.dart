import 'package:flutter/material.dart';
import '../manager/color_manager.dart';
import '../manager/font_manager.dart';

class CustomTextField extends StatefulWidget {
  final String floatingTitle;
  final String hint;
  final bool? isPassword;
  final IconData? icon;
  final double? verticalPadding;
  final bool? isNumberOnly;
  final String? Function(String?) validator;
  final TextEditingController? controller;

  const CustomTextField(
      {super.key,
      required this.floatingTitle,
      required this.hint,
      this.isPassword,
      this.icon,
      this.verticalPadding,
      required this.validator,
      this.isNumberOnly,
      this.controller});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final double radius = 25;
  late bool obscure;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obscure = widget.isPassword ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 15.0, vertical: widget.verticalPadding ?? 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.floatingTitle,
            style: appFont.f14w500Grey,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: obscure,
            style: appFont.f14w500Grey,
            cursorColor: appColors.brandDark,
            validator: widget.validator,
            keyboardType: widget.isNumberOnly ?? false
                ? TextInputType.number
                : TextInputType.text,
            controller: widget.controller,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  widget.icon,
                  size: 25,
                  color: appColors.brandDark,
                ),
                suffixIcon: widget.isPassword ?? false
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            width: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  obscure
                                      ? Icons.remove_red_eye
                                      : Icons.hide_source,
                                  color:
                                      Colors.deepOrangeAccent.withOpacity(0.5),
                                ),
                                !obscure
                                    ? Text(
                                        "Hide",
                                        style: appFont.f10w600Orange40,
                                      )
                                    : Text(
                                        "Show",
                                        style: appFont.f10w600Orange40,
                                      )
                              ],
                            ),
                          ),
                        ),
                      )
                    : null,
                counter: const SizedBox(),
                hintText: widget.hint,
                hintStyle: appFont.f12w500Grey80,
                disabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appColors.brandDark,
                    ),
                    borderRadius: BorderRadius.circular(radius)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appColors.brandDark,
                    ),
                    borderRadius: BorderRadius.circular(radius)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(radius)),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(radius))),
          ),
        ],
      ),
    );
  }
}
