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
      child: TextFormField(
        
        onChanged: onSaved,
        validator: validator,
        autofocus: true,
        obscureText: obsecure,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
            borderSide: BorderSide(
              color: theme.primaryColor,
              width: 3,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
            borderSide: BorderSide(
              color: theme.primaryColor,
              width: 3,
            ),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 30, right: 10),
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
