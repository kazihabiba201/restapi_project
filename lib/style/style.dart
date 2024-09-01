import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

const colorRed = Color.fromRGBO(231, 28, 36, 1);
const colorGreen = Color.fromRGBO(33, 191, 115, 1);
const colorWhite = Color.fromRGBO(255, 255, 255, 1);
const colorDarkBlue = Color.fromRGBO(44, 62, 80, 1);

SvgPicture screenBackground(context) {
  return SvgPicture.asset(
    'assets/images/screen-back.svg',
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    fit: BoxFit.cover,
  );
}

InputDecoration appInputDecoration(lable) {
  return InputDecoration(
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorGreen, width: 1),
      ),
      fillColor: colorWhite,
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: colorWhite, width: 0)),
      border: const OutlineInputBorder(),
      labelText: lable);
}

DecoratedBox appDropDownStyle(child) {
  return DecoratedBox(
    decoration: BoxDecoration(
        color: colorWhite,
        border: Border.all(color: colorWhite, width: 1),
        borderRadius: BorderRadius.circular(4)),
    child: Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: child,
    ),
  );
}

ButtonStyle appButtonStyle() {
  return ElevatedButton.styleFrom(
      elevation: 1,
      padding: const EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)));
}

Ink successButtonChild(buttonText) {
  return Ink(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6), color: colorGreen),
    child: Container(
      height: 45,
      alignment: Alignment.center,
      child: Text(
        buttonText,
        style: const TextStyle(
            fontWeight: FontWeight.w400, fontSize: 15, color: colorWhite),
      ),
    ),
  );
}

void errorToast(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: colorRed,
      textColor: colorWhite,
      fontSize: 16.0);
}

void successToast(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: colorGreen,
      textColor: colorWhite,
      fontSize: 16.0);
}

SliverGridDelegateWithFixedCrossAxisCount productGridViewStyle() {
  return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, mainAxisSpacing: 2, mainAxisExtent: 250);
}
