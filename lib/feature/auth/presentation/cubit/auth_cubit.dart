import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:murafik/core/network/token_store.dart';
import 'package:murafik/feature/auth/domain/entities/auth_response_entity.dart';
import 'package:murafik/feature/auth/domain/usecases/login_usecase.dart';
import 'package:murafik/feature/auth/domain/usecases/register_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final TokenStore tokenStore;

  AuthCubit({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.tokenStore,
  }) : super(const AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading());

    final result = await loginUsecase(email: email, password: password);

    result.fold((failure) => emit(AuthFailure(failure.message)), (
      authResponse,
    ) {
      final token = authResponse.accessToken;
      tokenStore.setToken(token);

      emit(AuthSuccess(authResponse));
    });
  }

  Future<void> register({
    required String username,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    emit(const AuthLoading());

    final result = await registerUsecase(
      username: username,
      email: email,
      phone: phone,
      password: password,
      role: role,
    );

    result.fold((failure) => emit(AuthFailure(failure.message)), (
      authResponse,
    ) {
      final token = authResponse.accessToken;
      tokenStore.setToken(token);

      emit(AuthSuccess(authResponse));
    });
  }
}
