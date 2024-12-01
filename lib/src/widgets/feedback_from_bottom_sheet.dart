import 'package:flutter/material.dart';
import 'package:frezy_inapp_review/frezy_inapp_review.dart';
import 'package:frezy_inapp_review/src/widgets/external/external.dart';
import 'package:frezy_inapp_review/src/widgets/feedback_form.dart';

class FeedbackFormBottomSheet extends StatefulWidget {
  const FeedbackFormBottomSheet({
    super.key,
    required this.locale,
    required this.onCompleted,
  });

  final FeedbackFormLocale locale;
  final Function(InappReviewStatus status, String? message) onCompleted;

  @override
  State<FeedbackFormBottomSheet> createState() =>
      _FeedbackFormBottomSheetState();
}

class _FeedbackFormBottomSheetState extends State<FeedbackFormBottomSheet> {
  var _completedByUser = false;

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
              onPressed: () => _onCancel(context),
              icon: Icon(Icons.close, color: theme.hintColor),
            ),
          ),
          FeedbackForm(
            locale: widget.locale,
            onLaterTap: () => _onLaterTap(context),
            onSendTap: (msg) => _onSentTap(context, msg),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (!_completedByUser) {
      _onCancel(context);
    }
    super.dispose();
  }

  void _onSentTap(BuildContext context, String message) {
    _reviewCompleted(InappReviewStatus.completedNegative, message: message);
  }

  void _onLaterTap(BuildContext context) {
    _reviewCompleted(InappReviewStatus.completedNegative);
  }

  void _onCancel(BuildContext context) {
    widget.onCompleted(InappReviewStatus.canceled, null);
  }

  void _reviewCompleted(InappReviewStatus status, {String? message}) {
    _completedByUser = true;
    widget.onCompleted(status, message);
  }
}
