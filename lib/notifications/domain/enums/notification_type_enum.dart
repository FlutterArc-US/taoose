enum NotificationType {
  newReview,
  sessionRejected,
  sessionAccepted,
  sessionCanceled,
  sessionPaid,
  sessionRequested,
  newLead,
  withdrawalAccepted,
  withdrawalRejected,
  sessionCompleted;

  String get name => switch (this) {
        NotificationType.newReview => 'new_review',
        NotificationType.sessionRejected => 'session_rejected',
        NotificationType.sessionAccepted => 'session_accepted',
        NotificationType.sessionCanceled => 'session_cancelled',
        NotificationType.sessionPaid => 'session_paid',
        NotificationType.sessionRequested => 'session_requested',
        NotificationType.newLead => 'new_lead',
        NotificationType.withdrawalAccepted => 'withdrawal_accepted',
        NotificationType.withdrawalRejected => 'withdrawal_rejected',
        NotificationType.sessionCompleted => 'session_completed',
      };
}
