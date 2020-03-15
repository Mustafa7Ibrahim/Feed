import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Icon icon;
  final String hint;
  final bool obsecure;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  CustomTextField({
    this.hint,
    this.icon,
    this.obsecure,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(right: 24.0, left: 24.0),
      width: double.infinity,
      child: TextFormField(
        onChanged: onSaved,
        validator: validator,
        obscureText: obsecure,
        style: TextStyle(fontSize: 20.0),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45.0),
            borderSide: BorderSide(
              color: theme.primaryColor,
              width: 3,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45.0),
            borderSide: BorderSide(
              color: theme.primaryColor,
              width: 3,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45.0),
            borderSide: BorderSide(
              color: Colors.red,
              width: 3,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45.0),
            borderSide: BorderSide(
              color: Colors.red,
              width: 3,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45.0),
            borderSide: BorderSide(
              color: theme.primaryColor,
              width: 3,
            ),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 30.0, right: 10.0),
            child: IconTheme(
              data: IconThemeData(color: theme.primaryColor),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}
