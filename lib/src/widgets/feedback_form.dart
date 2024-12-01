import 'package:flutter/material.dart';
import 'package:frezy_inapp_review/src/models/models.dart';
import 'package:frezy_inapp_review/src/widgets/external/external.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({
    super.key,
    required this.locale,
    required this.onSendTap,
    required this.onLaterTap,
  });

  final FeedbackFormLocale locale;
  final Function(String message) onSendTap;
  final VoidCallback onLaterTap;

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.locale.title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            widget.locale.subtitle,
            style: theme.textTheme.bodySmall?.copyWith(fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: FilledTextField(
              controller: _textEditingController,
              maxLines: null,
              minLines: 4,
              hintText: widget.locale.textFieldHint,
            ),
          ),
          Button(
            title: widget.locale.sendButtonTitle,
            width: double.infinity,
            titleStyle: const TextStyle(color: Colors.white),
            onPressed: () => widget.onSendTap(_textEditingController.text),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: widget.onLaterTap,
              child: Text(widget.locale.laterButtonTitle),
            ),
          )
        ],
      ),
    );
  }
}
