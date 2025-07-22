import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_dashboard/src/features/dashboard/data/models/shipment_model.dart';
import 'package:patient_dashboard/src/features/dashboard/presentation/bloc/patient_event.dart';
import 'package:patient_dashboard/src/features/dashboard/presentation/bloc/patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final MockApiService _apiService;

  PatientBloc(this._apiService) : super(PatientInitial()) {
    on<FetchPatientData>(_onFetchPatientData);
  }

  void _onFetchPatientData(
    FetchPatientData event,
    Emitter<PatientState> emit,
  ) async {
    emit(PatientLoading());
    try {
      // Fetch both patient data and shipment history
      final patient = await _apiService.getPatientData();
      final shipments = await _apiService.getShipmentHistory();
      emit(PatientLoaded(patient: patient, shipments: shipments));
    } catch (e) {
      emit(PatientError(message: 'Failed to fetch patient data.'));
    }
  }
}
