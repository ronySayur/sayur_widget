import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const MaterialColor primaryRed = MaterialColor(
  0xFFEA1F27,
  <int, Color>{
    50: Color(0xFFFFE3E6),
    100: Color(0xFFFFBBC2),
    200: Color(0xFFFF9097),
    300: Color(0xFFFF6479),
    400: Color(0xFFFF4245),
    500: Color(0xFFEA1F27),
    600: Color(0xFFE01826),
    700: Color(0xFFD81123),
    800: Color(0xFFD10B20),
    900: Color(0xFFC4001B),
  },
);

const MaterialColor primaryBlue = MaterialColor(
  0xFF1E88E5,
  <int, Color>{
    50: Color(0xFFE3F2FD),
    100: Color(0xFFBBDEFB),
    200: Color(0xFF90CAF9),
    300: Color(0xFF64B5F6),
    400: Color(0xFF42A5F5),
    500: Color(0xFF1E88E5),
    600: Color(0xFF1976D2),
    700: Color(0xFF1565C0),
    800: Color(0xFF0D47A1),
    900: Color(0xFF82B1FF),
  },
);

const MaterialColor secondaryYellow = MaterialColor(
  0xFFFFA726,
  <int, Color>{
    50: Color(0xFFFFF3E0),
    100: Color(0xFFFFE0B2),
    200: Color(0xFFFFCC80),
    300: Color(0xFFFFB74D),
    400: Color(0xFFFFA726),
    500: Color(0xFFFFBF00),
    600: Color(0xFFFFB300),
    700: Color(0xFFFFA000),
    800: Color(0xFFFF8F00),
    900: Color(0xFFFF6F00),
  },
);

const MaterialColor tertiaryGreen = MaterialColor(
  0xFF00A445,
  <int, Color>{
    50: Color(0xFFE0F2E9),
    100: Color(0xFFB3E0CB),
    200: Color(0xFF80CEAB),
    300: Color(0xFF4DBD8B),
    400: Color(0xFF26AF73),
    500: Color(0xFF00A445),
    600: Color(0xFF009E3F),
    700: Color(0xFF009737),
    800: Color(0xFF009030),
    900: Color(0xFF008122),
  },
);

enum SizeTextField { small, medium, large }

enum SuffixType { none, password, search }

enum LottieEnum { loading, success, failed }

enum InfoType { info, warning, error, success }

enum BStyle { primaryRed, secondaryRed, primaryBlue }

enum DialogType { confirmation, info }

enum LogType { log, debugPrint }

// Gap Sizebox
const SizedBox gap0 = SizedBox(height: 0, width: 0);
const SizedBox gap4 = SizedBox(height: 4, width: 4);
const SizedBox gap8 = SizedBox(height: 8, width: 8);
const SizedBox gap12 = SizedBox(height: 12, width: 12);
const SizedBox gap16 = SizedBox(height: 16, width: 16);
const SizedBox gap20 = SizedBox(height: 20, width: 20);
const SizedBox gap24 = SizedBox(height: 24, width: 24);
const SizedBox gap32 = SizedBox(height: 32, width: 32);
const SizedBox gap40 = SizedBox(height: 40, width: 40);
const SizedBox gap48 = SizedBox(height: 48, width: 48);

const SizedBox gapH4 = SizedBox(height: 4);
const SizedBox gapH8 = SizedBox(height: 8);
const SizedBox gapH12 = SizedBox(height: 12);
const SizedBox gapH16 = SizedBox(height: 16);
const SizedBox gapH20 = SizedBox(height: 20);
const SizedBox gapH24 = SizedBox(height: 24);
const SizedBox gapH32 = SizedBox(height: 32);
const SizedBox gapH40 = SizedBox(height: 40);
const SizedBox gapH48 = SizedBox(height: 48);

const SizedBox gapW4 = SizedBox(width: 4);
const SizedBox gapW8 = SizedBox(width: 8);
const SizedBox gapW12 = SizedBox(width: 12);
const SizedBox gapW16 = SizedBox(width: 16);
const SizedBox gapW20 = SizedBox(width: 20);
const SizedBox gapW24 = SizedBox(width: 24);
const SizedBox gapW32 = SizedBox(width: 32);
const SizedBox gapW40 = SizedBox(width: 40);
const SizedBox gapW48 = SizedBox(width: 48);

// Edge Insets
const EdgeInsets e0 = EdgeInsets.all(0);
const EdgeInsets e4 = EdgeInsets.all(4);
const EdgeInsets e8 = EdgeInsets.all(8);
const EdgeInsets e12 = EdgeInsets.all(12);
const EdgeInsets e16 = EdgeInsets.all(16);
const EdgeInsets e20 = EdgeInsets.all(20);
const EdgeInsets e24 = EdgeInsets.all(24);
const EdgeInsets e32 = EdgeInsets.all(32);
const EdgeInsets e40 = EdgeInsets.all(40);
const EdgeInsets e48 = EdgeInsets.all(48);

const EdgeInsets eH4 = EdgeInsets.symmetric(vertical: 4);
const EdgeInsets eH8 = EdgeInsets.symmetric(vertical: 8);
const EdgeInsets eH12 = EdgeInsets.symmetric(vertical: 12);
const EdgeInsets eH16 = EdgeInsets.symmetric(vertical: 16);
const EdgeInsets eH20 = EdgeInsets.symmetric(vertical: 20);
const EdgeInsets eH24 = EdgeInsets.symmetric(vertical: 24);
const EdgeInsets eH32 = EdgeInsets.symmetric(vertical: 32);
const EdgeInsets eH40 = EdgeInsets.symmetric(vertical: 40);
const EdgeInsets eH48 = EdgeInsets.symmetric(vertical: 48);

const EdgeInsets eW4 = EdgeInsets.symmetric(horizontal: 4);
const EdgeInsets eW8 = EdgeInsets.symmetric(horizontal: 8);
const EdgeInsets eW12 = EdgeInsets.symmetric(horizontal: 12);
const EdgeInsets eW16 = EdgeInsets.symmetric(horizontal: 16);
const EdgeInsets eW20 = EdgeInsets.symmetric(horizontal: 20);
const EdgeInsets eW24 = EdgeInsets.symmetric(horizontal: 24);
const EdgeInsets eW32 = EdgeInsets.symmetric(horizontal: 32);
const EdgeInsets eW40 = EdgeInsets.symmetric(horizontal: 40);
const EdgeInsets eW48 = EdgeInsets.symmetric(horizontal: 48);

// Border Radius
const BorderRadius br0 = BorderRadius.all(Radius.circular(0));
const BorderRadius br4 = BorderRadius.all(Radius.circular(4));
const BorderRadius br8 = BorderRadius.all(Radius.circular(8));
const BorderRadius br12 = BorderRadius.all(Radius.circular(12));
const BorderRadius br16 = BorderRadius.all(Radius.circular(16));
const BorderRadius br20 = BorderRadius.all(Radius.circular(20));
const BorderRadius br24 = BorderRadius.all(Radius.circular(24));
const BorderRadius br32 = BorderRadius.all(Radius.circular(32));
const BorderRadius br40 = BorderRadius.all(Radius.circular(40));
const BorderRadius br48 = BorderRadius.all(Radius.circular(48));

const BorderRadius brH4 = BorderRadius.vertical(top: Radius.circular(4));
const BorderRadius brH8 = BorderRadius.vertical(top: Radius.circular(8));
const BorderRadius brH12 = BorderRadius.vertical(top: Radius.circular(12));
const BorderRadius brH16 = BorderRadius.vertical(top: Radius.circular(16));
const BorderRadius brH20 = BorderRadius.vertical(top: Radius.circular(20));
const BorderRadius brH24 = BorderRadius.vertical(top: Radius.circular(24));
const BorderRadius brH32 = BorderRadius.vertical(top: Radius.circular(32));
const BorderRadius brH40 = BorderRadius.vertical(top: Radius.circular(40));
const BorderRadius brH48 = BorderRadius.vertical(top: Radius.circular(48));

const BorderRadius brW4 = BorderRadius.horizontal(left: Radius.circular(4));
const BorderRadius brW8 = BorderRadius.horizontal(left: Radius.circular(8));
const BorderRadius brW12 = BorderRadius.horizontal(left: Radius.circular(12));
const BorderRadius brW16 = BorderRadius.horizontal(left: Radius.circular(16));
const BorderRadius brW20 = BorderRadius.horizontal(left: Radius.circular(20));
const BorderRadius brW24 = BorderRadius.horizontal(left: Radius.circular(24));
const BorderRadius brW32 = BorderRadius.horizontal(left: Radius.circular(32));
const BorderRadius brW40 = BorderRadius.horizontal(left: Radius.circular(40));
const BorderRadius brW48 = BorderRadius.horizontal(left: Radius.circular(48));

const BorderRadius brTop4 = BorderRadius.only(
  topLeft: Radius.circular(4),
  topRight: Radius.circular(4),
);
const BorderRadius brTop8 = BorderRadius.only(
  topLeft: Radius.circular(8),
  topRight: Radius.circular(8),
);
const BorderRadius brTop12 = BorderRadius.only(
  topLeft: Radius.circular(12),
  topRight: Radius.circular(12),
);
const BorderRadius brTop16 = BorderRadius.only(
  topLeft: Radius.circular(16),
  topRight: Radius.circular(16),
);
const BorderRadius brTop20 = BorderRadius.only(
  topLeft: Radius.circular(20),
  topRight: Radius.circular(20),
);
const BorderRadius brTop24 = BorderRadius.only(
  topLeft: Radius.circular(24),
  topRight: Radius.circular(24),
);
const BorderRadius brTop32 = BorderRadius.only(
  topLeft: Radius.circular(32),
  topRight: Radius.circular(32),
);
const BorderRadius brTop40 = BorderRadius.only(
  topLeft: Radius.circular(40),
  topRight: Radius.circular(40),
);
const BorderRadius brTop48 = BorderRadius.only(
  topLeft: Radius.circular(48),
  topRight: Radius.circular(48),
);

const BorderRadius brBottom4 = BorderRadius.only(
  bottomLeft: Radius.circular(4),
  bottomRight: Radius.circular(4),
);
const BorderRadius brBottom8 = BorderRadius.only(
  bottomLeft: Radius.circular(8),
  bottomRight: Radius.circular(8),
);
const BorderRadius brBottom12 = BorderRadius.only(
  bottomLeft: Radius.circular(12),
  bottomRight: Radius.circular(12),
);
const BorderRadius brBottom16 = BorderRadius.only(
  bottomLeft: Radius.circular(16),
  bottomRight: Radius.circular(16),
);
const BorderRadius brBottom20 = BorderRadius.only(
  bottomLeft: Radius.circular(20),
  bottomRight: Radius.circular(20),
);
const BorderRadius brBottom24 = BorderRadius.only(
  bottomLeft: Radius.circular(24),
  bottomRight: Radius.circular(24),
);
const BorderRadius brBottom32 = BorderRadius.only(
  bottomLeft: Radius.circular(32),
  bottomRight: Radius.circular(32),
);
const BorderRadius brBottom40 = BorderRadius.only(
  bottomLeft: Radius.circular(40),
  bottomRight: Radius.circular(40),
);
const BorderRadius brBottom48 = BorderRadius.only(
  bottomLeft: Radius.circular(48),
  bottomRight: Radius.circular(48),
);

NumberFormat doubleCurrency = NumberFormat("#,##0.00", "en_US");
NumberFormat integerCurrency = NumberFormat("#,##0", "en_US");
