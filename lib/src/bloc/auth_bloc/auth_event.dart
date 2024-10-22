part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  
  @override
  List<Object> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
  
  @override
  List<Object> get props => [email, password];
}


class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  SignUpRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class ResetPasswordRequest extends AuthEvent {
    final String email;

    ResetPasswordRequest(this.email);

    @override
    List<Object> get props => [email];
}


class SignOutRequested extends AuthEvent {}