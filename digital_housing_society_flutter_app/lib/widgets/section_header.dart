import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.actionText, this.onAction});

  final String title;
  final String? actionText;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.primaryText),
        ),
        if (actionText != null)
          TextButton(
            onPressed: onAction,
            child: Text(actionText!, style: const TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.w900)),
          ),
      ],
    );
  }
}
