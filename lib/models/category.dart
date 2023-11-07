import 'package:flutter/material.dart';

enum Categories { Myself, Work, Other }

class Category {
  const Category(this.title, this.color, this.textColor);
  final String title;
  final Color color;
  final Color textColor;
}
