import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color, textColor;
  final Function f;

  RoundedButton({
    this.text,
    this.color,
    this.textColor,
    @required this.f,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: FlatButton(
        textColor: textColor,
        minWidth: size.width * 0.75,
        onPressed: f,
        padding: EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 20.0,
        ),
        color: color,
        child: Text(text),
      ),
    );
  }
}
