import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(),
      primarySwatch: AppColors.primary,
      fontFamily: 'Inter',
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Inter'),
      ),
      inputDecorationTheme: InputDecorationTheme(
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldBorder),
          borderRadius: BorderRadius.circular(5),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            // width: 1,
            color: AppColors.textFieldBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            // width: 1,
            color: AppColors.textFieldBorder,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.red),
        ),
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        hintStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        // contentPadding:
        // const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10),
      ),
      textSelectionTheme:
          TextSelectionThemeData(cursorColor: AppColors.primary));

  // create a getter to get boxdecorator for light theme
  static BoxDecoration get backgroundGradientLight {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: const Alignment(-0.00, 1.00),
        end: const Alignment(0, -1),
        colors: [Colors.white.withOpacity(0), Color(0x66F7CE45)],
      ),
    );
  }
}

class AppColors {
  static final MaterialColor primary = createSwatch(255, 90, 1, 1);
  static final MaterialColor orange = createSwatch(249, 178, 51, 1);
  // static final MaterialColor pro = createSwatch(162, 0, 255, 1);
  static final MaterialColor grey = createSwatch(185, 185, 185, 1);
  static final MaterialColor lightGrey = createSwatch(190, 190, 190, 1);
  static final MaterialColor lightBlue = createSwatch(222, 232, 255, 1);
  static final lightGreyText = createSwatch(180, 172, 162, 1);
  static final MaterialColor heading = createSwatch(6, 44, 128, 1);
  static final textFieldBorder = Color.fromARGB(255, 146, 144, 142);
  static final MaterialColor textHintColor = createSwatch(164, 164, 164, 1);
  static final error = Colors.red.shade200;
  static final yellowPrimary = Color(0xFFF9B233);
}

class AppTextStyle {
  static final TextStyle linkText = TextStyle(
      fontFamily: 'Inter',
      color: AppColors.primary,
      decoration: TextDecoration.underline);
  static const TextStyle heading = TextStyle(
      fontFamily: 'Inter', color: Colors.black, fontWeight: FontWeight.w700);
  static const TextStyle text =
      TextStyle(fontFamily: 'Inter', color: Colors.black);
  static const TextStyle h1 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 30,
    color: Colors.black,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle h2 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w700);
}

MaterialColor createSwatch(int r, int g, int b, double o) {
  Map<int, Color> swatch = {};
  List<int> opacities = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  for (int opacity in opacities) {
    swatch[opacity] = Color.fromRGBO(r, g, b, opacity / 1000);
  }
  return MaterialColor(Color.fromRGBO(r, g, b, o).value, swatch);
}
