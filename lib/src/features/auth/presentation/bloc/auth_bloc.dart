import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_dashboard/src/features/auth/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  void _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (event.email == 'test@test.com' && event.password == 'password') {
        await _authRepository.login(); // Save login state
        emit(AuthSuccess(message: 'Login successful!'));
      } else {
        emit(AuthFailure(error: 'Invalid email or password.'));
      }
    } catch (e) {
      emit(AuthFailure(error: 'An unknown error occurred.'));
    }
  }

  void _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.logout();
    emit(AuthInitial()); // Go back to initial state
  }
}
