import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:get/get.dart';

class LoginState {
  final status = LoadStatus.initial.obs;
  final taxIdOrId = ''.obs;
  final username = ''.obs;
  final password = ''.obs;
  final isFirstSubmit = false.obs;
}
