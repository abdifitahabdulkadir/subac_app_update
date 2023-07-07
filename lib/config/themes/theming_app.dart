import 'package:flutter/material.dart';

const Color _primaryColorLightTheme = Color.fromARGB(255, 49, 202, 169);
const Color _primaryColorDarkTheme = Color.fromARGB(255, 39, 55, 77);
const Color _specialBackground = Color.fromARGB(255, 38, 80, 138);

/*
* creating object of light mode and 
* it's configuration and designing.
*/
ThemeData lightTheme = ThemeData(
   
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      primary: _primaryColorLightTheme,
      seedColor: _primaryColorLightTheme,
      onSecondary: Colors.white,
      onBackground: Colors.white,
      onSecondaryContainer: Colors.grey.shade300,
    ),
    useMaterial3: true,
   
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
    ),
    iconTheme: IconThemeData(
      color: _primaryColorLightTheme,
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
  colorScheme: ColorScheme.fromSeed(
    primary: _primaryColorDarkTheme,
    seedColor: _primaryColorDarkTheme,
    brightness: Brightness.dark,
    onSecondary: _primaryColorDarkTheme,
    onBackground: Colors.white,
    onSecondaryContainer: _primaryColorDarkTheme.withOpacity(0.5),
  ),
  iconTheme: IconThemeData(
    color: _primaryColorLightTheme,
  ),
  useMaterial3: true,
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
