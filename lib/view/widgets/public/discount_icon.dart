import 'package:flutter/material.dart';

class DiscountIcon extends StatelessWidget {
  const DiscountIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(width: 2),
      ),
      child: const Icon(Icons.percent),
    );
  }
}
