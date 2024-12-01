import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frezy_inapp_review/frezy_inapp_review.dart';
import 'package:frezy_inapp_review/src/service/inapp_review_service.dart';
import 'package:frezy_inapp_review/src/widgets/external/external.dart';
import 'package:frezy_inapp_review/src/widgets/rating_selector.dart';

import 'feedback_from_bottom_sheet.dart';

class InAppReviewBottomSheet extends StatefulWidget {
  const InAppReviewBottomSheet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.rateLaterTitle,
    required this.feedbackFormLocale,
    required this.appStoreId,
    required this.androidPackageName,

    /// Actions
    required this.onCanceled,
    required this.onNegativeCompleted,
    required this.onRateSelected,
  });

  final String title;
  final String subtitle;
  final String rateLaterTitle;
  final FeedbackFormLocale feedbackFormLocale;

  final String appStoreId;
  final String androidPackageName;

  final VoidCallback onCanceled;
  final Function(bool isGood) onRateSelected;
  final Function(InappReviewStatus status, String? message) onNegativeCompleted;

  @override
  State<InAppReviewBottomSheet> createState() => _InAppReviewBottomSheetState();
}

class _InAppReviewBottomSheetState extends State<InAppReviewBottomSheet> {
  bool? _selectedRating;

  late final inappReviewService = InappReviewService(
    appStoreId: widget.appStoreId,
    androidPackageName: widget.androidPackageName,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseBottomSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BottomSheetHeader(
            trailing: IconButton(
              onPressed: _onCancel,
              icon: Icon(Icons.close, color: theme.hintColor),
            ),
          ),
          RatingSelector(
            title: widget.title,
            subtitle: widget.subtitle,
            rateLaterTitle: widget.rateLaterTitle,
            onRatingChange: _onRateSelected,
            onRateLaterTap: _onCancel,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (_selectedRating == null) {
      _onCancel();
    }
    super.dispose();
  }

  void _onCancel() {
    widget.onCanceled.call();
  }

  Future<void> _onRateSelected(bool isGood) async {
    _selectedRating = isGood;
    widget.onRateSelected(isGood);
    final navigator = Navigator.of(context);
    if (isGood) {
      inappReviewService.startInAppReview();
      navigator.pop();
      return;
    }
    navigator.pop();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => FeedbackFormBottomSheet(
        locale: widget.feedbackFormLocale,
        onCompleted: widget.onNegativeCompleted,
      ),
    );
  }
}
