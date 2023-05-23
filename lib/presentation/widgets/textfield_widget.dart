import 'package:flutter/material.dart';

class DetailsTextFieldWidget extends StatelessWidget {
  const DetailsTextFieldWidget({
    super.key,
    required this.size,
    required this.fieldName,
    this.hideField = false,
    this.numPad = false,
    this.colorValue = Colors.white,
    this.enableTextField = true,
    this.height,
    this.maxLines = 1,
    this.textString,
    required this.textController,
  });

  final Size size;
  final String fieldName;
  final String? textString;
  final bool hideField;
  final bool numPad;
  final bool enableTextField;
  final Color colorValue;
  final double? height;
  final int maxLines;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    !enableTextField
        ? WidgetsBinding.instance.addPostFrameCallback((_) {
            textController.text = textString ?? "";
          })
        : null;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: colorValue,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                fieldName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              TextField(
                // maxLength: 50,
                controller: textController,
                maxLines: maxLines,
                enabled: enableTextField,
                obscureText: hideField,
                keyboardType: numPad ? TextInputType.phone : null,
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Enter here',
                  border: InputBorder.none,
                  labelStyle: TextStyle(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
