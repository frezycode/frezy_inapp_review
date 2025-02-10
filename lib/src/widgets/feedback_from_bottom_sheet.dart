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
  final Function(InAppReviewStatus status, String? message) onCompleted;

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
      _onCancel(context, closePage: false);
    }
    super.dispose();
  }

  void _onSentTap(BuildContext context, String message) {
    _reviewCompleted(InAppReviewStatus.completedNegative, message: message);
    Navigator.pop(context);
  }

  void _onLaterTap(BuildContext context) {
    _reviewCompleted(InAppReviewStatus.completedNegative);
    Navigator.pop(context);
  }

  void _onCancel(BuildContext context, {bool closePage = true}) {
    _reviewCompleted(InAppReviewStatus.canceled);
    if (closePage) Navigator.pop(context);
  }

  void _reviewCompleted(InAppReviewStatus status, {String? message}) {
    _completedByUser = true;
    widget.onCompleted(status, message);
  }
}
