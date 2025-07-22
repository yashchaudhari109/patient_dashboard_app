import 'package:patient_dashboard/src/features/dashboard/data/models/patient_model.dart';

class Shipment {
  final DateTime date;
  final String status;
  final int quantity;

  Shipment({
    required this.date,
    required this.status,
    required this.quantity,
  });
}

class MockApiService {
  Future<Patient> getPatientData() async {
    await Future.delayed(const Duration(seconds: 1));
    return Patient(
      fullName: 'Yash',
      patientId: 'P12345678',
      currentPlan: 'Standard Plan',
      nextDeliveryDate: DateTime.now().add(const Duration(days: 15)),
      remainingMedication: 30,
      status: 'Active',
      billingStatus: 'OK',
    );
  }

  Future<List<Shipment>> getShipmentHistory() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Shipment(date: DateTime(2024, 7, 1), status: 'Pending', quantity: 30),
      Shipment(date: DateTime(2024, 6, 15), status: 'In Transit', quantity: 60),
      Shipment(date: DateTime(2024, 5, 28), status: 'Delivered', quantity: 90),
      Shipment(date: DateTime(2024, 4, 10), status: 'Cancelled', quantity: 0),
      Shipment(date: DateTime(2024, 2, 24), status: 'Delivered', quantity: 90),
      Shipment(date: DateTime(2023, 12, 5), status: 'Delivered', quantity: 60),
      Shipment(date: DateTime(2023, 10, 25), status: 'Delivered', quantity: 90),
      Shipment(date: DateTime(2023, 7, 25), status: 'Delivered', quantity: 90),
      Shipment(date: DateTime(2023, 4, 25), status: 'Delivered', quantity: 90),
    ];
  }
}
