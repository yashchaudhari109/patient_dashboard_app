part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

final class LogoutRequested extends AuthEvent {} // Add this event
