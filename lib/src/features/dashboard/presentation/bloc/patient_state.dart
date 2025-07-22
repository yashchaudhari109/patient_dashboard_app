import 'package:patient_dashboard/src/features/dashboard/data/models/patient_model.dart';
import 'package:patient_dashboard/src/features/dashboard/data/models/shipment_model.dart';

sealed class PatientState {}

final class PatientInitial extends PatientState {}

final class PatientLoading extends PatientState {}

final class PatientLoaded extends PatientState {
  final Patient patient;
  final List<Shipment> shipments;

  PatientLoaded({required this.patient, required this.shipments});
}

final class PatientError extends PatientState {
  final String message;

  PatientError({required this.message});
}
