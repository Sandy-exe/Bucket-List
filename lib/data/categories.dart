import 'package:flutter/material.dart';
import 'package:to_do_gdsc/models/category.dart';

const categories = {
  Categories.Personal: Category(
    'Personal',
    Color.fromARGB(255, 180, 224, 237),
  ),
  Categories.Work: Category(
    'Work',
    Color.fromARGB(255, 231, 255, 254),
  ),
  Categories.Finance: Category(
    'Finance',
    Color.fromARGB(255, 228, 243, 246),
  ),
  Categories.Other: Category(
    'Other',
    Color.fromARGB(255, 182, 160, 193),
  ),
};
