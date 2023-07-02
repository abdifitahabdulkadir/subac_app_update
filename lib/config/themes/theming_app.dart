import 'package:flutter/material.dart';

const Color _primaryColorLightTheme = Color.fromARGB(255, 49, 202, 169);

/*
* creating object of light mode and 
* it's configuration and designing.
*/
ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: _primaryColorLightTheme,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: TextStyle(
        color: Colors.black,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    ));

/*
*Creating object of light mode and 
*It's configuration and designing.
*/
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: _primaryColorLightTheme,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    labelSmall: TextStyle(
      color: Colors.white,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
  ),
);
