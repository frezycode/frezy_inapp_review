enum InAppReviewStatus {
  completedPositive(0),
  completedNegative(1),
  canceled(2);

  String get code {
    switch (this) {
      case InAppReviewStatus.completedPositive:
        return 'completed_positive';
      case InAppReviewStatus.completedNegative:
        return 'completed_negative';
      case InAppReviewStatus.canceled:
        return 'canceled';
    }
  }

  final int localId;
  const InAppReviewStatus(this.localId);
}

InAppReviewStatus inappReviewStatusFromLocalId(int id) =>
    InAppReviewStatus.values.firstWhere((e) => e.localId == id);
