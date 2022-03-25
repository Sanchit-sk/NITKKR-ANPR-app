import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  Icon? suffixIcon;
  String hint;
  Function(String val) onSearch;
  Function()? onFocus;
  Function()? onFocusOut;
  MySearchBar({
    Key? key,
    this.hint = "",
    this.suffixIcon,
    required this.onSearch,
    this.onFocus,
    this.onFocusOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onFocus,
      onEditingComplete: onFocusOut,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        hintText: hint,
        suffixIcon: suffixIcon,
      ),
      onChanged: (value) => onSearch(value),
    );
  }
}
