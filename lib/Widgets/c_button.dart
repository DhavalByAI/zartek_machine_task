import 'package:flutter/material.dart';
import 'c_bounce.dart';
import 'c_text.dart';

Widget cButton(String text,
    {double? height,
    double? width,
    String? icon,
    double? iconHeight,
    double? iconWidth,
    Function()? onTap,
    double? fontSize,
    FontWeight? fontWeight,
    EdgeInsetsGeometry? padding,
    Color? btnColor,
    Color? txtColor,
    Color? iconColor,
    BoxBorder? border}) {
  return cBounce(
    onPressed: onTap,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          border: border,
          color: btnColor,
          borderRadius: BorderRadius.circular(20)),
      child: Center(
          child: Padding(
        padding: padding ?? const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            icon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Image.asset(
                      icon,
                      color: iconColor,
                      height: iconHeight ?? 20,
                      width: iconWidth ?? 20,
                    ),
                  )
                : const SizedBox(),
            
            ctext(text,
                color: txtColor ?? Colors.white,
                fontSize: fontSize,
                fontWeight: fontWeight),
             SizedBox(width: icon != null
                ?20 : 0,)
          ],
        ),
      )),
    ),
  );
}