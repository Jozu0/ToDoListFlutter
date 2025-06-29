import 'package:flutter/material.dart';
import 'package:namer_app/theme/app_colors.dart';


class TaskSelectionCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const TaskSelectionCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(), // important ici
        shrinkWrap: true, // pour que GridView ne prenne pas toute la hauteur
        padding: const EdgeInsets.symmetric(horizontal: 4),
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: AppColors.generalBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
              ),
            ),
          ),
          const SizedBox(width:10),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 6),
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 19,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}