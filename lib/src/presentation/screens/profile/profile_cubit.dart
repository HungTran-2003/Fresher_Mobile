import 'package:equatable/equatable.dart';
import 'package:finance/src/domain/models/enum/load_status.dart';
import 'package:finance/src/presentation/screens/profile/profile_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileNavigator navigator;

  ProfileCubit({required this.navigator}) : super(const ProfileState());
}
