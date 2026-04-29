import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:murafik/feature/patient/presentation/controller/patient_home_view_data.dart';

class PatientHomeState {
  final PatientHomeViewData data;

  const PatientHomeState({required this.data});
}

class PatientHomeCubit extends Cubit<PatientHomeState> {
  PatientHomeCubit({PatientHomeViewData? initialData})
    : super(PatientHomeState(data: initialData ?? PatientHomeViewData.preview));

  void updateData(PatientHomeViewData data) {
    emit(PatientHomeState(data: data));
  }
}
