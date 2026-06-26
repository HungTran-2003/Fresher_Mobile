import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:get/get.dart';

class SettingState {
  final status = LoadStatus.initial.obs;
}
