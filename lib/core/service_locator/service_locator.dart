import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:murafik/core/network/token_store.dart';
import 'package:murafik/feature/auth/data/datasources/auth_remote_datasource.dart';
import 'package:murafik/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:murafik/feature/auth/domain/repositories/auth_repository.dart';
import 'package:murafik/feature/auth/domain/usecases/login_usecase.dart';
import 'package:murafik/feature/auth/domain/usecases/register_usecase.dart';
import 'package:murafik/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:murafik/feature/doctor/data/datasources/doctor_remote_datasource.dart';
import 'package:murafik/feature/doctor/data/repositories/doctor_repository_impl.dart';
import 'package:murafik/feature/doctor/domain/repositories/doctor_repository.dart';
import 'package:murafik/feature/doctor/domain/usecases/get_doctor_all_alerts_usecase.dart';
import 'package:murafik/feature/doctor/domain/usecases/get_doctor_my_info_usecase.dart';
import 'package:murafik/feature/doctor/domain/usecases/get_doctor_patient_alerts_usecase.dart';
import 'package:murafik/feature/doctor/domain/usecases/get_doctor_patient_readings_usecase.dart';
import 'package:murafik/feature/doctor/domain/usecases/get_doctor_patients_usecase.dart';
import 'package:murafik/feature/doctor/domain/usecases/get_doctor_priority_patients_usecase.dart';
import 'package:murafik/feature/doctor/presentation/controller/doctor_alerts_cubit.dart';
import 'package:murafik/feature/doctor/presentation/controller/doctor_home_cubit.dart';
import 'package:murafik/feature/doctor/presentation/controller/doctor_patients_cubit.dart';
import 'package:murafik/feature/patient/data/datasources/patient_remote_datasource.dart';
import 'package:murafik/feature/patient/data/repositories/patient_repository_impl.dart';
import 'package:murafik/feature/patient/domain/repositories/patient_repository.dart';
import 'package:murafik/feature/patient/domain/usecases/get_alerts_usecase.dart';
import 'package:murafik/feature/patient/domain/usecases/get_device_usecase.dart';
import 'package:murafik/feature/patient/domain/usecases/get_doctor_usecase.dart';
import 'package:murafik/feature/patient/domain/usecases/get_latest_readings_usecase.dart';
import 'package:murafik/feature/patient/domain/usecases/get_my_info_usecase.dart';
import 'package:murafik/feature/patient/domain/usecases/get_readings_usecase.dart';
import 'package:murafik/feature/patient/presentation/controller/patient_home_cubit.dart';
import 'package:murafik/feature/supervisor/data/datasources/supervisor_remote_datasource.dart';
import 'package:murafik/feature/supervisor/data/repositories/supervisor_repository_impl.dart';
import 'package:murafik/feature/supervisor/domain/repositories/supervisor_repository.dart';
import 'package:murafik/feature/supervisor/domain/usecases/get_supervisor_my_info_usecase.dart';
import 'package:murafik/feature/supervisor/domain/usecases/get_supervisor_patient_alerts_usecase.dart';
import 'package:murafik/feature/supervisor/domain/usecases/get_supervisor_patient_latest_readings_usecase.dart';
import 'package:murafik/feature/supervisor/domain/usecases/get_supervisor_patient_readings_usecase.dart';
import 'package:murafik/feature/supervisor/domain/usecases/get_supervisor_patient_stats_usecase.dart';
import 'package:murafik/feature/supervisor/domain/usecases/get_supervisor_patient_usecase.dart';
import 'package:murafik/feature/supervisor/presentation/controller/supervisor_home_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<TokenStore>(TokenStore());

  // Dio
  final dio =
      Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            validateStatus: (status) => status != null,
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              final token = getIt<TokenStore>().token;
              if (token != null && token.isNotEmpty) {
                options.headers['Authorization'] = 'Bearer $token';
              }
              return handler.next(options);
            },
          ),
        );

  getIt.registerSingleton<Dio>(dio);

  // Data Sources
  getIt.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<PatientRemoteDataSource>(
    PatientRemoteDataSourceImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<DoctorRemoteDataSource>(
    DoctorRemoteDataSourceImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<SupervisorRemoteDataSource>(
    SupervisorRemoteDataSourceImpl(getIt<Dio>()),
  );

  // Repositories
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );
  getIt.registerSingleton<PatientRepository>(
    PatientRepositoryImpl(getIt<PatientRemoteDataSource>()),
  );
  getIt.registerSingleton<DoctorRepository>(
    DoctorRepositoryImpl(getIt<DoctorRemoteDataSource>()),
  );
  getIt.registerSingleton<SupervisorRepository>(
    SupervisorRepositoryImpl(getIt<SupervisorRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerSingleton<LoginUsecase>(LoginUsecase(getIt<AuthRepository>()));

  getIt.registerSingleton<RegisterUsecase>(
    RegisterUsecase(getIt<AuthRepository>()),
  );

  getIt.registerSingleton<GetMyInfoUsecase>(
    GetMyInfoUsecase(getIt<PatientRepository>()),
  );
  getIt.registerSingleton<GetDoctorUsecase>(
    GetDoctorUsecase(getIt<PatientRepository>()),
  );
  getIt.registerSingleton<GetReadingsUsecase>(
    GetReadingsUsecase(getIt<PatientRepository>()),
  );
  getIt.registerSingleton<GetLatestReadingsUsecase>(
    GetLatestReadingsUsecase(getIt<PatientRepository>()),
  );
  getIt.registerSingleton<GetAlertsUsecase>(
    GetAlertsUsecase(getIt<PatientRepository>()),
  );
  getIt.registerSingleton<GetDeviceUsecase>(
    GetDeviceUsecase(getIt<PatientRepository>()),
  );

  getIt.registerSingleton<GetDoctorMyInfoUsecase>(
    GetDoctorMyInfoUsecase(getIt<DoctorRepository>()),
  );
  getIt.registerSingleton<GetDoctorPatientsUsecase>(
    GetDoctorPatientsUsecase(getIt<DoctorRepository>()),
  );
  getIt.registerSingleton<GetDoctorPatientReadingsUsecase>(
    GetDoctorPatientReadingsUsecase(getIt<DoctorRepository>()),
  );
  getIt.registerSingleton<GetDoctorPatientAlertsUsecase>(
    GetDoctorPatientAlertsUsecase(getIt<DoctorRepository>()),
  );
  getIt.registerSingleton<GetDoctorAllAlertsUsecase>(
    GetDoctorAllAlertsUsecase(getIt<DoctorRepository>()),
  );
  getIt.registerSingleton<GetDoctorPriorityPatientsUsecase>(
    GetDoctorPriorityPatientsUsecase(getIt<DoctorRepository>()),
  );

  getIt.registerSingleton<GetSupervisorMyInfoUsecase>(
    GetSupervisorMyInfoUsecase(getIt<SupervisorRepository>()),
  );
  getIt.registerSingleton<GetSupervisorPatientUsecase>(
    GetSupervisorPatientUsecase(getIt<SupervisorRepository>()),
  );
  getIt.registerSingleton<GetSupervisorPatientReadingsUsecase>(
    GetSupervisorPatientReadingsUsecase(getIt<SupervisorRepository>()),
  );
  getIt.registerSingleton<GetSupervisorPatientLatestReadingsUsecase>(
    GetSupervisorPatientLatestReadingsUsecase(getIt<SupervisorRepository>()),
  );
  getIt.registerSingleton<GetSupervisorPatientAlertsUsecase>(
    GetSupervisorPatientAlertsUsecase(getIt<SupervisorRepository>()),
  );
  getIt.registerSingleton<GetSupervisorPatientStatsUsecase>(
    GetSupervisorPatientStatsUsecase(getIt<SupervisorRepository>()),
  );

  // Cubits
  getIt.registerSingleton<AuthCubit>(
    AuthCubit(
      loginUsecase: getIt<LoginUsecase>(),
      registerUsecase: getIt<RegisterUsecase>(),
      tokenStore: getIt<TokenStore>(),
    ),
  );

  getIt.registerSingleton<PatientHomeCubit>(
    PatientHomeCubit(
      getMyInfoUsecase: getIt<GetMyInfoUsecase>(),
      getDoctorUsecase: getIt<GetDoctorUsecase>(),
      getReadingsUsecase: getIt<GetReadingsUsecase>(),
      getLatestReadingsUsecase: getIt<GetLatestReadingsUsecase>(),
      getAlertsUsecase: getIt<GetAlertsUsecase>(),
      getDeviceUsecase: getIt<GetDeviceUsecase>(),
    ),
  );

  getIt.registerSingleton<DoctorHomeCubit>(
    DoctorHomeCubit(
      getMyInfoUsecase: getIt<GetDoctorMyInfoUsecase>(),
      getAllAlertsUsecase: getIt<GetDoctorAllAlertsUsecase>(),
      getPriorityPatientsUsecase: getIt<GetDoctorPriorityPatientsUsecase>(),
    ),
  );

  getIt.registerSingleton<DoctorPatientsCubit>(
    DoctorPatientsCubit(
      getDoctorPatientsUsecase: getIt<GetDoctorPatientsUsecase>(),
    ),
  );

  getIt.registerSingleton<DoctorAlertsCubit>(
    DoctorAlertsCubit(
      getDoctorAllAlertsUsecase: getIt<GetDoctorAllAlertsUsecase>(),
    ),
  );

  getIt.registerSingleton<SupervisorHomeCubit>(
    SupervisorHomeCubit(
      getMyInfoUsecase: getIt<GetSupervisorMyInfoUsecase>(),
      getPatientUsecase: getIt<GetSupervisorPatientUsecase>(),
      getPatientReadingsUsecase: getIt<GetSupervisorPatientReadingsUsecase>(),
      getPatientLatestReadingsUsecase:
          getIt<GetSupervisorPatientLatestReadingsUsecase>(),
      getPatientAlertsUsecase: getIt<GetSupervisorPatientAlertsUsecase>(),
      getPatientStatsUsecase: getIt<GetSupervisorPatientStatsUsecase>(),
    ),
  );
}
