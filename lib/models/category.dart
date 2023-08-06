import 'package:flutter/material.dart';

enum Categories { Personal, Finance, Work, Other }

class Category {
  const Category(this.title, this.color);
  final String title;
  final Color color;
}
