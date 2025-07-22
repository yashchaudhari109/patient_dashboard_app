import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:patient_dashboard/src/features/dashboard/presentation/bloc/patient_bloc.dart';
import 'package:patient_dashboard/src/features/dashboard/presentation/bloc/patient_state.dart';

// Helper: capitalize first char
extension StringCasing on String {
  String capitalize() =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : this;
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: BlocBuilder<PatientBloc, PatientState>(
        builder: (context, state) {
          if (state is PatientLoading || state is PatientInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PatientError) {
            return Center(child: Text(state.message));
          }
          if (state is PatientLoaded) {
            final patient = state.patient;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Creative profile header (with default avatar)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.deepPurple, Colors.deepPurple.shade200],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(blurRadius: 8, color: Colors.black12)
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person,
                              size: 40, color: Colors.deepPurple),
                        ),
                        const SizedBox(width: 18),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              patient.fullName,
                              style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Patient ID: ${patient.patientId}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Next delivery, plan, medication info
                  Material(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(16),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.local_shipping,
                                color: Colors.orange, size: 36),
                            title: const Text('Next Delivery',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(
                              DateFormat.yMMMMd()
                                  .format(patient.nextDeliveryDate),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            trailing: ElevatedButton.icon(
                              onPressed: () => context.push('/history'),
                              icon: const Icon(Icons.history),
                              label: const Text('History'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.deepPurple,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.description,
                                  color: Colors.deepPurple),
                              const SizedBox(width: 6),
                              const Text("Current Plan: ",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500)),
                              Text(patient.currentPlan,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.medication, color: Colors.teal),
                              const SizedBox(width: 6),
                              const Text("Remaining Medication: ",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500)),
                              Text("${patient.remainingMedication} days",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  const Text('Status Summary',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _StatusChip(
                        icon: patient.status.toLowerCase() == 'active'
                            ? Icons.check_circle
                            : Icons.error,
                        label: patient.status.capitalize(),
                        color: patient.status.toLowerCase() == 'active'
                            ? Colors.green
                            : Colors.red,
                      ),
                      const SizedBox(width: 12),
                      _StatusChip(
                        icon: patient.billingStatus.toLowerCase() == 'ok'
                            ? Icons.payments
                            : Icons.warning,
                        label: 'Billing: ${patient.billingStatus}',
                        color: patient.billingStatus.toLowerCase() == 'ok'
                            ? Colors.blue
                            : Colors.orange,
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Quick actions
                  const Text('Quick Actions',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _DashboardActionTile(
                          icon: Icons.local_pharmacy,
                          label: 'Request Refill',
                          color: Colors.teal,
                          onTap: () {
                            // Implement action
                          },
                        ),
                        _DashboardActionTile(
                          icon: Icons.chat,
                          label: 'Contact Support',
                          color: Colors.deepPurple,
                          onTap: () {
                            // Implement action
                          },
                        ),
                        _DashboardActionTile(
                          icon: Icons.settings,
                          label: 'Settings',
                          color: Colors.amber.shade800,
                          onTap: () {
                            context.push('/settings');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Something went wrong.'));
        },
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatusChip({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, color: color, size: 20),
      label: Text(label,
          style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      backgroundColor: color.withOpacity(0.12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}

// Reusable dashboard action card
class _DashboardActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _DashboardActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          width: 120,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 10),
              Text(label,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600, color: color)),
            ],
          ),
        ),
      ),
    );
  }
}
