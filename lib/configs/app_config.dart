import 'package:crud_app/src/domain/models/enum/language.dart';

class AppConfigs {
  AppConfigs._();

  static const String appName = 'Finance';

  ///Paging
  static const pageSize = 40;
  static const pageSizeMax = 1000;

  ///Local
  static const defaultLanguage = Language.vietnamese;

  ///DateFormat

  static const dateDisplayFormat = 'dd/MM/yyyy';
  static const dateTimeDisplayFormat = 'yyyy/MM/dd　HH:mm';

  static const dateTimeAPIFormat =
      "yyyy-MM-dd'T'HH:mm:ssXXX"; //Use DateTime.parse(date) instead of ...
  static const dateAPIFormat = 'dd/MM/yyyy';

  ///Date range
  static final identityMinDate = DateTime(1900, 1, 1);
  static final identityMaxDate = DateTime.now();
  static final birthMinDate = DateTime(1900, 1, 1);
  static final birthMaxDate = DateTime.now();

  ///Font
  static const fontFamily = 'Roboto';

  ///Max file
  static const maxAttachFile = 5;

  static const scrollThreshold = 500.0;

  static const maxPerPage = 10;

  /// API Configs
  static const Duration timeOutDuration = Duration(seconds: 60);
}
