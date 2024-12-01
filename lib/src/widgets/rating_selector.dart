import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frezy_inapp_review/src/widgets/external/external.dart';

class RatingSelector extends StatelessWidget {
  const RatingSelector({
    super.key,
    required this.title,
    required this.subtitle,
    required this.rateLaterTitle,
    required this.onRatingChange,
    required this.onRateLaterTap,
  });

  final String title;
  final String subtitle;
  final String rateLaterTitle;
  final Function(bool rating) onRatingChange;
  final VoidCallback onRateLaterTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const success = Color(0xFF2EB648);
    const alert = Color(0xFFFF3333);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star_rounded,
              color: Colors.amber,
            ),
            SizedBox(width: 4),
            Icon(
              Icons.star_rounded,
              color: Colors.amber,
            ),
            SizedBox(width: 4),
            Icon(
              Icons.star_rounded,
              color: Colors.amber,
            ),
            SizedBox(width: 4),
            Icon(
              Icons.star_rounded,
              color: Colors.amber,
            ),
            SizedBox(width: 4),
            Icon(
              Icons.star_rounded,
              color: Colors.amber,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: theme.textTheme.headlineMedium?.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 46),
          child: Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleButton(
              size: 80,
              backgroundColor: alert.withOpacity(0.2),
              boxShadow: const [],
              icon: SvgPicture.asset(
                'packages/frezy_inapp_review/assets/thumbs-down.svg',
                height: 40,
                color: alert,
              ),
              onTap: () => onRatingChange(false),
            ),
            const SizedBox(width: 40),
            CircleButton(
              size: 80,
              backgroundColor: success.withOpacity(0.2),
              boxShadow: const [],
              icon: SvgPicture.asset(
                'packages/frezy_inapp_review/assets/thumbs-up.svg',
                height: 40,
                color: success,
              ),
              onTap: () => onRatingChange(true),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            height: 36,
            child: TextButton(
              onPressed: onRateLaterTap,
              child: Text(
                rateLaterTitle,
                style: TextStyle(color: theme.hintColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
