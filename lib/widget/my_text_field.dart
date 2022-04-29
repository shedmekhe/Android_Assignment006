// ignore_for_file: prefer_const_constructors

import 'package:assignment_6/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class MyTextInput extends StatefulWidget {
  const MyTextInput({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.controller,
    required this.validator,
    this.textInputAction = TextInputAction.next,
  }) : super(key: key);

  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final MultiValidator validator;
  final TextInputAction textInputAction;

  @override
  State<MyTextInput> createState() => _MyTextInputState();
}

class _MyTextInputState extends State<MyTextInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.hintText,
          style: TextStyle(color: Colors.white, fontSize: 50 / 3),
        ),
        SizedBox(height: 27 / 3),
        Stack(
          children: [
            Container(
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24 / 3),
                color: Colors.black,
                border: Border.all(color: Colors.grey.shade700),
              ),
            ),
            TextFormField(
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              decoration: kTextFormFieldAuthDec2.copyWith(
                hintText: widget.hintText,
                prefixIcon: Icon(
                  widget.icon,
                  color: kRedColor,
                ),
                errorStyle: TextStyle(color: kRedColor),
              ),
              textInputAction: widget.textInputAction,
              cursorColor: Colors.white70,
              controller: widget.controller,
              onSaved: (value) {
                widget.controller.value =
                    widget.controller.value.copyWith(text: value);
              },
              validator: widget.validator,
            ),
          ],
        ),
      ],
    );
  }
}
