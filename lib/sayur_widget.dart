// ignore_for_file: non_constant_identifier_names, must_be_immutable, library_private_types_in_public_api, deprecated_member_use
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:pinput/pinput.dart';
import 'dart:async';
import 'package:sayur_widget/sayur_core.dart';
import 'package:url_launcher/url_launcher.dart';

TextStyle YurTextStyle({
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.normal,
  Color color = Colors.black,
  FontStyle fontStyle = FontStyle.normal,
  TextDecoration decoration = TextDecoration.none,
  double letterSpacing = 0.25,
  List<Shadow> shadows = const [],
  double height = 1.4,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    fontStyle: fontStyle,
    decoration: decoration,
    letterSpacing: letterSpacing,
    shadows: shadows,
    height: height,
    decorationStyle: TextDecorationStyle.wavy,
    textBaseline: TextBaseline.alphabetic,
    wordSpacing: 0.5,
    locale: const Locale('id', 'ID'),
    leadingDistribution: TextLeadingDistribution.even,
    inherit: true,
  );
}

class YurText extends StatelessWidget {
  const YurText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing = 0.3,
    this.color = Colors.black,
    this.fontStyle = FontStyle.normal,
    this.decoration = TextDecoration.none,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines = 2,
    this.height = 1.0,
    this.shadows = const [],
    this.onTap,
    this.softWrap,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.isHtml = false,
  });

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double letterSpacing;
  final Color? color;
  final FontStyle fontStyle;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int maxLines;
  final double? height;
  final List<Shadow>? shadows;
  final Function()? onTap;
  final bool? softWrap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final bool isHtml;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(color: backgroundColor),
        child: isHtml
            ? Html(
                data: text,
                shrinkWrap: true,
                style: {
                  "body": Style(
                    fontSize: FontSize(fontSize ?? 16),
                    fontWeight: fontWeight,
                    color: color,
                    fontStyle: fontStyle,
                    letterSpacing: letterSpacing,
                    textAlign: textAlign,
                  ),
                },
              )
            : AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                style: YurTextStyle(
                  fontSize: fontSize ?? 16,
                  fontWeight: fontWeight ?? FontWeight.normal,
                  color: color ?? Colors.black,
                  fontStyle: fontStyle,
                  decoration: decoration ?? TextDecoration.none,
                  letterSpacing: letterSpacing,
                  shadows: shadows ?? [],
                  height: height ?? 1.2,
                ),
                child: Text(
                  text,
                  textAlign: textAlign,
                  softWrap: softWrap,
                  overflow: overflow,
                  maxLines: maxLines,
                ),
              ),
      ),
    );
  }
}

class YurAppBar extends StatelessWidget implements PreferredSizeWidget {
  const YurAppBar({
    super.key,
    required this.title,
    this.action,
    this.actionIcon,
    this.onPressedBack = df,
    this.centerTitle = true,
    this.withLeading = true,
    this.onTitleTap,
    this.activeColor,
  });

  final String title;
  final VoidCallback? action;
  final IconData? actionIcon;
  final VoidCallback onPressedBack;
  final bool centerTitle;
  final bool withLeading;
  final VoidCallback? onTitleTap;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      leading: _buildLeading(),
      title: _buildTitle(),
      actions: _buildActions(),
    );
  }

  Widget? _buildLeading() {
    if (!withLeading) return null;

    return IconButton(
      onPressed: () {
        Get.back();
        onPressedBack();
      },
      icon: YurIcon(
        icon: Icons.arrow_back,
        color: activeColor ?? primaryRed,
      ),
      splashRadius: 24,
    );
  }

  Widget _buildTitle() {
    return GestureDetector(
      onTap: onTitleTap,
      child: YurText(
        text: title,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: activeColor ?? primaryRed,
      ),
    );
  }

  List<Widget> _buildActions() {
    if (actionIcon == null) return [];

    return [
      IconButton(
        onPressed: action,
        icon: YurIcon(
          icon: actionIcon!,
          color: secondaryYellow,
        ),
        splashRadius: 24,
      ),
      const SizedBox(width: 8),
    ];
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class YurLoadingStack extends StatelessWidget {
  final Widget content;
  const YurLoadingStack({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: content,
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: LottieHelper(
                      lottieEnum: LottieEnum.loading,
                    ),
                  ),
                  gap4,
                  YurText(
                    fontSize: 24,
                    text: "Tunggu Sebentar...",
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class YurStack extends StatelessWidget {
  final BuildContext context;
  final Widget content;
  final String message;
  final Function() function;
  final bool isSuccess;

  const YurStack({
    super.key,
    required this.context,
    required this.content,
    required this.function,
    required this.isSuccess,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    Future.delayed(3.seconds, () => function());

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(child: content),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: LottieHelper(
                      lottieEnum:
                          isSuccess ? LottieEnum.success : LottieEnum.failed,
                      text: message,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class YurForm extends StatelessWidget {
  final SizeTextField sizeField;
  final SuffixType suffixType;
  final TextEditingController? controller;
  final String? initialValue;
  final String? suffixText;
  final String label;
  final Color colorLabel;
  final Color backgroundColor;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int maxLength;
  final int flex;
  final double labelSize;
  final double fontSize;
  final bool withLabel;
  final bool readOnly;
  final bool leading;
  final bool obscureText;
  final bool emailValidator;
  final bool nikValidator;
  final bool phoneNumberValidator;
  final bool validator;
  final bool optional;
  final bool isUpperCase;
  final bool isDate;
  final bool isHours;
  final bool withTimePick;
  final bool Function(DateTime)? selectableDayPredicate;
  final bool isCantTap;
  final TextAlign textAllignment;
  final FontWeight fontWeight;
  final Color? fillColor;
  final FloatingLabelBehavior floatingLabelBehavior;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String) onChanged;
  final Function() onComplete;
  final Function() suffixTap;
  final Function() onTap;
  final Function(String) onFieldSubmitted;
  Widget? prefixIcon;
  String? hintText;
  final double minHour;
  final double minMinute;
  final DateTime? initialDate;
  final FocusNode? focusNode;
  final int maxLines;
  final BorderRadius borderRadius;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final TimeOfDay? initialTime;
  final Color? borderSideColor;
  final Color? prefixIconColor;
  final String? dateFormat;
  final EdgeInsetsGeometry padding;
  List<dynamic>? listDropDown;
  dynamic selectedDropDown;
  String? helperText;
  final FormFieldValidator<String>? externalValidator;
  final bool? enabled;

  YurForm({
    super.key,
    required this.label,
    this.controller,
    this.onTap = df,
    this.hintText,
    this.sizeField = SizeTextField.small,
    this.onChanged = dfp,
    this.onComplete = df,
    this.suffixTap = df,
    this.withLabel = true,
    this.readOnly = false,
    this.leading = false,
    this.suffixType = SuffixType.none,
    this.obscureText = false,
    this.emailValidator = false,
    this.nikValidator = false,
    this.phoneNumberValidator = false,
    this.validator = true,
    this.optional = false,
    this.colorLabel = spaceGrey,
    this.backgroundColor = Colors.white,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.maxLength = 100,
    this.flex = 1,
    this.labelSize = 14,
    this.fontSize = 14,
    this.isUpperCase = false,
    this.textAllignment = TextAlign.start,
    this.fontWeight = FontWeight.normal,
    this.fillColor,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.inputFormatters,
    this.initialValue,
    this.suffixText,
    this.prefixIcon,
    this.isDate = false,
    this.isHours = false,
    this.minHour = 0,
    this.minMinute = 0,
    this.onFieldSubmitted = dfp,
    this.initialDate,
    this.focusNode,
    this.maxLines = 1,
    this.borderRadius = br12,
    this.withTimePick = false,
    this.firstDate,
    this.lastDate,
    this.initialTime,
    this.borderSideColor,
    this.prefixIconColor,
    this.selectableDayPredicate,
    this.isCantTap = false,
    this.dateFormat,
    this.padding = e0,
    this.listDropDown,
    this.selectedDropDown,
    this.helperText,
    this.externalValidator,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    // Validasi input sesuai kriteria tertentu.
    String? validateInput(String? value) {
      // Jika validator dinonaktifkan, langsung lolos
      if (!validator) return null;

      // Jika ada validator eksternal, pakai dulu
      if (externalValidator != null) {
        final result = externalValidator!(value);
        if (result != null) return result;
      }

      // Jika tidak opsional dan kosong
      if (!optional && (value?.trim().isEmpty ?? true)) {
        return '$label tidak boleh kosong';
      }

      // Validasi email
      if (emailValidator && value != null && !value.isValidEmail()) {
        return '$label tidak valid';
      }

      // Validasi NIK
      if (nikValidator && value != null && !value.isValidNik()) {
        return '$label minimal 16 karakter dan wajib diisi';
      }

      // Validasi nomor telepon
      if (phoneNumberValidator && value != null && !value.isValidPhone()) {
        return '$label tidak valid';
      }

      // Validasi password (jika jenis password)
      if (suffixType == SuffixType.password && (value?.length ?? 0) < 4) {
        return '$label minimal 4 karakter';
      }

      return null;
    }

    final Widget suffix;
    switch (suffixType) {
      case SuffixType.password:
        suffix = InkWell(
          onTap: suffixTap,
          child: Container(
            padding: const EdgeInsets.only(right: 10),
            child: obscureText
                ? const YurIcon(icon: Icons.visibility_off)
                : const YurIcon(icon: Icons.visibility),
          ),
        );
        break;
      case SuffixType.search:
        suffix = InkWell(
          onTap: suffixTap,
          child: Container(
            padding: const EdgeInsets.only(right: 10),
            child: const YurIcon(icon: Icons.search),
          ),
        );
        break;
      case SuffixType.none:
        suffix = Container();
        break;
    }

    return Padding(
      padding: padding,
      child: TextFormField(
        controller: controller,
        onTap: isCantTap
            ? null
            : () async {
                if (isHours) {
                  YurHourPicker(
                    context: context,
                    controller: controller!,
                    minHour: minHour,
                    minMinute: minMinute,
                    onChanged: onChanged,
                  );
                } else if (isDate) {
                  DateTime initDate = DateTime.now();

                  if (controller!.text.isNotEmpty) {
                    DateTime? parsedDate = tryParseDate(controller!.text);
                    YurLog(parsedDate);
                    if (parsedDate != null) {
                      initDate = parsedDate;
                    }
                  }

                  if (initialDate != null) {
                    initDate = initialDate!;
                  }

                  await selectDate(
                    context: context,
                    initialDate: initDate,
                    firstDate: firstDate ?? DateTime(1900),
                    lastDate: lastDate ?? DateTime.now(),
                    initialTime: initialTime,
                    withTimePick: withTimePick,
                    selectableDayPredicate: selectableDayPredicate,
                  ).then((value) {
                    onChanged(value.dateFormat(dateFormat ?? "yyyy-MM-dd"));
                    if (value.isEmpty) {
                      return controller!.text = "";
                    } else {
                      return controller!.text = DateTime.parse(value)
                          .dateFormat(dateFormat ?? "yyyy-MM-dd");
                    }
                  });
                } else if (listDropDown != null) {
                  var listLocal = listDropDown;
                  await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: StatefulBuilder(builder: (context, setState) {
                          return Padding(
                            padding: e12,
                            child: Column(
                              children: [
                                YurForm(
                                  label: "Cari...",
                                  hintText: hintText ?? "Cari...",
                                  borderSideColor: borderSideColor,
                                  enabled: enabled,
                                  onChanged: (value) => setState(() {
                                    listLocal = listDropDown!
                                        .where((element) => element
                                            .toString()
                                            .toLowerCase()
                                            .contains(value.toLowerCase()))
                                        .toList();
                                  }),
                                  suffixType: SuffixType.search,
                                ),
                                gap4,
                                Row(
                                  children: [
                                    const Expanded(
                                        child: YurDivider(color: Colors.grey)),
                                    gap4,
                                    YurText(
                                      text:
                                          "Total $label : ${listLocal!.length}",
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                gap4,
                                Expanded(
                                  child: YurListBuilder(
                                    label: label,
                                    onRefresh: () {
                                      setState(() {
                                        listLocal = listDropDown;
                                      });
                                    },
                                    list: listLocal!,
                                    widgetBuilder: (p0) {
                                      return YurCard(
                                        onTap: () => setState(() {
                                          selectedDropDown = p0;
                                          controller!.text = p0.toString();

                                          YurLoading(
                                              loadingStatus: LoadingStatus.info,
                                              message:
                                                  "Data $label berhasil dipilih");
                                          onChanged(p0.toString());
                                          Get.back();
                                        }),
                                        padding: e12,
                                        margin: e4,
                                        child: YurText(text: p0.toString()),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      );
                    },
                  );
                }

                onTap();
                YurLog(
                  name: label,
                  controller?.text ?? "textController",
                );
              },
        onEditingComplete: () {
          onComplete();
          FocusScope.of(context).unfocus();
          YurLog(
            name: label,
            controller?.text ?? "textController",
          );
        },
        focusNode: focusNode,
        initialValue: initialValue,
        onChanged: (value) => onChanged(value),
        maxLines: maxLines,
        obscureText: obscureText,
        textInputAction: textInputAction,
        readOnly: isDate ? true : readOnly,
        validator: validateInput,
        keyboardType: keyboardType,
        textAlign: textAllignment,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        autocorrect: false,
        autofocus: false,
        scrollPhysics: const ClampingScrollPhysics(),
        inputFormatters: [
          ...inputFormatters ?? [],
          LengthLimitingTextInputFormatter(maxLength),
          if (keyboardType == TextInputType.number)
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          if (isUpperCase) UpperCaseTextFormatter(),
        ],
        decoration: InputDecoration(
          //Prefix
          prefixIcon:
              isDate ? const YurIcon(icon: Icons.calendar_today) : prefixIcon,
          prefixIconColor: prefixIconColor ?? primaryRed,

          //Sufix
          suffixText: suffixText,
          suffixStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: primaryRed,
          ),
          suffixIcon: suffixType == SuffixType.none ? null : suffix,

          // Label
          label: withLabel
              ? IntrinsicWidth(
                  child: Row(
                    children: [
                      Expanded(
                        child: YurText(
                          text: label,
                          fontSize: labelSize,
                          color: colorLabel,
                          fontWeight: FontWeight.w700,
                          maxLines: 1,
                        ),
                      ),
                      YurText(
                        fontSize: labelSize,
                        text: suffixType == SuffixType.search
                            ? ""
                            : !optional
                                ? ""
                                : "(opsional)",
                        color: Colors.grey,
                      ),
                    ],
                  ),
                )
              : null,

          //Helper
          helperText: helperText,
          helperMaxLines: 3,
          helperStyle: TextStyle(
            fontWeight: fontWeight,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),

          // Hint
          hintText: hintText ?? label,
          hintMaxLines: 2,
          hintStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: Colors.grey,
          ),

          // Floating Label
          floatingLabelStyle: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: labelSize,
            fontWeight: fontWeight,
            decoration: TextDecoration.none,
            overflow: TextOverflow.ellipsis,
            decorationStyle: TextDecorationStyle.dashed,
            shadows: const [
              Shadow(
                blurRadius: 3,
                color: Colors.grey,
                offset: Offset(1, 1),
              ),
            ],
          ),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: floatingLabelBehavior,
          filled: true,
          fillColor: fillColor,
          alignLabelWithHint: true,
          isDense: true,
          isCollapsed: false,

          //border
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: Colors.grey.shade500,
              width: 1,
            ),
          ),

          // enable
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: Colors.grey.shade500,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: Colors.grey.shade500,
              width: 1,
            ),
          ),

          //error
          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(color: Colors.red),
          ),
          errorStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          errorMaxLines: 2,

          //focus
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: borderSideColor ?? primaryRed,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class YurExpansionTile extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final double? titleFontSize;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool initialExpanded;
  final Widget? leading;
  final Widget? subtitle;
  final BorderRadius? borderRadius;
  final ExpansionTileController? controller;
  final VoidCallback? onTap;
  final int maxTitleLines;
  final Color? color;
  final FontWeight fontWeight;

  const YurExpansionTile({
    super.key,
    required this.title,
    required this.children,
    this.titleFontSize,
    this.padding,
    this.margin,
    this.initialExpanded = false,
    this.leading,
    this.subtitle,
    this.borderRadius,
    this.controller,
    this.onTap,
    this.maxTitleLines = 3,
    this.color,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return YurCard(
      padding: padding ?? e4,
      margin: margin ?? e0,
      onTap: onTap,
      child: ExpansionTile(
        controller: controller,
        title: YurText(
          text: title,
          fontSize: titleFontSize,
          fontWeight: fontWeight,
          maxLines: maxTitleLines,
          color: color,
        ),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? br12,
        ),
        expandedAlignment: Alignment.centerLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        initiallyExpanded: initialExpanded,
        dense: true,
        onExpansionChanged: (value) {
          YurLog(name: title, value);
        },
        leading: leading,
        subtitle: subtitle,
        childrenPadding: e4,
        children: children,
      ),
    );
  }
}

class YurDropdown<T> extends StatelessWidget {
  final String? labelText;
  final List<T> items;
  final T? selectedValue;
  final ValueChanged<T?> onChanged;
  final double fontSize;
  final Color color;
  final Color? fillColor;
  final FontStyle fontStyle;
  final FontWeight fontWeight;
  final String? suffixText;
  final EdgeInsetsGeometry padding;
  final FloatingLabelBehavior floatingLabelBehavior;
  final bool isExpanded;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;
  final String Function(T item)? itemLabelBuilder;

  const YurDropdown({
    super.key,
    this.labelText,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.fontSize = 16,
    this.color = Colors.black,
    this.fillColor,
    this.fontStyle = FontStyle.normal,
    this.fontWeight = FontWeight.normal,
    this.suffixText,
    this.padding = EdgeInsets.zero,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.isExpanded = false,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.onTap,
    this.itemLabelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final labelBuilder = itemLabelBuilder ?? (item) => item.toString();

    final dropdown = DropdownButtonFormField<T>(
      value: selectedValue,
      onTap: onTap,
      iconSize: 16,
      isExpanded: true,
      elevation: 4,
      borderRadius: borderRadius,
      isDense: true,
      padding: padding,
      icon: const YurIcon(icon: Icons.keyboard_arrow_down, color: Colors.grey),
      selectedItemBuilder: (context) =>
          items.map((item) => YurText(text: labelBuilder(item))).toList(),
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        color: color,
      ),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: borderRadius),
        filled: true,
        fillColor: fillColor,
        isDense: true,
        floatingLabelBehavior: floatingLabelBehavior,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          color: color,
        ),
        suffixText: suffixText,
        suffixStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          color: color,
        ),
        label: labelText != null
            ? YurText(
                text: labelText!,
                fontSize: fontSize,
                fontWeight: fontWeight,
                fontStyle: fontStyle,
                color: color,
              )
            : null,
      ),
      items: items
          .map((item) => DropdownMenuItem<T>(
                value: item,
                child: YurText(
                  text: labelBuilder(item),
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  fontStyle: fontStyle,
                  color: color,
                ),
              ))
          .toList(),
    );

    return isExpanded ? dropdown : IntrinsicWidth(child: dropdown);
  }
}

class YurCheckBox extends StatelessWidget {
  final String labelText;
  final List<String> options;
  final List<String> selectedOptions;
  final Function(List<String>) onChanged;
  final bool isVertical;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final YurBuildCheckbox buildCheckbox;

  const YurCheckBox({
    super.key,
    this.labelText = "",
    required this.options,
    required this.selectedOptions,
    required this.onChanged,
    this.isVertical = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.buildCheckbox = YurBuildCheckbox.chip,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText.isNotEmpty)
          YurText(text: labelText, fontSize: 14, fontWeight: FontWeight.bold),
        gap8,
        isVertical
            ? Row(
                mainAxisAlignment: mainAxisAlignment,
                children: buildCheckboxOptions())
            : Column(
                crossAxisAlignment: crossAxisAlignment,
                children: buildCheckboxOptions()),
      ],
    );
  }

  List<Widget> buildCheckboxOptions() {
    return options.map((option) {
      return buildCheckbox == YurBuildCheckbox.card
          ? Expanded(child: card(option))
          : chip(option);
    }).toList();
  }

  void handleOption(String option) {
    final newSelectedOptions = List<String>.from(selectedOptions);
    if (selectedOptions.contains(option)) {
      newSelectedOptions.remove(option);
    } else {
      newSelectedOptions.add(option);
    }
    onChanged(newSelectedOptions);
  }

  Widget card(String option) {
    return YurCard(
      onTap: () => handleOption(option),
      margin: isVertical ? eW4 : eH8,
      padding: e4,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: br8,
        side: BorderSide(
          color: selectedOptions.contains(option)
              ? Colors.red
              : Colors.grey.shade500,
        ),
      ),
      child: Row(
        children: [
          Checkbox(
            value: selectedOptions.contains(option),
            onChanged: (bool? value) => handleOption(option),
            activeColor: Colors.red,
          ),
          YurText(text: option),
        ],
      ),
    );
  }

  Widget chip(String option) {
    return Container(
      margin: isVertical ? eW4 : eH8,
      child: InkWell(
        onTap: () => handleOption(option),
        borderRadius: br48,
        child: Chip(
          backgroundColor: selectedOptions.contains(option)
              ? Colors.red.withOpacity(0.2)
              : Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: br16,
            side: BorderSide(
              color: selectedOptions.contains(option)
                  ? Colors.red
                  : Colors.grey.shade500,
            ),
          ),
          label: YurText(
            text: option,
            fontWeight: selectedOptions.contains(option)
                ? FontWeight.bold
                : FontWeight.normal,
          ),
          avatar: Checkbox(
            value: selectedOptions.contains(option),
            onChanged: (bool? value) => handleOption(option),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: br16,
              side: BorderSide(
                color: selectedOptions.contains(option)
                    ? Colors.red
                    : Colors.grey.shade500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum YurBuildCheckbox { card, chip }

enum YurBuildRadio { chip, card }

class YurRadioButton extends StatelessWidget {
  final String labelText;
  final List<String> options;
  final String? selectedOption;
  final Function(String?) onChanged;
  final bool isVertical;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final YurBuildRadio buildRadio;

  const YurRadioButton({
    super.key,
    required this.labelText,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
    this.isVertical = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.buildRadio = YurBuildRadio.chip,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YurText(
          fontSize: 14,
          text: labelText,
          fontWeight: FontWeight.bold,
        ),
        gap8,
        isVertical
            ? Row(
                mainAxisAlignment: mainAxisAlignment,
                children: buildChipOptions())
            : Column(
                crossAxisAlignment: crossAxisAlignment,
                children: buildChipOptions()),
      ],
    );
  }

  List<Widget> buildChipOptions() {
    return options.map((option) {
      return buildRadio == YurBuildRadio.card
          ? Expanded(
              child: InkWell(
                onTap: () => handleOption(option),
                borderRadius: br48,
                child: card(option),
              ),
            )
          : InkWell(
              onTap: () => handleOption(option),
              borderRadius: br48,
              child: chip(option),
            );
    }).toList();
  }

  void handleOption(String option) {
    if (selectedOption != option) onChanged(option);
  }

  Widget card(String option) {
    return YurCard(
      margin: isVertical ? eW4 : eH8,
      padding: eW8,
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Radio(
            value: option,
            groupValue: selectedOption,
            onChanged: (value) {
              onChanged(value as String);
            },
            activeColor: primaryRed,
          ),
          YurText(
            text: option,
            fontWeight:
                selectedOption == option ? FontWeight.bold : FontWeight.normal,
          ),
        ],
      ),
    );
  }

  Widget chip(String option) {
    return Container(
      margin: isVertical ? eW4 : eH8,
      child: Chip(
        padding: e8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: br16,
          side: BorderSide(
            color: selectedOption == option ? primaryRed : Colors.grey.shade500,
          ),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shadowColor: secondaryYellow,
        side: BorderSide(
            color:
                selectedOption == option ? primaryRed : Colors.grey.shade500),
        visualDensity: VisualDensity.compact,
        backgroundColor: selectedOption == option
            ? primaryRed.withOpacity(0.2)
            : Colors.grey.shade200,
        elevation: selectedOption == option ? 0 : 5,
        label: YurText(
          text: option,
          fontWeight:
              selectedOption == option ? FontWeight.bold : FontWeight.normal,
        ),
        avatar: Radio(
          value: option,
          groupValue: selectedOption,
          onChanged: onChanged,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          activeColor: primaryRed,
        ),
      ),
    );
  }
}

class YurDateTimePicker extends StatefulWidget {
  final BuildContext context;
  final String labelText;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final TimeOfDay initialTime;
  final Function(DateTime, TimeOfDay) onChanged;
  final bool withLabel;
  final Color colorLabel;
  final bool withTimePick;

  const YurDateTimePicker({
    super.key,
    required this.context,
    required this.labelText,
    required this.initialDate,
    required this.initialTime,
    required this.onChanged,
    required this.firstDate,
    required this.lastDate,
    this.withLabel = true,
    this.colorLabel = Colors.black,
    this.withTimePick = false,
  });

  @override
  _YurDateTimePickerState createState() => _YurDateTimePickerState();
}

class _YurDateTimePickerState extends State<YurDateTimePicker> {
  Future<TimeOfDay?> showTimePick() {
    return showTimePicker(
      context: context,
      initialTime: widget.initialTime,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.initialDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );

    if (widget.withTimePick && pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePick();

      if (pickedTime != null) {
        setState(() => widget.onChanged(pickedDate, pickedTime));
      }
    } else {
      setState(() => widget.onChanged(
          pickedDate ?? widget.initialDate, widget.initialTime));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    String time = widget.withTimePick
        ? "${widget.initialDate.dateFormat("dd-MM-yyyy")} ${widget.initialTime.format(context)}"
        : widget.initialDate.dateFormat("dd-MM-yyyy");

    return Stack(
      children: [
        InkWell(
          onTap: () => _selectDate(context),
          child: Container(
            padding: e16,
            margin: eH16,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade500),
              color: themeData.scaffoldBackgroundColor,
              borderRadius: br4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const YurIcon(
                  icon: Icons.calendar_today,
                  size: 24,
                ),
                Text(
                  time,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        if (widget.withLabel)
          Container(
            decoration: BoxDecoration(
              color: themeData.scaffoldBackgroundColor,
              borderRadius: brTop16,
            ),
            padding: e4,
            margin: const EdgeInsets.only(left: 8, top: 4),
            child: Text(
              widget.labelText,
              style: TextStyle(
                color: widget.colorLabel,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}

class YurAddField extends StatefulWidget {
  final String label;
  final TextEditingController textController;
  final Function onDelete;
  final int length;

  const YurAddField({
    super.key,
    required this.onDelete,
    required this.textController,
    required this.label,
    this.length = 300,
  });

  @override
  _YurAddFieldState createState() => _YurAddFieldState();
}

class _YurAddFieldState extends State<YurAddField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: e8,
      child: Row(
        children: [
          Expanded(
            child: YurForm(
              hintText: widget.label,
              maxLength: widget.length,
              withLabel: false,
              label: widget.label,
              controller: widget.textController,
            ),
          ),
          gapW12,
          YurIcon(
            onTap: () => widget.onDelete(),
            icon: Icons.delete_forever,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

Future<dynamic> YurBottomSheet({
  required BuildContext context,
  required Widget Function() widget,
  String? title,
  String? subTitle,
  double? height,
}) {
  var defaultHeight = MediaQuery.of(context).size.height;

  return showModalBottomSheet(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return AnimatedPadding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: SizedBox(
              height: height ?? defaultHeight * 0.5,
              child: YurCard(
                color: Colors.white,
                shape: const RoundedRectangleBorder(borderRadius: brTop20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (title != null)
                        YurText(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          text: title,
                        ),
                      if (subTitle != null)
                        YurText(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          text: subTitle,
                        ),
                      if (title != null || subTitle != null) ...[
                        gap4,
                        const YurDivider(),
                        gap4,
                      ],
                      widget(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

class YurTab extends StatefulWidget {
  final List<Widget> tabs;
  final List<Widget> tabViews;
  final Color color;
  final Color textColor;
  final Color unselectedLabelColor;
  final TabController? tabController;
  final int? initialIndex;

  const YurTab({
    super.key,
    required this.tabs,
    required this.tabViews,
    this.color = Colors.white,
    this.textColor = primaryRed,
    this.unselectedLabelColor = Colors.black,
    this.tabController,
    this.initialIndex,
  });

  @override
  _YurTabState createState() => _YurTabState();
}

class _YurTabState extends State<YurTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = widget.tabController ??
        TabController(
          length: widget.tabs.length,
          initialIndex: widget.initialIndex ?? 0,
          vsync: this,
        );
  }

  @override
  void didUpdateWidget(YurTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialIndex != oldWidget.initialIndex) {
      _tabController.index = widget.initialIndex ?? 0;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.color,
      child: DefaultTabController(
        length: widget.tabs.length,
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: widget.tabs,
              labelColor: widget.textColor,
              unselectedLabelColor: widget.unselectedLabelColor,
              indicatorColor: widget.textColor,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 2,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
              automaticIndicatorColorAdjustment: true,
              dividerColor: Colors.transparent,
              dragStartBehavior: DragStartBehavior.start,
              enableFeedback: true,
              physics: const ClampingScrollPhysics(),
              labelPadding: eW12,
              mouseCursor: SystemMouseCursors.click,
              onTap: (index) {
                YurLog(name: "TabBarHelper ${widget.tabs}", "index: $index");
                setState(() {
                  _tabController.index = index;
                });
              },
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              padding: eW12,
              splashBorderRadius: br4,
              splashFactory: InkRipple.splashFactory,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const ClampingScrollPhysics(),
                viewportFraction: 1,
                clipBehavior: Clip.antiAlias,
                dragStartBehavior: DragStartBehavior.start,
                children: widget.tabViews,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class YurFAB extends StatelessWidget {
  final String text;
  final BStyle buttonStyle;
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double borderRadius;
  final double fontSize;
  final double paddingVertical;
  final double paddingHorizontal;
  final int maxlines;
  final TextOverflow overflow;
  final Icon? icon;

  const YurFAB({
    super.key,
    required this.text,
    required this.buttonStyle,
    this.onPressed,
    this.buttonColor,
    this.textColor,
    this.fontWeight,
    this.borderRadius = 8.0,
    this.fontSize = 16.0,
    this.paddingVertical = 12.0,
    this.paddingHorizontal = 24.0,
    this.maxlines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      elevation: 4,
      backgroundColor: buttonColor ??
          (buttonStyle == BStyle.primaryRed ? primaryRed : secondaryYellow),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: onPressed == null
              ? Colors.grey.withOpacity(0.38)
              : buttonColor ??
                  (buttonStyle == BStyle.primaryRed
                      ? primaryRed
                      : secondaryYellow),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedDefaultTextStyle(
            curve: Curves.easeInOut,
            softWrap: true,
            duration: 200.ms,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight ?? FontWeight.w500,
              fontStyle: FontStyle.normal,
              overflow: overflow,
              decorationStyle: TextDecorationStyle.solid,
              decoration: TextDecoration.none,
              shadows: [
                Shadow(
                  blurRadius: 3,
                  color: buttonStyle == BStyle.primaryRed
                      ? Colors.black
                      : Colors.white,
                  offset: const Offset(0.5, 0.5),
                ),
              ],
              color: onPressed == null
                  ? Colors.grey.withOpacity(0.38)
                  : textColor ??
                      (buttonStyle == BStyle.primaryRed
                          ? Colors.white
                          : primaryRed),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null) icon!,
                if (icon != null) gapW12,
                Expanded(
                  child: Text(
                    text,
                    maxLines: maxlines,
                    overflow: overflow,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class YurButton extends StatelessWidget {
  final String? text;
  final BStyle buttonStyle;
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double borderRadius;
  final double fontSize;
  final double paddingVertical;
  final double paddingHorizontal;
  final int maxlines;
  final TextOverflow overflow;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final String? iconAssets;
  final double? iconAssetsHeight;
  final String? iconNetwork;
  final double? iconNetworkHeight;
  final EdgeInsetsGeometry? padding;
  final Widget? iconWidget;

  const YurButton({
    super.key,
    this.text,
    required this.buttonStyle,
    this.onPressed,
    this.buttonColor,
    this.textColor,
    this.fontWeight,
    this.borderRadius = 8.0,
    this.fontSize = 16.0,
    this.paddingVertical = 12.0,
    this.paddingHorizontal = 24.0,
    this.maxlines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.iconAssets,
    this.iconAssetsHeight,
    this.iconNetwork,
    this.iconNetworkHeight,
    this.padding,
    this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = onPressed == null
        ? Colors.grey.withOpacity(0.38)
        : buttonColor ??
            (() {
              switch (buttonStyle) {
                case BStyle.fullRed:
                  return primaryRed;
                case BStyle.primaryRed:
                  return primaryRed;
                case BStyle.primaryBlue:
                  return primaryBlue;
                case BStyle.fullWhite:
                  return Colors.white;
                case BStyle.secondaryYellow:
                  return Colors.white;
                case BStyle.spaceGrey:
                  return Colors.white;
                case BStyle.tertiaryGreen:
                  return Colors.white;

                default:
                  return secondaryYellow;
              }
            })();

    Color backgroundColor = buttonColor ??
        (() {
          switch (buttonStyle) {
            case BStyle.primaryRed:
            case BStyle.primaryBlue:
              return Colors.white;
            case BStyle.fullRed:
              return primaryRed;
            case BStyle.fullWhite:
              return Colors.white;
            case BStyle.spaceGrey:
              return Colors.grey;
            case BStyle.tertiaryGreen:
              return tertiaryGreen;
            default:
              return secondaryYellow;
          }
        })();

    Color colorText = onPressed == null
        ? Colors.grey.withOpacity(0.38)
        : textColor ??
            (() {
              switch (buttonStyle) {
                case BStyle.fullRed:
                  return Colors.white;
                case BStyle.primaryRed:
                  return primaryRed;
                case BStyle.primaryBlue:
                  return primaryBlue;
                case BStyle.secondaryYellow:
                  return Colors.white;
                case BStyle.secondaryRed:
                  return primaryRed;
                case BStyle.spaceGrey:
                  return Colors.white;
                case BStyle.tertiaryGreen:
                  return Colors.white;
                default:
                  return Colors.black87;
              }
            })();

    return Padding(
      padding: padding ?? e0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          splashFactory: InkRipple.splashFactory,
          enableFeedback: true,
          side: BorderSide(color: borderColor, width: 1),
          backgroundColor: backgroundColor,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          disabledForegroundColor: Colors.grey.withOpacity(0.38),
          disabledBackgroundColor: Colors.grey.withOpacity(0.12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            vertical: paddingVertical,
            horizontal: paddingHorizontal,
          ),
          elevation: 4,
          shadowColor: Colors.grey,
          animationDuration: 200.ms,
          visualDensity: VisualDensity.comfortable,
          enabledMouseCursor: SystemMouseCursors.click,
          surfaceTintColor: Colors.grey.withOpacity(0.12),
        ),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: AnimatedDefaultTextStyle(
              curve: Curves.easeInOut,
              softWrap: true,
              duration: 200.ms,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight ?? FontWeight.w500,
                fontStyle: FontStyle.normal,
                overflow: overflow,
                decorationStyle: TextDecorationStyle.solid,
                decoration: TextDecoration.none,
                color: colorText,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null)
                    YurIcon(
                      icon: icon!,
                      color: iconColor ?? primaryRed,
                      size: iconSize ?? fontSize * 1.5,
                    ),
                  if (iconWidget != null) iconWidget!,
                  if (iconNetwork != null)
                    YurImage(
                      imageUrl: iconNetwork!,
                      height: iconNetworkHeight ?? 24,
                    ),
                  if (iconAssets != null)
                    YurImage(
                      imageUrl: iconAssets!,
                      height: iconAssetsHeight ?? 24,
                    ),
                  if (text != null)
                    Expanded(
                      child: Text(
                        text!,
                        maxLines: maxlines,
                        overflow: overflow,
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              )),
        ),
      ),
    );
  }
}

class YurSwitch extends StatelessWidget {
  final bool value;
  final Color activeColor;
  final Function(bool) onToggle;

  const YurSwitch({
    super.key,
    required this.value,
    required this.onToggle,
    this.activeColor = primaryRed,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: (value) {
        onToggle(value);
        YurLog(name: "YurcallSwitch", value ? 'ON' : 'OFF');
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      focusNode: FocusNode(),
      trackOutlineColor:
          MaterialStateProperty.all(value ? activeColor : Colors.grey.shade500),
      dragStartBehavior: DragStartBehavior.start,
      trackOutlineWidth: MaterialStateProperty.all(1),
    );
  }
}

class YurImage extends StatelessWidget {
  const YurImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.fill,
    this.alignment = Alignment.center,
    this.margin,
    this.padding,
    this.borderRadius,
    this.color,
    this.iconError = Icons.error,
    this.border,
    this.gradient,
    this.shape = BoxShape.rectangle,
    this.boxShadow,
    this.errorWidget,
    this.onTap,
    this.centerSlice,
  });

  final String imageUrl;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final IconData iconError;
  final BoxBorder? border;
  final Gradient? gradient;
  final BoxShape shape;
  final List<BoxShadow>? boxShadow;
  final Function()? onTap;
  final Rect? centerSlice;

  bool get _isNetworkImage => imageUrl.startsWith('https');

  @override
  Widget build(BuildContext context) {
    return _isNetworkImage
        ? _buildNetworkImage(context)
        : _buildAssetImage(context);
  }

  Widget _buildNetworkImage(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          width: width,
          height: height,
          alignment: alignment,
          margin: margin,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: border,
            gradient: gradient,
            shape: shape,
            boxShadow: boxShadow,
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
              colorFilter: color != null
                  ? ColorFilter.mode(color!, BlendMode.color)
                  : null,
            ),
          ),
        ),
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(color: primaryRed),
        ),
        errorWidget: (context, url, error) {
          return errorWidget ??
              Center(
                child: Container(
                  height: height,
                  width: width,
                  margin: margin,
                  padding: padding,
                  alignment: alignment,
                  decoration: BoxDecoration(
                    shape: shape,
                    border: border,
                    gradient: gradient,
                    boxShadow: boxShadow,
                    borderRadius: borderRadius,
                  ),
                  child: YurIcon(
                    icon: iconError,
                    color: primaryRed,
                    padding: padding,
                    margin: margin,
                  ),
                ),
              );
        },
      ),
    );
  }

  Widget _buildAssetImage(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: border,
        gradient: gradient,
        shape: shape,
        boxShadow: boxShadow,
      ),
      child: Image.asset(
        imageUrl,
        fit: fit,
        color: color,
        alignment: alignment,
        centerSlice: centerSlice,
        errorBuilder: (context, error, _) {
          YurLog(name: "YurImageAsset Error : ", error.toString());
          return errorWidget ??
              const YurIcon(
                icon: Icons.error,
                color: primaryRed,
              );
        },
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          } else {
            return AnimatedSwitcher(
              duration: 200.ms,
              child: frame != null
                  ? child
                  : const Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}

class YurDivider extends StatelessWidget {
  const YurDivider({
    super.key,
    this.thickness = 0.5,
    this.indent = 0,
    this.endIndent = 0,
    this.color = Colors.grey,
    this.isVertical = false,
    this.verticalHeight = 24,
  });

  final double thickness;
  final double indent;
  final double endIndent;
  final Color color;
  final bool isVertical;
  final double verticalHeight;

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return SizedBox(
        height: verticalHeight,
        child: VerticalDivider(
          width: thickness,
          thickness: thickness,
          indent: indent,
          endIndent: endIndent,
          color: color,
        ),
      );
    }

    return Divider(
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: color,
    );
  }
}

class YurListView extends StatelessWidget {
  const YurListView({
    super.key,
    required this.children,
    this.reverse = false,
    this.shrinkWrap = true,
    this.physics = const ClampingScrollPhysics(),
    this.addAutomaticKeepAlives = false,
    this.addRepaintBoundaries = false,
    this.addSemanticIndexes = true,
    this.primary = true,
    this.padding = e0,
    this.itemExtent,
    this.cacheExtent = 50,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scrollDirection = Axis.vertical,
    this.onRefresh,
    this.controller,
    this.margin = e0,
  });

  final List<Widget> children;
  final bool reverse;
  final bool shrinkWrap;
  final ScrollPhysics physics;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final bool primary;
  final EdgeInsetsGeometry padding;
  final double? itemExtent;
  final double cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final Clip clipBehavior;
  final String? restorationId;
  final Axis scrollDirection;
  final Future<void> Function()? onRefresh;
  final ScrollController? controller;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        if (onRefresh != null) return onRefresh!();
        return Future.value();
      },
      child: Container(
        margin: margin,
        child: ListView(
          shrinkWrap: shrinkWrap,
          controller: controller,
          reverse: reverse,
          primary: primary,
          physics: physics,
          padding: padding,
          itemExtent: itemExtent,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          cacheExtent: cacheExtent,
          semanticChildCount: semanticChildCount,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          clipBehavior: clipBehavior,
          restorationId: restorationId,
          scrollDirection: scrollDirection,
          children: children,
        ),
      ),
    );
  }
}

class YurCard extends StatelessWidget {
  const YurCard({
    super.key,
    required this.child,
    this.elevation = 4,
    this.color = Colors.white,
    this.shape = const RoundedRectangleBorder(
        borderRadius: br16, side: BorderSide(color: Colors.grey, width: 0.5)),
    this.clipBehavior = Clip.antiAlias,
    this.margin = e0,
    this.padding = e0,
    this.onTap,
  });

  final Widget child;
  final double elevation;
  final Color color;
  final ShapeBorder shape;
  final Clip clipBehavior;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: color,
      shape: shape,
      clipBehavior: clipBehavior,
      margin: margin,
      child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            onTap?.call();
          },
          child: Container(
            padding: padding,
            child: child,
          )),
    ).animate().fade(duration: 500.ms, curve: Curves.easeInOut);
  }
}

class YurIcon extends StatelessWidget {
  const YurIcon({
    super.key,
    required this.icon,
    this.color,
    this.size = 24,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor = Colors.transparent,
  });

  final IconData icon;
  final Color? color;
  final double size;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Function()? onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        margin: margin,
        child: Icon(icon, color: color, size: size),
      ),
    ).animate(
      delay: 500.ms,
      effects: [const ShakeEffect()],
    );
  }
}

class YurScaffold extends StatelessWidget {
  const YurScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
    this.bottomSheet,
    this.persistentFooterButtons,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.padding = e0,
    this.canPop = true,
    this.onPopInvoked,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.safeArea = true,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomSheet;
  final List<Widget>? persistentFooterButtons;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final EdgeInsetsGeometry padding;
  final bool canPop;
  final Function(bool)? onPopInvoked;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool safeArea;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    Intl.defaultLocale = 'id_ID';
    return safeArea ? SafeArea(child: content()) : content();
  }

  PopScope content() {
    return PopScope(
      canPop: canPop,
      onPopInvoked: onPopInvoked,
      child: Scaffold(
        appBar: appBar,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        floatingActionButtonLocation: floatingActionButtonLocation,
        body: Padding(padding: padding, child: body),
        drawer: drawer,
        endDrawer: endDrawer,
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet,
        floatingActionButton: floatingActionButton,
        persistentFooterButtons: persistentFooterButtons,
        backgroundColor: backgroundColor ?? Colors.grey.shade100,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      ),
    );
  }
}

class YurPieChart extends StatelessWidget {
  final Map<String, double> dataMap;

  final bool showLegends;
  final bool percentage;
  final double sizeRatio;
  final double? textSize;

  const YurPieChart({
    super.key,
    required this.dataMap,
    this.showLegends = false,
    this.percentage = false,
    this.sizeRatio = 0.2,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    const colorList = [
      Color.fromRGBO(135, 9, 48, 1),
      Color.fromRGBO(255, 24, 24, 1),
      Color.fromRGBO(255, 191, 0, 1),
      Color.fromRGBO(255, 122, 122, 1),
    ];

    double totalValue =
        dataMap.values.reduce((value, element) => value + element);

    double chartRadius = Get.width * sizeRatio;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PieChart(
          dataMap: dataMap,
          colorList: colorList,
          initialAngleInDegree: 270,
          animationDuration: 2.seconds,
          chartRadius: chartRadius,
          ringStrokeWidth: chartRadius,
          chartType: ChartType.ring,
          totalValue: totalValue,
          legendOptions: const LegendOptions(showLegends: false),
          chartValuesOptions: ChartValuesOptions(
            showChartValues: percentage,
            showChartValuesOutside: false,
            showChartValuesInPercentage: percentage,
            chartValueBackgroundColor: Colors.transparent,
            decimalPlaces: 0,
            chartValueStyle: TextStyle(
              color: Colors.grey.shade100,
              fontWeight: FontWeight.bold,
              fontSize: textSize ?? chartRadius * 0.2,
            ),
          ),
        ),
        if (showLegends)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < dataMap.length; i++)
                DetailsLegend(
                  title: dataMap.keys.elementAt(i),
                  value: dataMap.values.elementAt(i).toStringAsFixed(0),
                  color: colorList[i],
                ),
            ],
          )
      ],
    );
  }

  DetailsLegend({
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      margin: eH4,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: br20,
              color: color,
            ),
          ),
          gap4,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YurText(
                fontSize: 10,
                text: title,
                fontWeight: FontWeight.bold,
                maxLines: 2,
              ),
              YurText(
                fontSize: 12,
                text: "Rp. ${integerCurrency.format(double.parse(value))}",
                fontWeight: FontWeight.bold,
                maxLines: 2,
              )
            ],
          )
        ],
      ),
    );
  }
}

class YurSwiper extends StatelessWidget {
  final List<Widget> children;
  final SwiperLayout layout;
  final bool loop;
  final bool showDots;
  final Alignment? dotAlignment;
  final bool showControl;
  final double? itemHeight;
  final double? itemWidth;
  final bool fullscreen;
  final double? height;
  final double? width;
  final SwiperController? controller;
  final ValueChanged<int>? onPageChanged;
  final bool autoPlay;

  const YurSwiper({
    super.key,
    required this.children,
    this.layout = SwiperLayout.DEFAULT,
    this.loop = false,
    this.showDots = true,
    this.dotAlignment,
    this.showControl = true,
    this.itemHeight,
    this.itemWidth,
    this.fullscreen = false,
    this.height,
    this.width,
    this.controller,
    this.onPageChanged,
    this.autoPlay = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? Get.height * 0.35,
      width: width ?? Get.width * 0.9,
      child: Swiper(
        itemCount: children.length,
        itemBuilder: (_, index) => children[index],
        itemHeight: itemHeight ?? Get.height * 0.35,
        itemWidth: itemWidth ?? Get.width * 0.8,
        physics: const ClampingScrollPhysics(),
        viewportFraction: fullscreen ? 1 : 0.99,
        containerWidth: double.infinity,
        curve: Curves.easeInOut,
        fade: 0.3,
        loop: loop,
        indicatorLayout: PageIndicatorLayout.COLOR,
        transformer: ScaleAndFadeTransformer(),
        controller: controller ?? SwiperController(),
        layout: layout,
        autoplay: autoPlay,
        autoplayDelay: 20000,
        allowImplicitScrolling: true,
        control: _buildControl(),
        pagination: _buildPagination(),
        onIndexChanged: onPageChanged,
      ),
    );
  }

  /// Membuat tombol navigasi swipe (arrow)
  SwiperControl? _buildControl() {
    if (!showControl || children.length == 1) return null;
    return const SwiperControl(
      color: primaryRed,
      disableColor: Colors.grey,
      size: 24,
    );
  }

  /// Membuat indikator dot (pagination)
  SwiperPagination? _buildPagination() {
    if (!showDots || children.length == 1) return null;
    return SwiperPagination(
      alignment: dotAlignment ?? Alignment.bottomCenter,
      builder: const DotSwiperPaginationBuilder(
        activeColor: primaryRed,
        color: Colors.grey,
        activeSize: 12,
        size: 6,
      ),
    );
  }
}

class YurStarRating extends StatefulWidget {
  final int starCount;
  int rate;
  final Function(int) onRatingChanged;
  bool isReadOnly;
  Color color;

  YurStarRating({
    super.key,
    this.starCount = 5,
    required this.rate,
    required this.onRatingChanged,
    this.isReadOnly = false,
    this.color = secondaryYellow,
  });

  @override
  _YurStarRatingState createState() => _YurStarRatingState();
}

class _YurStarRatingState extends State<YurStarRating> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.starCount, (index) {
        int starValue = index + 1;
        double iconSize = screenWidth / (widget.starCount * 1.25);

        return GestureDetector(
          onTap: widget.isReadOnly
              ? null
              : () {
                  setState(() {
                    widget.rate = starValue;
                    widget.onRatingChanged(starValue);

                    YurLog(name: "Rating", starValue.toString());
                  });
                },
          child: starValue <= widget.rate
              ? YurIcon(
                  icon: Icons.star_rounded,
                  color: widget.color,
                  size: iconSize,
                )
                  .animate(onComplete: (c) => c.repeat())
                  .shimmer(duration: 2000.ms)
              : YurIcon(
                  icon: Icons.star_outline_rounded,
                  color: Colors.grey,
                  size: iconSize,
                ),
        );
      }),
    );
  }
}

Pinput YurPinput({
  required BuildContext context,
  required int length,
  required TextEditingController controller,
  bool isObscure = false,
  bool isDigitsOnly = false,
  bool isReadOnly = false,
  Function()? onTap,
}) {
  final defaultPinTheme = PinTheme(
    width: MediaQuery.of(context).size.width / 6,
    height: MediaQuery.of(context).size.width / 6,
    textStyle: const TextStyle(
      fontSize: 24,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color.fromRGBO(234, 239, 243, 1),
        width: 3,
        style: BorderStyle.solid,
      ),
      borderRadius: br20,
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.05),
          offset: Offset(0, 4),
          blurRadius: 4,
        ),
      ],
      shape: BoxShape.rectangle,
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromRGBO(255, 255, 255, 0),
          Color.fromRGBO(255, 255, 255, 1),
        ],
      ),
    ),
  );

  final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
    borderRadius: BorderRadius.circular(8),
  );

  final submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration!.copyWith(
      color: const Color.fromRGBO(234, 239, 243, 1),
    ),
  );

  return Pinput(
    onCompleted: (value) {
      YurLog(name: "PINPUT_onCompleted", value.toString());
    },
    onSubmitted: (value) {
      YurLog(name: "PINPUT_onSubmitted", value.toString());
    },
    onTap: () {
      YurLog(name: "PINPUT_onTap", "onTap");

      if (onTap != null) onTap();
    },
    inputFormatters: [
      if (isDigitsOnly) FilteringTextInputFormatter.digitsOnly,
    ],
    closeKeyboardWhenCompleted: true,
    length: length,
    animationCurve: Curves.easeInOut,
    controller: controller,
    keyboardType: isDigitsOnly ? TextInputType.number : TextInputType.text,
    errorText: 'Kode OTP Salah',
    errorTextStyle: const TextStyle(color: Colors.red, fontSize: 12),
    autofillHints: const [AutofillHints.oneTimeCode],
    enableSuggestions: true,
    enabled: !isReadOnly,
    obscureText: isObscure,
    enableIMEPersonalizedLearning: true,
    animationDuration: 300.ms,
    defaultPinTheme: defaultPinTheme,
    focusedPinTheme: focusedPinTheme,
    submittedPinTheme: submittedPinTheme,
    textCapitalization: TextCapitalization.characters,
  );
}

class YurWebView extends StatefulWidget {
  const YurWebView({
    super.key,
    required this.linkWebView,
    this.title = "",
    this.isSecured = false,
    this.withAppBar = false,
    this.onInit,
    this.onDispose,
    this.onClose,
    this.preventBack = false,
  });

  final String title;
  final String linkWebView;
  final bool isSecured;
  final bool withAppBar;
  final Function()? onInit;
  final Function()? onDispose;
  final Function()? onClose;
  final bool preventBack;

  @override
  State<YurWebView> createState() => _YurWebViewState();
}

class _YurWebViewState extends State<YurWebView> {
  final Completer<void> _refreshCompleter = Completer<void>();
  late InAppWebViewController _webViewController;
  late PullToRefreshController _pullToRefreshController;
  DateTime? lastPressedTime;

  @override
  void initState() {
    super.initState();
    YurLoading(loadingStatus: LoadingStatus.show, isDismisable: false);
    if (widget.onInit != null) widget.onInit!();
    if (widget.isSecured) YurScreenShot(isOn: true);

    _pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(color: secondaryYellow),
      onRefresh: () async {
        _webViewController.reload();
        return _refreshCompleter.future;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.onDispose != null) widget.onDispose!();
    if (widget.isSecured) YurScreenShot(isOn: false);
  }

  @override
  Widget build(BuildContext context) {
    return YurScaffold(
      canPop: false,
      onPopInvoked: onPopInvoked,
      appBar: widget.withAppBar ? YurAppBar(title: widget.title) : null,
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.linkWebView)),
        androidOnPermissionRequest: androidOnPermission,
        pullToRefreshController: _pullToRefreshController,
        onWebViewCreated: onWebViewCreated,
        onLoadStop: onLoadStop,
        onLoadError: onLoadError,
        onDownloadStartRequest: onDownloadStartRequest,
        initialOptions: InAppWebViewGroupOptions(
          android: androidOptions,
          ios: iosOptions,
          crossPlatform: inAppWebViewOptions,
        ),
      ),
    );
  }

  var androidOptions = AndroidInAppWebViewOptions(
    builtInZoomControls: false,
    displayZoomControls: false,
    supportMultipleWindows: false,
    thirdPartyCookiesEnabled: true,
    useWideViewPort: true,
    forceDark: AndroidForceDark.FORCE_DARK_OFF,
    domStorageEnabled: true,
    serifFontFamily: "Roboto",
    sansSerifFontFamily: "Roboto",
    defaultFixedFontSize: 12,
    geolocationEnabled: true,
    allowContentAccess: true,
    allowFileAccess: true,
    clearSessionCache: true,
  );

  var inAppWebViewOptions = InAppWebViewOptions(
    javaScriptEnabled: true,
    useShouldOverrideUrlLoading: false,
    useOnDownloadStart: true,
    useOnLoadResource: true,
    useShouldInterceptAjaxRequest: true,
    useShouldInterceptFetchRequest: true,
    supportZoom: false,
    cacheEnabled: false,
    clearCache: true,
    allowFileAccessFromFileURLs: true,
    allowUniversalAccessFromFileURLs: true,
    disableContextMenu: false,
    javaScriptCanOpenWindowsAutomatically: true,
    userAgent:
        "Mozilla/5.0 (Linux; Android 10; SM-G960F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.181 Mobile Safari/537.36",
  );

  var iosOptions = IOSInAppWebViewOptions(
    allowsInlineMediaPlayback: true,
    allowsBackForwardNavigationGestures: true,
    isFraudulentWebsiteWarningEnabled: true,
    sharedCookiesEnabled: false,
  );

  void onPopInvoked(didPop) {
    YurLoading(loadingStatus: LoadingStatus.dismiss);
    if (widget.preventBack) return;

    final currentTime = DateTime.now();
    if (lastPressedTime == null ||
        currentTime.difference(lastPressedTime!) > const Duration(seconds: 2)) {
      lastPressedTime = currentTime;
      YurToast(message: "Tekan sekali lagi untuk keluar");
      return;
    }

    if (!didPop) {
      widget.onClose?.call() ?? Get.back();
    }
  }

  Future<PermissionRequestResponse?> androidOnPermission(
    InAppWebViewController controller,
    String origin,
    List<String> resources,
  ) async {
    return PermissionRequestResponse(
      resources: resources,
      action: PermissionRequestResponseAction.GRANT,
    );
  }

  void onWebViewCreated(InAppWebViewController controller) {
    _webViewController = controller;
    controller
      ..addJavaScriptHandler(
        handlerName: "messageChannel",
        callback: (args) => YurLog(args[0], name: "messageChannel"),
      )
      ..addJavaScriptHandler(
        handlerName: "interceptAjax",
        callback: (args) {
          YurLog(args.toString(), name: "interceptAjax");
        },
      );
  }

  void onLoadStop(
    InAppWebViewController controller,
    Uri? url,
  ) {
    YurLog(url.toString(), name: "onLoadStop");
    if (!_refreshCompleter.isCompleted) {
      _refreshCompleter.complete();
    }
    YurLoading(loadingStatus: LoadingStatus.dismiss);
    _pullToRefreshController.endRefreshing();
  }

  void onLoadError(
    InAppWebViewController controller,
    Uri? url,
    int code,
    String message,
  ) {
    YurLog(message, name: "onLoadError");
    if (!_refreshCompleter.isCompleted) {
      _refreshCompleter.completeError(message);
    }
    _pullToRefreshController.endRefreshing();
  }

  Future<void> onDownloadStartRequest(
    InAppWebViewController controller,
    DownloadStartRequest url,
  ) async {
    if (url.toString().toLowerCase().endsWith('.pdf')) {
      if (await canLaunch(url.toString())) {
        await launch(url.toString());
      } else {
        YurLog("Could not launch PDF viewer");
      }
    } else {
      Directory? tempDir = await getExternalStorageDirectory();
      await FlutterDownloader.enqueue(
        url: url.url.toString(),
        fileName: url.suggestedFilename,
        savedDir: tempDir?.path ?? "",
        showNotification: true,
        requiresStorageNotLow: false,
        openFileFromNotification: true,
        saveInPublicStorage: true,
        allowCellular: true,
      );
    }
  }
}

class YurTakePhoto extends StatefulWidget {
  YurTakePhoto({super.key, required this.image});

  XFile? image;

  @override
  _YurTakePhotoState createState() => _YurTakePhotoState();
}

class _YurTakePhotoState extends State<YurTakePhoto> {
  late ImagePicker _picker;

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return YurScaffold(
      appBar: const YurAppBar(title: "Take Photo"),
      body: Center(
        child: widget.image == null
            ? const CircularProgressIndicator()
            : Image.file(File(widget.image!.path)),
      ),
      floatingActionButton: FloatingActionButton(
        child: const YurIcon(icon: Icons.camera),
        onPressed: () async {
          try {
            XFile? pickedImage =
                await _picker.pickImage(source: ImageSource.camera);

            if (pickedImage != null) {
              setState(() {
                widget.image = pickedImage;
              });
            }
          } catch (e) {
            YurLog(name: "YurTakePhoto", e.toString());
          }
        },
      ),
    );
  }
}

class LottieHelper extends StatelessWidget {
  final LottieEnum lottieEnum;
  final String? text;
  final double height;

  const LottieHelper({
    super.key,
    required this.lottieEnum,
    this.height = 200,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    Widget lottieWidget;

    Widget buildContainer(List<Widget> children) {
      return Container(
        margin: eH48,
        padding: eW16,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: br16,
          border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      );
    }

    if (lottieEnum == LottieEnum.loading) {
      lottieWidget = Stack(
        children: [
          Lottie.asset('assets/json/loading.json'),
          const Positioned.fill(
              child: Center(child: CircularProgressIndicator())),
        ],
      );
    } else {
      List<Widget> children = [
        Lottie.asset(
          lottieEnum == LottieEnum.failed
              ? 'assets/json/failed.json'
              : 'assets/json/success.json',
          height: height,
        ),
      ];

      if (text != null) {
        children.add(gap20);
        children.add(YurText(
          fontSize: 18,
          text: text!,
          maxLines: 3,
          textAlign: TextAlign.center,
          color: primaryRed,
        ));
        children.add(gap20);
      }

      lottieWidget = buildContainer(children);

      YurLog(name: "LottieHelper", "$lottieEnum");
    }

    return Center(child: lottieWidget);
  }
}

enum YurChannel { none, gps, download }

class YurNotification {
  static final FlutterLocalNotificationsPlugin flutterNotif =
      FlutterLocalNotificationsPlugin();

  static final StreamController<ReceiveNotification> streamLocalNotif =
      StreamController<ReceiveNotification>.broadcast();

  Future<void> checkNotif(BuildContext context) async {
    await YurPermissionRequest.isNotification().then((value) {
      if (!value) {
        return YurAlertDialog(
          context: Get.context,
          title: "Notifikasi",
          isDismissable: true,
          message: PermissionConstants.notification,
          buttonText: "Aktifkan Notifikasi",
          onConfirm: () => AppSettings.openAppSettings(
            type: AppSettingsType.notification,
          ),
        );
      }
    });
  }
}

class ReceiveNotification {
  ReceiveNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

class YurListBuilder<T> extends StatefulWidget {
  final String label;
  final Function()? onRefresh;
  final List<T> list;
  final Widget Function(T) widgetBuilder;
  final Widget? widgetEmpty;
  final TextEditingController? searchController;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final bool? reverse;
  final String? labelEmpty;
  final String? subtitleEmpty;
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final int? displayedItemMax;
  final Widget Function(int)? separatedWidget;
  final int Function(T a, T b)? sortBy;

  const YurListBuilder({
    super.key,
    required this.label,
    this.onRefresh,
    required this.list,
    required this.widgetBuilder,
    this.widgetEmpty,
    this.searchController,
    this.controller,
    this.padding,
    this.margin,
    this.color,
    this.reverse,
    this.labelEmpty,
    this.subtitleEmpty,
    this.shrinkWrap,
    this.physics,
    this.displayedItemMax,
    this.separatedWidget,
    this.sortBy,
  });

  @override
  _YurListBuilderState<T> createState() => _YurListBuilderState<T>();
}

class _YurListBuilderState<T> extends State<YurListBuilder<T>> {
  late List<T> filteredList;
  String get label => widget.label;

  @override
  void initState() {
    super.initState();
    filteredList = widget.list;
    widget.searchController?.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    widget.searchController?.removeListener(_onSearchChanged);
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      if (widget.searchController != null &&
          widget.searchController!.text.isNotEmpty) {
        filteredList = widget.list
            .where((e) => e
                .toString()
                .toLowerCase()
                .contains(widget.searchController!.text.toLowerCase()))
            .toList();
      } else {
        filteredList = widget.list;
      }

      // Sort the list if sortBy is provided
      if (widget.sortBy != null) {
        filteredList.sort(widget.sortBy!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _onSearchChanged();

    if (widget.list.isEmpty) {
      return widget.widgetEmpty ??
          YurEmptyItem(
            widget.labelEmpty ?? "$label tidak tersedia",
            widget.subtitleEmpty ??
                "$label tidak tersedia, Silakan periksa koneksi jaringan atau coba lagi nanti.",
          );
    }

    // Batasi jumlah item yang ditampilkan dengan `itemMax`
    final maxItems = widget.displayedItemMax ?? filteredList.length;
    // Jika jumlah item yang ditampilkan lebih dari `itemMax`, maka tampilkan `itemMax` item saja
    final displayedList = filteredList.length > maxItems
        ? filteredList.sublist(0, maxItems)
        : filteredList;

    return Container(
      margin: widget.margin ?? EdgeInsets.zero,
      child: Column(
        children: [
          if (widget.searchController != null) ...[
            YurForm(
              label: "Cari",
              controller: widget.searchController,
              prefixIcon: const YurIcon(icon: Icons.search),
              onChanged: (value) {
                setState(() {
                  if (value.isNotEmpty) {
                    filteredList = widget.list
                        .where((e) => e
                            .toString()
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  } else {
                    filteredList = widget.list;
                  }

                  // Sort after filtering
                  if (widget.sortBy != null) {
                    filteredList.sort(widget.sortBy!);
                  }
                });
              },
            ),
            gapH16,
          ],
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                if (widget.onRefresh != null) widget.onRefresh!();
                return Future.value();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(),
                  child: Container(
                    padding: widget.padding ?? EdgeInsets.zero,
                    color: widget.color,
                    child: ListView.separated(
                      reverse: widget.reverse ?? false,
                      controller: widget.controller,
                      separatorBuilder: (context, index) {
                        return widget.separatedWidget != null
                            ? widget.separatedWidget!(index)
                            : gap0;
                      },
                      shrinkWrap: widget.shrinkWrap ?? true,
                      physics: widget.physics ?? const ClampingScrollPhysics(),
                      itemCount:
                          displayedList.isEmpty ? 1 : displayedList.length,
                      itemBuilder: (context, index) {
                        if (displayedList.isEmpty) {
                          return YurEmptyItem(
                            "${widget.searchController!.text} tidak tersedia",
                            "Tidak ada data yang sesuai dengan kriteria pencarian Anda. Silakan coba dengan kata kunci yang berbeda.",
                          );
                        }
                        return widget.widgetBuilder(displayedList[index]);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget YurEmptyItem(
  String title,
  String subtitle, {
  EdgeInsetsGeometry? padding,
}) {
  return Center(
    child: Container(
      padding: padding ?? e12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const YurIcon(
            icon: Icons.sentiment_dissatisfied_rounded,
            size: 120,
            color: primaryRed,
          ).animate(onComplete: (c) => c.repeat(reverse: true)).move(
                duration: 500.ms,
                curve: Curves.easeInOut,
                begin: const Offset(0, -10),
                end: const Offset(0, 10),
              ),
          gap20,
          YurText(
            text: title,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
            fontSize: 24,
            maxLines: 3,
          ),
          gap12,
          YurText(
            text: subtitle,
            textAlign: TextAlign.center,
            fontSize: 12,
          ),
        ],
      ),
    ),
  );
}

//badge
class YurBadge extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final double fontSize;
  final double padding;
  final double borderRadius;
  final double elevation;
  final double margin;

  const YurBadge({
    super.key,
    required this.text,
    this.color = primaryRed,
    this.textColor = Colors.white,
    this.fontSize = 12,
    this.padding = 4,
    this.borderRadius = 8,
    this.elevation = 0,
    this.margin = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: elevation,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: YurText(
        text: text,
        color: textColor,
        fontSize: fontSize,
      ),
    );
  }
}
