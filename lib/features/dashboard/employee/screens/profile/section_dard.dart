import 'package:flutter/material.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SectionCard({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyle().titleTextStyle(context: context)),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}
