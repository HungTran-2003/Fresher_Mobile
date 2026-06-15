import 'package:crud_app/src/domain/models/enum/language.dart';

class AppConfigs {
  AppConfigs._();

  static const String appName = 'Finance';

  ///Paging
  static const pageSize = 40;
  static const pageSizeMax = 1000;

  ///Local
  static const defaultLanguage = Language.english;

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

  static const webClientId =
      "882097136699-5p0kk1tkp4behtk2fk74aupk8jgbrtf4.apps.googleusercontent.com";

  static const iosClientId =
      '882097136699-41keg088l84n22cjc4r58d879s3r8in6.apps.googleusercontent.com';
}
