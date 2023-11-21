enum NotificationTabIndex{
  all,
  promotion,
  transaction,
  info;

  bool get isAll => this == NotificationTabIndex.all;
  bool get isPromotion => this == NotificationTabIndex.promotion;
  bool get isTransaction => this == NotificationTabIndex.transaction;
  bool get isInfo => this == NotificationTabIndex.info;


  String get tab => switch (this){
  NotificationTabIndex.all => 'All',
  NotificationTabIndex.promotion => 'Promotion',
  NotificationTabIndex.transaction => 'Transaction',
  NotificationTabIndex.info => 'Info',
  };
}
