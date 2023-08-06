import 'package:flutter/material.dart';

// ColorChangingButton class with a callback function
class ColorChangingButton extends StatefulWidget {
  final Function(int) onButtonSelected;

  const ColorChangingButton({super.key, required this.onButtonSelected});

  @override
  _ColorChangingButtonState createState() => _ColorChangingButtonState();
}

class _ColorChangingButtonState extends State<ColorChangingButton> {
  int _selectedButtonIndex = 0;
  final List<String> _text = ['Personal', 'Work', 'Finance', 'Other'];

  void _selectButton(int index) {
    setState(() {
      _selectedButtonIndex = index;
      widget.onButtonSelected(index); // Call the callback function
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 14.5,
            ),
            _buildButton(0),
            const SizedBox(
              width: 29,
            ),
            _buildButton(1),
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            _buildButton(2),
            const SizedBox(
              width: 30,
            ),
            _buildButton(3),
          ],
        )
      ],
    );
  }

  Widget _buildButton(int index) {
    final isSelected = index == _selectedButtonIndex;
    final color = isSelected ? Colors.black : Colors.grey;

    return ElevatedButton(
      onPressed: () => _selectButton(index),
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
      child: Text(
        _text[index],
      ),
    );
  }
}
