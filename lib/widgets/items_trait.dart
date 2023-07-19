import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({
    super.key,
    required this.icon,
    required this.data,
  });

  final IconData icon;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: Colors.white,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          data,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
