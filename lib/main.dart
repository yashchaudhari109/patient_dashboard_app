import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:patient_dashboard/src/features/auth/data/repositories/auth_repository.dart';
import 'package:patient_dashboard/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:patient_dashboard/src/features/auth/presentation/screens/login_screen.dart';
import 'package:patient_dashboard/src/features/dashboard/data/models/shipment_model.dart';
import 'package:patient_dashboard/src/features/dashboard/presentation/bloc/patient_bloc.dart';
import 'package:patient_dashboard/src/features/dashboard/presentation/bloc/patient_event.dart';
import 'package:patient_dashboard/src/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:patient_dashboard/src/features/dashboard/presentation/screens/settings_screen.dart';
import 'package:patient_dashboard/src/features/dashboard/presentation/screens/shipment_history_screen.dart';
import 'package:patient_dashboard/src/features/dashboard/presentation/widgets/bottom_nav_bar.dart';

Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Check if the user is logged in
  final authRepository = AuthRepository();
  final bool isLoggedIn = await authRepository.isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn, authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final AuthRepository authRepository;

  const MyApp({
    super.key,
    required this.isLoggedIn,
    required this.authRepository,
  });

  @override
  Widget build(BuildContext context) {
    // Provide the AuthRepository to the app
    return RepositoryProvider.value(
      value: authRepository,
      child: BlocProvider(
        create: (context) => AuthBloc(context.read<AuthRepository>()),
        child: Builder(
          builder: (context) {
            final router = _buildRouter(context);
            return MaterialApp.router(
              routerConfig: router,
              title: 'Patient Dashboard',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
            );
          },
        ),
      ),
    );
  }

  GoRouter _buildRouter(BuildContext context) {
    return GoRouter(
      initialLocation: isLoggedIn ? '/dashboard' : '/',
      // Add a redirect to handle logout
      redirect: (context, state) {
        final authState = context.read<AuthBloc>().state;
        final loggingOut = state.matchedLocation == '/';

        // If the user is logging out, redirect to the login screen
        if (authState is AuthInitial && !loggingOut) {
          return '/';
        }
        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const LoginScreen(),
        ),
        ShellRoute(
          builder: (context, state, child) {
            return BlocProvider(
              create: (context) =>
                  PatientBloc(MockApiService())..add(FetchPatientData()),
              child: ScaffoldWithNavBar(child: child),
            );
          },
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardScreen(),
            ),
            GoRoute(
              path: '/history',
              builder: (context, state) => const ShipmentHistoryScreen(),
            ),
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    );
  }
}
