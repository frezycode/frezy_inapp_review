import 'package:cuty_utils/cuty_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';

class InappReviewService {
  InappReviewService({
    required this.appStoreId,
    required this.androidPackageName,
  });

  final String appStoreId;
  final String androidPackageName;

  Future<void> startInAppReview() async {
    if ([TargetPlatform.iOS, TargetPlatform.macOS]
        .contains(defaultTargetPlatform)) {
      UrlLauncherManager.launchURL(
        'itms-apps://itunes.apple.com/app/id$appStoreId?action=write-review&mt=8',
      );
      return;
    }
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      try {
        await inAppReview.requestReview();
      } catch (_) {
        _openPlaymarketReview();
      }
    } else {
      _openPlaymarketReview();
    }
  }

  void _openPlaymarketReview() {
    UrlLauncherManager.launchURL(
      'https://play.google.com/store/apps/details?id=$androidPackageName&showAllReviews=true',
    );
  }
}
