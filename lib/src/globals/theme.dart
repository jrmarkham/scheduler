// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:google_fonts/google_fonts.dart';

const Color backgroundColor = Colors.white;
const Color primeColor = Colors.blue;
const Color secondColor = Colors.black;
const Color thirdColor = Colors.green;
const Color buttonTextIcons = thirdColor;
const Color shadow = Color(0xFF666666);
const Brightness brightness = Brightness.light;
const Color deepShadow = Color(0xFF444444);
const Color lightGrey = Color(0xFF888888);

final ThemeData mainTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: backgroundColor,
    primary: primeColor,
    secondary: secondColor,
    tertiary: thirdColor,
    background: backgroundColor,
    brightness: brightness,
    // us for button text and icons
    secondaryContainer: thirdColor,
    // light grey items
    tertiaryContainer: lightGrey,
    shadow: shadow,
  ),

  primaryColor: primeColor,
  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    iconColor: primeColor,
    titleTextStyle: GoogleFonts.oswald(color: primeColor, fontWeight: FontWeight.w700),
    contentTextStyle: GoogleFonts.roboto(color: primeColor),
  ),
  disabledColor: lightGrey,

// Define the default `TextTheme`. Use this to specify the default
// text styling for headlines, titles, bodies of text, and more.
  textTheme: TextTheme(
    titleMedium: GoogleFonts.oswald(color: primeColor, fontWeight: FontWeight.w700),

    labelLarge: GoogleFonts.roboto(color: primeColor, fontWeight: FontWeight.bold),
    labelMedium: GoogleFonts.roboto(
      textStyle: const TextStyle(color: primeColor, fontWeight: FontWeight.bold),
    ),

    // for buttons
    labelSmall: GoogleFonts.roboto(
      textStyle: const TextStyle(color: thirdColor, fontWeight: FontWeight.bold),
    ),

    bodyMedium: GoogleFonts.roboto(color: primeColor),
  ),

  iconTheme: const IconThemeData(color: primeColor),

  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      // TargetPlatform.linux: NoTransitionsBuilder(),
      // TargetPlatform.macOS: NoTransitionsBuilder(),
      // TargetPlatform.windows: NoTransitionsBuilder(),
    },
  ),
);
