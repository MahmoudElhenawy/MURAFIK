import 'package:flutter/material.dart';
import 'package:murafik/feature/patient/presentation/widgets/section_header.dart';

class PatientHomeSection extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Widget child;
  final double headerSpacing;

  const PatientHomeSection({
    super.key,
    required this.title,
    this.child = const SizedBox.shrink(),
    this.actionLabel,
    this.onAction,
    this.headerSpacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: title,
          actionLabel: actionLabel,
          onAction: onAction,
        ),
        SizedBox(height: headerSpacing),
        child,
      ],
    );
  }
}
