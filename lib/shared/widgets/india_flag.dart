import 'package:flutter/material.dart';

class IndiaFlag extends StatelessWidget {
  const IndiaFlag({super.key, this.size = 22});
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: const [
                Expanded(child: ColoredBox(color: Color(0xFFFF9933), child: SizedBox.expand())),
                Expanded(child: ColoredBox(color: Colors.white, child: SizedBox.expand())),
                Expanded(child: ColoredBox(color: Color(0xFF138808), child: SizedBox.expand())),
              ],
            ),
            Container(
              width: size * 0.3,
              height: size * 0.3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF000080), width: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
