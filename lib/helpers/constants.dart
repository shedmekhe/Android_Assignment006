import 'package:flutter/material.dart';

const kSkyBlueShade = Color(0xff60EEFB);
const kPinkShade = Color(0xffE8547C);
const kBlueShade = Color(0xff121322);
const kRedColor = Color(0xffE02648);

const kTextFormFieldAuthDec = InputDecoration(
  border: InputBorder.none,
  focusedBorder: InputBorder.none,
  enabledBorder: InputBorder.none,
  errorBorder: InputBorder.none,
  disabledBorder: InputBorder.none,
);

const kTextFormFieldAuthDec2 = InputDecoration(
  contentPadding: EdgeInsets.only(top: 18, bottom: 18),
  hintStyle: TextStyle(color: Colors.white60),
  border: InputBorder.none,
  focusedBorder: InputBorder.none,
  enabledBorder: InputBorder.none,
  errorBorder: InputBorder.none,
  disabledBorder: InputBorder.none,
  errorStyle: TextStyle(color: kRedColor),
);
const kInputDecoration = InputDecoration(
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: kRedColor),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: kRedColor),
  ),
  border: UnderlineInputBorder(
    borderSide: BorderSide(color: kRedColor),
  ),
  errorStyle: TextStyle(color: kSkyBlueShade),
);
