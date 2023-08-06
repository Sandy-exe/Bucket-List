import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_gdsc/models/category.dart';

class tiles extends StatelessWidget {
  tiles(
      {super.key,
      required this.title,
      required this.category,
      required this.date,
      required this.onRemove});
  String title;
  Category category;
  DateTime date;
  final VoidCallback onRemove;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: category.color, borderRadius: BorderRadius.circular(20)),
        width: double.infinity,
        height: 100,
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(category.title),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Icon(
                    Icons.calendar_month_outlined,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat('yyyy-MM-dd').format(date),
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          trailing: Column(
            children: [
              const SizedBox(
                height: 6,
              ),
              IconButton(
                  onPressed: onRemove,
                  icon: const Icon(
                    Icons.check_box_outline_blank,
                    size: 40,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
