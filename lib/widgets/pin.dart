import 'package:flutter/material.dart';

class PinWidget extends StatefulWidget {
  final Function(bool) updatePin;
  const PinWidget({super.key, required this.updatePin});

  @override
  State<PinWidget> createState() => _PinWidgetState();
}

class _PinWidgetState extends State<PinWidget> {
  bool isPinned = false;
  void _togglePin() {
    setState(() {
      isPinned = !isPinned;
      widget.updatePin(isPinned);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePin,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: Image.asset(
          isPinned ? 'assets/pinned.png' : 'assets/pin.png',
        ),
      ),
    );
  }
}
