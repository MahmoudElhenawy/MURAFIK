import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:murafik/feature/patient/presentation/controller/patient_home_view_data.dart';

class SupervisorHomeState {
  final PatientHomeViewData data;

  const SupervisorHomeState({required this.data});
}

class SupervisorHomeCubit extends Cubit<SupervisorHomeState> {
  SupervisorHomeCubit({PatientHomeViewData? initialData})
    : super(
        SupervisorHomeState(data: initialData ?? PatientHomeViewData.preview),
      );

  void updateData(PatientHomeViewData data) {
    emit(SupervisorHomeState(data: data));
  }
}
