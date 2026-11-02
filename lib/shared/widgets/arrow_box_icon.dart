import 'package:flutter/material.dart';

/// Small rounded square with an arrow, used as trailing icon in list tiles.
class ArrowBoxIcon extends StatelessWidget {
  const ArrowBoxIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Icon(Icons.arrow_forward, size: 15, color: Colors.black),
    );
  }
}
