part of 'localization_manager.dart';

const String defaultFormat = 'yyyy-MM-dd hh:mm:ss';

extension Translations on String {
  String get translate =>
      serviceLocator<LocalizationManager>().getTranslationOf(this);
}

extension DateTimeFormat on DateTime {
  String formatDate({String format = defaultFormat}) =>
      DateFormat(format).format(this);
}

extension DateTimeOperations on String {
  DateTime get parseDate => DateTime.parse(this);

  /// It will return 1 if first date after second date
  /// And return 0 if second date is after first date
  int compare(String secondDate) =>
      parseDate.isAfter(secondDate.parseDate) ? 1 : 0;
}
