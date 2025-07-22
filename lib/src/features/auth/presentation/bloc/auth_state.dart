part of 'auth_bloc.dart';

// Use 'sealed' to ensure all possible states are handled in the UI
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final String message; // Optional: could hold a user object later
  AuthSuccess({required this.message});
}

final class AuthFailure extends AuthState {
  final String error;
  AuthFailure({required this.error});
}
