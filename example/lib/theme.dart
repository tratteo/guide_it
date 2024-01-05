import "dart:io";

import "package:flutter/material.dart";

const double defaultRadius = 12;
const double defaultCardRadius = 24;
final BorderRadius defaultBorderRadius = BorderRadius.circular(defaultRadius);
final BorderRadius defaultCardBorderRadius = BorderRadius.circular(defaultCardRadius);
double get dockHeight => Platform.isIOS ? kToolbarHeight + 45 : 75;
// ignore: long-method
ThemeData activeTheme = ThemeData(
  //textTheme: Typography.whiteMountainView,
  textTheme: TextTheme(
    labelSmall: TextStyle(fontSize: 8, color: schemeTwo.onSurface.withOpacity(0.65)),
    labelMedium: TextStyle(fontSize: 10, color: schemeTwo.onSurface.withOpacity(0.65)),
    labelLarge: TextStyle(fontSize: 13, color: schemeTwo.onSurface.withOpacity(0.75)),
    bodySmall: TextStyle(fontSize: 13, color: schemeTwo.onSurface.withOpacity(0.75)),
    bodyMedium: const TextStyle(fontSize: 15),
    bodyLarge: const TextStyle(fontSize: 16),
    titleSmall: const TextStyle(fontSize: 16),
    titleMedium: const TextStyle(fontSize: 17),
    titleLarge: const TextStyle(fontSize: 18),
    headlineSmall: const TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
    headlineMedium: const TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
    headlineLarge: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
    displaySmall: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
    displayMedium: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
    displayLarge: const TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
  ),
  fontFamily: "Nunito",
  useMaterial3: true,
  //InkRipple.splashFactory
  //InkSplash.splashFactory
  splashFactory: InkSparkle.splashFactory,
  // COLORS
  colorScheme: schemeTwo,
  scaffoldBackgroundColor: schemeTwo.background,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  // region $Widgets
  sliderTheme: SliderThemeData(
    thumbColor: schemeTwo.onSecondary,
    activeTrackColor: schemeTwo.onSecondary,
  ),
  snackBarTheme: const SnackBarThemeData(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
  ),
  applyElevationOverlayColor: false,
  shadowColor: Colors.transparent,
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: const InputDecorationTheme(border: InputBorder.none),
    menuStyle: MenuStyle(
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: defaultBorderRadius)),
      backgroundColor: MaterialStatePropertyAll(schemeTwo.surfaceVariant),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.transparent,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(defaultRadius),
    ),
  ),
  popupMenuTheme: PopupMenuThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius))),

  chipTheme: ChipThemeData(
    backgroundColor: schemeTwo.surfaceVariant,
    checkmarkColor: schemeTwo.secondary,
    selectedColor: schemeTwo.tertiaryContainer,
    iconTheme: IconThemeData(size: 24, color: schemeTwo.secondary),
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
    side: BorderSide.none,
  ),
  dividerTheme: DividerThemeData(thickness: 1, space: 16, indent: 12, endIndent: 12, color: schemeTwo.outline),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      fixedSize: const MaterialStatePropertyAll(Size(150, 48)),
      shape: MaterialStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: defaultBorderRadius),
      ),
      padding: const MaterialStatePropertyAll(EdgeInsets.all(8)),
      elevation: const MaterialStatePropertyAll(0),
      backgroundColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return schemeTwo.surface;
        }
        return schemeTwo.onSurfaceVariant;
      }),
      overlayColor: MaterialStatePropertyAll(schemeTwo.outline.withOpacity(0.25)),
      foregroundColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return schemeTwo.onSurface;
        }
        return schemeTwo.surfaceTint;
      }),
      enableFeedback: false,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
      shape: MaterialStateProperty.resolveWith(
        (states) => RoundedRectangleBorder(borderRadius: defaultBorderRadius),
      ),
      enableFeedback: false,
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      splashFactory: InkSparkle.splashFactory,
      shape: MaterialStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: defaultBorderRadius),
      ),
      enableFeedback: false,
    ),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: schemeTwo.surfaceVariant,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    sizeConstraints: const BoxConstraints(minWidth: 54, minHeight: 54),
    extendedSizeConstraints: const BoxConstraints(minHeight: 54),
    shape: RoundedRectangleBorder(borderRadius: defaultBorderRadius),
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    color: schemeTwo.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(defaultRadius)),
    ),
  ),
  cardTheme: CardTheme(
    color: schemeTwo.surfaceVariant,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: defaultCardBorderRadius),
  ),

  // DOCK
  bottomAppBarTheme: const BottomAppBarTheme(shape: CircularNotchedRectangle()),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
    enableFeedback: true,
    selectedIconTheme: IconThemeData(size: 24),
    unselectedIconTheme: IconThemeData(size: 22),
    selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
    showSelectedLabels: true,
    showUnselectedLabels: false,
    type: BottomNavigationBarType.fixed,
  ),
  // TOOLTIP
  tooltipTheme: const TooltipThemeData(
    textAlign: TextAlign.left,
    showDuration: Duration(milliseconds: 300),
  ),
  // BOTTOM SHEET
  bottomSheetTheme: BottomSheetThemeData(
    modalBackgroundColor: schemeTwo.surfaceVariant,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(defaultCardRadius)),
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return schemeTwo.onSecondary;
      }
      return null;
    }),
    trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return schemeTwo.secondary;
      }
      return null;
    }),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
  ).copyWith(
    fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return schemeTwo.secondary;
      }
      return null;
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return schemeTwo.secondary;
      }
      return null;
    }),
  ),
  // endregion
);

const schemeTwo = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFF5F5F0),
  onPrimary: Color.fromARGB(255, 20, 20, 20),
  primaryContainer: Color(0xFFF5F5F0),
  onPrimaryContainer: Color.fromARGB(255, 20, 20, 20),
  secondary: Color(0xFFF0335F), //Color.fromARGB(255, 214, 116, 25), // secondary: Color(0xFFF0335F),
  onSecondary: Color(0xFFF5F5F0),
  secondaryContainer: Color.fromARGB(255, 40, 40, 40),
  onSecondaryContainer: Color(0xFFF5F5F0),
  tertiary: Color(0xFFA0E1FF),
  onTertiary: Color.fromARGB(255, 30, 30, 30),
  tertiaryContainer: Color.fromARGB(255, 80, 80, 85),
  onTertiaryContainer: Color(0xFFF5F5F0),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF101014),
  onBackground: Color(0xFFE0E3E2),
  surface: Color(0xFF232328),
  onSurface: Color(0xFFF5F5F0),
  surfaceVariant: Color.fromRGBO(26, 26, 30, 1),
  onSurfaceVariant: Color(0xFFF5F5F0),
  outline: Color.fromARGB(255, 60, 60, 65),
  inverseSurface: Color(0xFFE0E3E2),
  onInverseSurface: Color.fromARGB(255, 25, 20, 20),
  inversePrimary: Color(0xFF56101D),
  shadow: Color.fromARGB(100, 0, 0, 8),
  surfaceTint: Color(0xFF212D3A), //Color.fromARGB(255, 35, 31, 31),
);
