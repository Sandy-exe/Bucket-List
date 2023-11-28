import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bucket_list/models/category.dart';

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
        color: category.color,
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      color: category.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
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
                          child: Text(
                            category.title,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Icon(
                        Icons.calendar_month_outlined,
                        size: 20,
                        color: category.textColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('yyyy-MM-dd').format(date),
                        style:
                            TextStyle(color: category.textColor, fontSize: 17),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: onRemove,
              icon: Icon(
                Icons.exit_to_app_rounded,
                size: 50,
                color: category.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
