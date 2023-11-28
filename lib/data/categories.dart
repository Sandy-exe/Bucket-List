import 'package:flutter/material.dart';
import 'package:bucket_list/models/category.dart';

const categories = {
  Categories.Myself: Category(
    'Myself',
    Color.fromARGB(255, 52, 51, 51),
    Color.fromARGB(255, 255, 255, 255),
  ),
  Categories.Work: Category(
    'Work',
    Color(0xFF4A9487),
    Color.fromARGB(255, 255, 255, 255),
  ),
  Categories.Other: Category(
    'Other',
    Color.fromARGB(255, 140, 79, 191),
    Color.fromARGB(255, 255, 255, 255),
  ),
};
