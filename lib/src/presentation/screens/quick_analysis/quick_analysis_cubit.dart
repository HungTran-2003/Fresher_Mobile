import 'package:equatable/equatable.dart';
import 'package:finance/src/domain/models/enum/load_status.dart';
import 'package:finance/src/presentation/screens/quick_analysis/quick_analysis_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quick_analysis_state.dart';

class QuickAnalysisCubit extends Cubit<QuickAnalysisState> {
  final QuickAnalysisNavigator navigator;

  QuickAnalysisCubit({required this.navigator})
    : super(const QuickAnalysisState());
}
