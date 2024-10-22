import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/auth_repositories/auth_repositories.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<ResetPasswordRequest>(_onResetPasswordRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.signIn(event.email, event.password);
      emit(AuthSuccess("Signed In Successfully"));
    } catch (e) {
      emit(AuthFailure("Sign In Failed: $e"));
    }
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.signUp(event.email, event.password);
      emit(AuthSuccess("Signed Up Successfully"));
    } catch (e) {
      emit(AuthFailure("Sign Up Failed: $e"));
    }
  }

  Future<void> _onResetPasswordRequested(
      ResetPasswordRequest event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.resetPassword(event.email);
      emit(AuthSuccess("Password Reset Email Sent"));
    } catch (e) {
      emit(AuthFailure("Password Reset Failed: $e"));
    }
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.signOut();
      emit(AuthSuccess("Signed Out Successfully"));
    } catch (e) {
      emit(AuthFailure("Sign Out Failed: $e"));
    }
  }
}