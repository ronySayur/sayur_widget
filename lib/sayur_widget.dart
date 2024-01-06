// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, must_be_immutable, unnecessary_null_in_if_null_operators

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:lottie/lottie.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:card_swiper/card_swiper.dart';

import 'dart:async';

import 'package:sayur_widget/core.dart';

TextStyle YurTextStyle({
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.normal,
  Color color = Colors.black,
  FontStyle fontStyle = FontStyle.normal,
  TextDecoration decoration = TextDecoration.none,
  double letterSpacing = 0.3,
  List<Shadow> shadows = const [],
  double height = 1.0,
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
    fontFamily: 'Roboto',
    decorationStyle: TextDecorationStyle.solid,
    textBaseline: TextBaseline.ideographic,
    wordSpacing: 0.5,
    locale: const Locale('id', 'ID'),
    leadingDistribution: TextLeadingDistribution.even,
    inherit: true,
  );
}

class YurAppBar extends StatelessWidget implements PreferredSizeWidget {
  const YurAppBar({
    Key? key,
    required this.title,
    this.action,
    this.actionIcon,
    this.onPressedBack = df,
    this.centertitle = true,
    this.withLeading = true,
    this.onTap,
  }) : super(key: key);

  final String title;
  final Function()? action;
  final IconData? actionIcon;
  final Function() onPressedBack;
  final bool centertitle;
  final bool withLeading;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: withLeading
          ? IconButton(
              onPressed: () {
                Get.back();
                onPressedBack();
              },
              icon: const YurIcon(icon: Icons.arrow_back, color: primaryColor),
            )
          : Container(),
      actions: [
        if (actionIcon != null)
          IconButton(
              onPressed: () => action!(),
              icon: YurIcon(icon: actionIcon!, color: secondaryColor))
      ],
      title: YurText(
        fontSize: 20,
        text: title,
        onTap: onTap,
        color: primaryColor,
      ),
      centerTitle: centertitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class YurLoadingStack extends StatelessWidget {
  final Widget content;
  const YurLoadingStack({Key? key, required this.content}) : super(key: key);

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
    Key? key,
    required this.context,
    required this.content,
    required this.function,
    required this.isSuccess,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () => function());

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
  final bool validator;
  final bool optional;
  final bool isUpperCase;
  final TextAlign textAllignment;
  final FontWeight fontWeight;
  final Color? fillColor;
  final FloatingLabelBehavior floatingLabelBehavior;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String) onChanged;
  final Function() onComplete;
  final Function(String) onSaved;
  final Function() suffixTap;
  final Function() onTap;
  Widget? prefixIcon;
  final bool isDate;
  final bool isHours;
  String? hintText;
  final double minHour;
  final double minMinute;
  final Function(String) onFieldSubmitted;
  final DateTime? initialDate;
  final FocusNode? focusNode;
  final int maxLines;
  final BorderRadius borderRadius;

  YurForm({
    super.key,
    required this.label,
    this.controller,
    this.onTap = df,
    this.hintText,
    this.sizeField = SizeTextField.small,
    this.onChanged = dfp,
    this.onSaved = dfp,
    this.onComplete = df,
    this.suffixTap = df,
    this.withLabel = true,
    this.readOnly = false,
    this.leading = false,
    this.suffixType = SuffixType.none,
    this.obscureText = false,
    this.emailValidator = false,
    this.validator = true,
    this.optional = false,
    this.colorLabel = Colors.black,
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
  });

  @override
  Widget build(BuildContext context) {
    String? validateInput(String? value) {
      if (!validator) return null;

      return (!optional && (value?.isEmpty ?? true))
          ? '$label Tidak boleh kosong'
          : (emailValidator && value != null && !value.isValidEmail())
              ? '$label Tidak Valid'
              : (suffixType == SuffixType.password && (value?.length ?? 0) < 4)
                  ? '$label Minimal 4 karakter'
                  : null;
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

    return TextFormField(
      controller: controller,
      onTap: () {
        if (isDate) {
          DatePicker.showSimpleDatePicker(
            context,
            initialDate: initialDate ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            dateFormat: "dd-MMM-yyyy",
            titleText: label,
            itemTextStyle: const TextStyle(color: Colors.grey),
            locale: DateTimePickerLocale.en_us,
            looping: false,
          ).then((value) {
            controller!.text = value!.dateFormat("yyyy-MM-dd");
          });
        }

        if (isHours) {
          YurShowPicker(
            context: context,
            controller: controller!,
            minHour: minHour,
            minMinute: minMinute,
          );
        }
        onTap();
        YurLog(
          name: label,
          message: controller?.text ?? "textController",
        );
      },
      onFieldSubmitted: (value) {
        onFieldSubmitted(value);
        YurLog(
          name: label,
          message: controller?.text ?? "textController",
        );
      },
      onChanged: (value) {
        onChanged(value);
        YurLog(name: label, message: value);
      },
      onEditingComplete: () {
        onComplete();
        YurLog(
          name: label,
          message: controller?.text ?? "textController",
        );
      },
      focusNode: focusNode,
      initialValue: initialValue,
      onSaved: (newValue) => onSaved(newValue!),
      maxLines: maxLines,
      obscureText: obscureText,
      textInputAction: textInputAction,
      readOnly: isDate ? true : readOnly,
      validator: validateInput,
      keyboardType: keyboardType,
      textAlign: textAllignment,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      inputFormatters: [
        ...inputFormatters ?? [],
        LengthLimitingTextInputFormatter(maxLength),
        if (keyboardType == TextInputType.number)
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        if (isUpperCase) UpperCaseTextFormatter(),
      ],
      autocorrect: false,
      autofocus: false,
      scrollPhysics: const ClampingScrollPhysics(),
      decoration: InputDecoration(
        //Prefix
        prefixIcon: prefixIcon,
        prefixIconColor: primaryColor,

        //Sufix
        suffixText: suffixText,
        suffixStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: primaryColor,
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

        // Hint
        hintText: hintText ?? label,
        hintStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
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
              offset: Offset(0.5, 0.5),
            ),
          ],
        ),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: floatingLabelBehavior,
        alignLabelWithHint: true,
        filled: true,
        fillColor: fillColor,
        isDense: true,
        isCollapsed: false,

        //  ==================================> Border <==================================
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
          borderSide: const BorderSide(
            color: primaryColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}

class YurOTPForm extends StatelessWidget {
  final List<TextEditingController> otpControllers;
  final Function() onCompleted;

  const YurOTPForm({
    Key? key,
    required this.otpControllers,
    required this.onCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          otpControllers.length,
          (index) {
            final controller = otpControllers[index];
            return SizedBox(
              width: 65,
              child: YurForm(
                controller: controller,
                label: '',
                withLabel: false,
                textAllignment: TextAlign.center,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (index < otpControllers.length - 1) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      FocusScope.of(context).unfocus();
                    }
                  }
                },
                maxLength: 1,
                obscureText: false,
                isUpperCase: true,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                textInputAction: index < otpControllers.length - 1
                    ? TextInputAction.next
                    : TextInputAction.done,
              ),
            );
          },
        ),
      ),
    );
  }
}

class YurExpansionTile extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const YurExpansionTile({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: YurText(
        text: title,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(borderRadius: br16),
      expandedAlignment: Alignment.centerLeft,
      children: [
        Container(
          padding: e12,
          margin: e12,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: br12,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...children,
            ],
          ),
        ),
      ],
    );
  }
}

class YurDropdown extends StatelessWidget {
  final BuildContext context;
  final String labelText;
  final List<String> items;
  final String? selectedValue;
  final Function(String?) onChanged;
  final double fontSize;
  final Color color;
  final FontStyle fontStyle;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry contentPadding;
  final String? suffixText;

  const YurDropdown({
    super.key,
    required this.context,
    required this.labelText,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.fontSize = 14,
    this.color = Colors.black,
    this.fontStyle = FontStyle.normal,
    this.fontWeight = FontWeight.normal,
    this.contentPadding = eH16,
    this.suffixText,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return IntrinsicWidth(
      child: DropdownButtonFormField(
        value: selectedValue,
        icon: const YurIcon(icon: Icons.keyboard_arrow_down),
        iconSize: 14,
        iconEnabledColor: primaryColor,
        iconDisabledColor: Colors.grey,
        alignment: Alignment.center,
        isDense: true,
        isExpanded: true,
        enableFeedback: true,
        borderRadius: br16,
        dropdownColor: themeData.scaffoldBackgroundColor,
        elevation: 8,
        selectedItemBuilder: (context) {
          return items.map((item) {
            return Row(
              children: [
                YurText(
                  padding: eW12,
                  text: item,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: color,
                  fontStyle: fontStyle,
                ),
              ],
            );
          }).toList();
        },
        style: TextStyle(
          fontStyle: fontStyle,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
        onChanged: (value) {
          onChanged(value);
          YurLog(name: labelText, message: value!);
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(borderRadius: br16),
          floatingLabelStyle: TextStyle(
            fontStyle: fontStyle,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
          ),
          floatingLabelAlignment: FloatingLabelAlignment.center,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: contentPadding,
          filled: true,
          isDense: true,
          suffixText: suffixText,
          suffixStyle: TextStyle(
            fontStyle: fontStyle,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
          ),
          label: YurText(
            text: labelText,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            fontStyle: fontStyle,
          ),
          isCollapsed: false,
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: YurText(
                    text: item,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: color,
                    fontStyle: fontStyle,
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class YurRadioButton extends StatelessWidget {
  final String labelText;
  final List<String> options;
  final String? selectedOption;
  final Function(String?) onChanged;
  final bool isVertical;

  const YurRadioButton({
    Key? key,
    required this.labelText,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
    this.isVertical = false,
  }) : super(key: key);

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
        buildOptions(),
      ],
    );
  }

  Widget buildOptions() {
    return isVertical
        ? buildRowOptions()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buildChipOptions(),
          );
  }

  Widget buildRowOptions() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: buildChipOptions(),
    );
  }

  List<Widget> buildChipOptions() {
    return options.map((option) {
      return Padding(
        padding: EdgeInsets.only(
            right: isVertical ? 8 : 0, bottom: isVertical ? 0 : 4),
        child: InkWell(
          onTap: () => handleOptionTap(option),
          onLongPress: () => handleOptionTap(option),
          borderRadius: br48,
          child: buildChip(option),
        ),
      );
    }).toList();
  }

  void handleOptionTap(String option) {
    if (selectedOption != option) {
      onChanged(option);
    }
  }

  Widget buildChip(String option) {
    return Chip(
      padding: e8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: br16,
        side: BorderSide(
          color: selectedOption == option ? primaryColor : Colors.grey.shade500,
        ),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shadowColor: secondaryColor,
      side: BorderSide(
        color: selectedOption == option ? primaryColor : Colors.grey.shade500,
      ),
      visualDensity: VisualDensity.compact,
      backgroundColor: selectedOption == option
          ? primaryColor.withOpacity(0.2)
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
        activeColor: primaryColor,
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

    // time = picked date + picked time
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
    Key? key,
    required this.onDelete,
    required this.textController,
    required this.label,
    this.length = 300,
  }) : super(key: key);

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
          InkWell(
            onTap: () => widget.onDelete(),
            child: const YurIcon(
              icon: Icons.delete_forever,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class LottieHelper extends StatelessWidget {
  final LottieEnum lottieEnum;
  final String? text;
  final double height;

  const LottieHelper(
      {Key? key, required this.lottieEnum, this.height = 200, this.text})
      : super(key: key);

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
          fontSize: 20,
          text: text!,
          maxLines: 3,
          textAlign: TextAlign.center,
          color: primaryColor,
        ));
        children.add(gap20);
      }

      lottieWidget = buildContainer(children);

      YurLog(name: "LottieHelper", message: "$lottieEnum");
    }

    return Center(child: lottieWidget);
  }
}

class YurListViewBuilder extends StatefulWidget {
  const YurListViewBuilder(
      {super.key, required this.listItem, required this.listWidget});

  final List<dynamic> listItem;
  final List<Widget> listWidget;

  @override
  _YurListViewBuilderState createState() => _YurListViewBuilderState();
}

class _YurListViewBuilderState extends State<YurListViewBuilder> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.listItem.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: scrollController,
          builder: (context, child) {
            double itemPositionOffset = index * 80.0;
            double difference = scrollController.offset - itemPositionOffset;

            double centerScreen = Get.height * 0.8 + 60;

            double translateY = 0.0;
            double translateX = 0.0;

            if (difference > 0) {
              translateY = 0;
              translateX = (difference) / 2;
            } else if (difference < -centerScreen + 80) {
              translateY = 0;
              translateX = (difference + centerScreen - 80) / 2;
            }

            return Transform.translate(
              offset: Offset(translateX, translateY),
              child: widget.listWidget[index],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

class YurBottomSheet extends StatefulWidget {
  YurBottomSheet({
    super.key,
    this.title,
    required this.widget,
  });
  String? title;
  final Widget Function() widget;
  @override
  _YurBottomSheetState createState() => _YurBottomSheetState();
}

class _YurBottomSheetState extends State<YurBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: brTop20),
      child: Container(
        padding: e12,
        child: YurListView(
          children: [
            gap4,
            if (widget.title != null)
              Center(
                  child: YurText(
                fontSize: 20,
                text: widget.title ?? "",
              )),
            gap4,
            const YurDivider(),
            gap4,
            widget.widget(),
          ],
        ),
      ),
    );
  }
}

class YurTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final List<Widget> tabViews;
  final Color color;
  final Color unselectedLabelColor;

  const YurTabBar({
    super.key,
    required this.tabs,
    required this.tabViews,
    this.color = Colors.white,
    this.unselectedLabelColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    TabController tab = TabController(
      length: tabs.length,
      initialIndex: 0,
      vsync: Navigator.of(Get.context),
    );

    return Material(
      color: color,
      child: DefaultTabController(
        length: tabs.length,
        child: Column(
          children: [
            TabBar(
              controller: tab,
              tabs: tabs,
              labelColor: primaryColor,
              unselectedLabelColor: unselectedLabelColor,
              indicatorColor: primaryColor,
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
                YurLog(name: "TabBarHelper $tabs", message: "index: $index");
              },
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              padding: eW12,
              splashBorderRadius: br4,
              splashFactory: InkRipple.splashFactory,
            ),
            Expanded(
              child: TabBarView(
                controller: tab,
                physics: const ClampingScrollPhysics(),
                viewportFraction: 1,
                clipBehavior: Clip.antiAlias,
                dragStartBehavior: DragStartBehavior.start,
                children: tabViews,
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
          (buttonStyle == BStyle.primary ? primaryColor : secondaryColor),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: onPressed == null
              ? Colors.grey.withOpacity(0.38)
              : buttonColor ??
                  (buttonStyle == BStyle.primary
                      ? primaryColor
                      : secondaryColor),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedDefaultTextStyle(
            curve: Curves.easeInOut,
            softWrap: true,
            duration: const Duration(milliseconds: 200),
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
                  color: buttonStyle == BStyle.primary
                      ? Colors.black
                      : Colors.white,
                  offset: const Offset(0.5, 0.5),
                ),
              ],
              color: onPressed == null
                  ? Colors.grey.withOpacity(0.38)
                  : textColor ??
                      (buttonStyle == BStyle.primary
                          ? Colors.white
                          : primaryColor),
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
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        splashFactory: InkRipple.splashFactory,
        enableFeedback: true,
        side: BorderSide(
          color: onPressed == null
              ? Colors.grey.withOpacity(0.38)
              : buttonColor ??
                  (buttonStyle == BStyle.primary
                      ? primaryColor
                      : secondaryColor),
          width: 1,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: buttonColor ??
            (buttonStyle == BStyle.primary ? Colors.white : secondaryColor),
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
        animationDuration: const Duration(milliseconds: 200),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        enabledMouseCursor: SystemMouseCursors.click,
        surfaceTintColor: Colors.grey.withOpacity(0.12),
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedDefaultTextStyle(
            curve: Curves.easeInOut,
            softWrap: true,
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight ?? FontWeight.w500,
              fontStyle: FontStyle.normal,
              overflow: overflow,
              decorationStyle: TextDecorationStyle.solid,
              decoration: TextDecoration.none,
              color: onPressed == null
                  ? Colors.grey.withOpacity(0.38)
                  : primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null)
                  YurIcon(
                      icon: icon!, color: primaryColor, size: fontSize * 1.5),
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
    this.activeColor = primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: (value) {
        onToggle(value);
        YurLog(name: "YurcallSwitch", message: value ? 'ON' : 'OFF');
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

class YurImageAsset extends StatelessWidget {
  const YurImageAsset({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.fill,
    this.alignment = Alignment.center,
    this.margin,
    this.padding,
    this.borderRadius,
    this.color,
    this.centerSlice,
  }) : super(key: key);

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final Rect? centerSlice;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      color: color,
      alignment: alignment,
      errorBuilder: (context, error, stackTrace) {
        YurCrash(name: "Image.asset : $imageUrl + ", e: error);
        return const YurIcon(icon: Icons.error, color: primaryColor);
      },
      scale: 1,
      centerSlice: centerSlice,
      filterQuality: FilterQuality.high,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        } else {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: frame != null
                ? child
                : const Center(child: CircularProgressIndicator()),
          );
        }
      },
      cacheHeight: height?.toInt(),
      cacheWidth: width?.toInt(),
      gaplessPlayback: true,
      excludeFromSemantics: true,
      semanticLabel: imageUrl,
    );
  }
}

class YurImageNet extends StatelessWidget {
  const YurImageNet({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.fill,
    this.alignment = Alignment.center,
    this.margin,
    this.padding,
    this.borderRadius,
    this.color,
  }) : super(key: key);

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.color)
                : null,
          ),
          borderRadius: borderRadius,
        ),
        alignment: alignment,
        margin: margin,
        padding: padding,
      ),
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator(color: primaryColor)),
      errorWidget: (context, url, error) {
        return const Center(
          child: CircularProgressIndicator(color: primaryColor),
        );
      },
    );
  }
}

class YurText extends StatelessWidget {
  const YurText({
    Key? key,
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
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(color: backgroundColor),
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: YurTextStyle(
            fontSize: fontSize ?? 16,
            fontWeight: fontWeight ?? FontWeight.normal,
            color: color ?? Colors.black,
            fontStyle: fontStyle,
            decoration: decoration ?? TextDecoration.none,
            letterSpacing: letterSpacing,
            shadows: shadows ?? [],
            height: height ?? 1.0,
          ),
          textAlign: textAlign,
          softWrap: softWrap,
          overflow: overflow,
          maxLines: maxLines,
        ),
      ),
    );
  }
}

class YurDivider extends StatelessWidget {
  const YurDivider({
    Key? key,
    this.thickness = 2,
    this.indent = 0,
    this.endIndent = 0,
    this.color = primaryColor,
  }) : super(key: key);

  final double thickness;
  final double indent;
  final double endIndent;
  final Color color;

  @override
  Widget build(BuildContext context) {
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
    Key? key,
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
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: shrinkWrap,
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
    );
  }
}

class YurCard extends StatelessWidget {
  const YurCard({
    Key? key,
    required this.child,
    this.elevation = 4,
    this.color = Colors.white,
    this.shape = const RoundedRectangleBorder(
      borderRadius: br16,
      side: BorderSide(
        color: Colors.grey,
        width: 0.5,
      ),
    ),
    this.clipBehavior = Clip.antiAlias,
    this.margin = e0,
    this.padding = e0,
  }) : super(key: key);

  final Widget child;
  final double elevation;
  final Color color;
  final ShapeBorder shape;
  final Clip clipBehavior;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: color,
      shape: shape,
      clipBehavior: clipBehavior,
      margin: margin,
      child: child,
    );
  }
}

class YurIcon extends StatelessWidget {
  const YurIcon({
    Key? key,
    required this.icon,
    this.color,
    this.size = 24,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  final IconData icon;
  final Color? color;
  final double size;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Function()? onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      margin: margin,
      child: InkWell(
        onTap: onTap,
        child: Icon(icon, color: color, size: size),
      ),
    );
  }
}

class YurScaffold extends StatelessWidget {
  const YurScaffold({
    Key? key,
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
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      drawer: drawer,
      endDrawer: endDrawer,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      floatingActionButton: floatingActionButton,
      persistentFooterButtons: persistentFooterButtons,
      backgroundColor: backgroundColor ?? Colors.grey.shade100,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}

class YurPieChart extends StatelessWidget {
  final Map<String, double> dataMap;
  final double radius;
  final bool showLegends;
  final bool showChartValueBackground;
  final bool showChartValues;
  final bool showChartValuesInPercentage;
  final bool showChartValuesOutside;

  const YurPieChart({
    Key? key,
    required this.dataMap,
    this.radius = 100,
    this.showLegends = false,
    this.showChartValueBackground = false,
    this.showChartValues = false,
    this.showChartValuesInPercentage = false,
    this.showChartValuesOutside = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const colorList = [
      Color.fromRGBO(135, 9, 48, 1),
      Color.fromRGBO(255, 24, 24, 1),
      Color.fromRGBO(255, 191, 0, 1),
      Color.fromRGBO(255, 122, 122, 1),
    ];

    return Container(
      padding: e24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PieChart(
            dataMap: dataMap,
            animationDuration: const Duration(seconds: 2),
            chartRadius: radius,
            chartType: ChartType.ring,
            legendOptions: const LegendOptions(showLegends: false),
            totalValue:
                dataMap.values.reduce((value, element) => value + element),
            chartValuesOptions: ChartValuesOptions(
              chartValueBackgroundColor: Colors.transparent,
              chartValueStyle: TextStyle(
                color: Colors.grey.shade100,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              showChartValues: showChartValues,
              showChartValueBackground: showChartValueBackground,
              showChartValuesInPercentage: showChartValuesInPercentage,
              showChartValuesOutside: showChartValuesOutside,
            ),
            colorList: colorList,
            initialAngleInDegree: 270,
            ringStrokeWidth: 70,
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
      ),
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
                fontSize: 14,
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
  final SwiperLayout swiperLayout;
  final bool loop;
  final bool pagination;
  final bool control;
  final double? itemHeight;
  final double? itemWidth;
  final bool fullscreen;

  const YurSwiper({
    Key? key,
    required this.children,
    this.swiperLayout = SwiperLayout.DEFAULT,
    this.loop = false,
    this.pagination = true,
    this.control = true,
    this.itemHeight,
    this.itemWidth,
    this.fullscreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.35,
      child: Swiper(
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
        itemHeight: itemHeight ?? Get.height * 0.35,
        itemWidth: itemWidth ?? Get.width * 0.8,
        physics: const ClampingScrollPhysics(),
        viewportFraction: fullscreen ? 1 : 0.8,
        containerWidth: double.infinity,
        control: control
            ? children.length == 1
                ? null
                : const SwiperControl(
                    color: primaryColor,
                    disableColor: Colors.grey,
                    size: 24,
                  )
            : null,
        curve: Curves.easeInOut,
        fade: 0.3,
        loop: loop,
        pagination: pagination
            ? children.length == 1
                ? null
                : const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                      activeColor: primaryColor,
                      color: secondaryColor,
                      activeSize: 8,
                      size: 6,
                    ),
                  )
            : null,
        indicatorLayout: PageIndicatorLayout.COLOR,
        transformer: ScaleAndFadeTransformer(),
        controller: SwiperController(),
        layout: swiperLayout,
        autoplay: true,
        autoplayDelay: 10000,
        allowImplicitScrolling: true,
      ),
    );
  }
}

class YurPopMenuButton extends StatelessWidget {
  const YurPopMenuButton({
    Key? key,
    required this.onDeleted,
    this.onEdit,
    this.icon = Icons.more_vert,
    this.iconSize = 24,
    this.color = Colors.black,
    this.elevation = 8,
    this.padding = e0,
    this.backgroundColor = Colors.white,
    this.shape = const RoundedRectangleBorder(
      borderRadius: br8,
      side: BorderSide(
        color: Colors.grey,
        width: 0.5,
      ),
    ),
    this.clipBehavior = Clip.antiAlias,
  }) : super(key: key);

  final Function(int) onDeleted;
  final Function(int)? onEdit;

  final IconData icon;
  final double iconSize;
  final Color color;

  final double elevation;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final ShapeBorder shape;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          if (onEdit != null)
            const PopupMenuItem(
              value: 1,
              child: YurText(
                text: "Edit",
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          const PopupMenuItem(
            value: 2,
            child: Row(
              children: [
                YurText(
                  text: "Hapus",
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                gap8,
                YurIcon(
                  icon: Icons.delete,
                  color: primaryColor,
                  size: 16,
                ),
              ],
            ),
          ),
        ];
      },
      onSelected: (value) {
        if (value == 2) {
          YurAlertDialog(
            context: context,
            title: "Hapus Jadwal",
            message: "Yakin Mau Hapus Jadwal?",
            buttonText: "Hapus",
            onConfirm: () {
              onDeleted(value);
            },
          );
        }
      },
      icon: YurIcon(icon: icon, size: iconSize, color: color),
      elevation: elevation,
      padding: padding,
      color: backgroundColor,
      shape: shape,
      clipBehavior: clipBehavior,
      surfaceTintColor: Colors.grey.shade100,
      shadowColor: Colors.black,
    );
  }
}

class YurStarRating extends StatefulWidget {
  final int starCount;
  int rate;
  final Function(int) onRatingChanged;
  bool isReadOnly;

  YurStarRating({
    Key? key,
    this.starCount = 5,
    required this.rate,
    required this.onRatingChanged,
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  _YurStarRatingState createState() => _YurStarRatingState();
}

class _YurStarRatingState extends State<YurStarRating> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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

                    YurLog(name: "Rating", message: starValue.toString());
                  });
                },
          child: YurIcon(
            icon: starValue <= widget.rate ? Icons.grade : Icons.star_border,
            color: starValue <= widget.rate ? secondaryColor : Colors.grey,
            size: iconSize,
          ),
        );
      }),
    );
  }
}
