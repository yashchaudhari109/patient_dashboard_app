import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:patient_dashboard/src/features/auth/presentation/bloc/auth_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Add logout event and navigate to login screen
            context.read<AuthBloc>().add(LogoutRequested());
            context.go('/');
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
