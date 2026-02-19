import 'package:flutter/material.dart';

class AppActionCard extends StatelessWidget {
  final String title;
  final bool isEnabled;
  final VoidCallback? onTap;
  final Color bgColor;
  final Color textColor;

  const AppActionCard({
    super.key,
    required this.title,
    required this.isEnabled,
    this.onTap,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Card(
        margin: EdgeInsets.all(0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 55,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isEnabled ? bgColor : Colors.grey.shade300,
            // boxShadow: [
            //   BoxShadow(color: Colors.black.withValues(alpha: .15), blurRadius: 10, offset: const Offset(0, 4)),
            // ],
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isEnabled ? textColor : Colors.grey.shade500,
            ),
          ),
        ),
      ),
    );
  }
}
