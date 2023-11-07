import 'package:flutter/material.dart';
import 'package:to_do_gdsc/models/category.dart';

const categories = {
  Categories.Myself: Category(
    'Myself',
    Color(0xFFeedcda),
    Color.fromARGB(255, 0, 0, 0),
  ),
  Categories.Work: Category(
    'Work',
  Color(0xFF423c48),
  Color.fromARGB(255, 255, 255, 255),
  ),
  Categories.Other: Category(
    'Other',
    Color.fromARGB(255, 236, 182, 137),
    Color.fromARGB(255, 0, 0, 0),
  ),
};
