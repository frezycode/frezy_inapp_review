enum InappReviewStatus {
  completedPositive(0),
  completedNegative(1),
  canceled(2);

  String get code {
    switch (this) {
      case InappReviewStatus.completedPositive:
        return 'completed_positive';
      case InappReviewStatus.completedNegative:
        return 'completed_negative';
      case InappReviewStatus.canceled:
        return 'canceled';
    }
  }

  final int localId;
  const InappReviewStatus(this.localId);
}

InappReviewStatus inappReviewStatusFromLocalId(int id) =>
    InappReviewStatus.values.firstWhere((e) => e.localId == id);
