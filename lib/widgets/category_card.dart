import 'package:flutter/material.dart';

import '../globals/styles/text_styles.dart';

class CategoryCard extends StatelessWidget {
  final String category;
  final bool isSelected;

  const CategoryCard({super.key, required this.category, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.indigo.shade200 : Colors.indigo.shade50,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          category,
          style: homePostTitle.copyWith(color: isSelected ? Colors.white : Colors.black87, fontSize: 14),
        ),
      ),
    );
  }
}
