import 'package:flutter/material.dart';
import 'package:user/Theme/colors.dart';

class EntryField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String image;
  final String initialValue;
  final bool readOnly;
  final TextInputType keyboardType;
  final int maxLength;
  final int maxLines;
  final String hint;
  final IconData suffixIcon;
  final Function onTap;
  final TextCapitalization textCapitalization;
  final Function onSuffixPressed;
  final double horizontalPadding;
  final double verticalPadding;
  final FontWeight labelFontWeight;
  final double labelFontSize;
  final Color underlineColor;
  final TextStyle hintStyle;

  EntryField({
    this.controller,
    this.label,
    this.image,
    this.initialValue,
    this.readOnly,
    this.keyboardType,
    this.maxLength,
    this.hint,
    this.suffixIcon,
    this.maxLines,
    this.onTap,
    this.textCapitalization,
    this.onSuffixPressed,
    this.horizontalPadding,
    this.verticalPadding,
    this.labelFontWeight,
    this.labelFontSize,
    this.underlineColor,
    this.hintStyle,
  });

  @override
  _EntryFieldState createState() => _EntryFieldState();
}

class _EntryFieldState extends State<EntryField> {
  bool showShadow = false;
  bool showBorder = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding ?? 10.0,
          vertical: widget.verticalPadding ?? 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (widget.label != null) ...[
            Text(
              widget.label ?? '',
              style: Theme.of(context).textTheme.headline6.copyWith(
                  color: kMainTextColor,
                  fontWeight: widget.labelFontWeight ?? FontWeight.w400,
                  fontSize: widget.labelFontSize ?? 18),
            )
          ],
          const SizedBox(height: 5),
          TextField(
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.sentences,
            cursorColor: kMainColor,
            autofocus: false,
            onEditingComplete: () {
              setState(() {
                showShadow = false;
              });
            },
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap();
              }
              setState(() {
                showShadow = true;
                showBorder = true;
              });
            },
            controller: widget.controller,
            readOnly: widget.readOnly ?? false,
            keyboardType: widget.keyboardType,
            minLines: 1,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines ?? 1,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.underlineColor ?? Colors.grey[400]),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.underlineColor ?? Colors.grey[400]),
                ),
                contentPadding: const EdgeInsets.all(8.0),
                suffixIcon: widget.suffixIcon == null
                    ? null
                    : IconButton(
                        icon: Icon(
                          widget.suffixIcon,
                          size: 40.0,
                          color: Theme.of(context).backgroundColor,
                        ),
                        onPressed: widget.onSuffixPressed,
                      ),
                counterText: "",
                hintText: widget.hint,
                hintStyle: widget.hintStyle ??
                    Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: kHintColor, fontSize: 16)),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
