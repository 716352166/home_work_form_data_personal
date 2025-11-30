// widgets/skill_chip.dart
import 'package:flutter/material.dart';

class SkillChip extends StatelessWidget {
  final String skill;
  final bool isSelected;
  final Function(String) onTap;

  const SkillChip({
    super.key,
    required this.skill,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
      child: FilterChip(
        label: Text(skill),
        selected: isSelected,
        onSelected: (bool selected) {
          onTap(skill);
        },
        selectedColor: Colors.blueAccent.withOpacity(0.2),
        checkmarkColor: Colors.blue,
        labelStyle: TextStyle(
          color: isSelected ? Colors.blue : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}