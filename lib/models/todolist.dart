import 'package:to_do_gdsc/models/category.dart';

class ToDoItem {
  ToDoItem({
    required this.title,
    required this.category,
    required this.dateTime,
    required this.id,
    required this.isPinned
  });
  final bool isPinned;
  final String id;
  late final String title;
  final Category category;
  final DateTime dateTime;
}
