import 'package:burgeon/services/api_services.dart';
import 'package:burgeon/services/get_model.dart';
import 'package:stacked/stacked.dart';

class ExampleViewModel extends BaseViewModel {
  final ApiService _apiService = ApiService();

  GetModel? _data;
  GetModel? get data => _data;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  Future<void> loadData() async {
    setBusy(true); // Sets the view to busy state for UI feedback
    try {
      final fetchedData = await _apiService.fetchData();
      _data = fetchedData; // Store the fetched data in the ViewModel
      _errorMessage = ""; // Clear any previous error message
    } catch (e) {
      _errorMessage = e.toString(); // Store any error message
    } finally {
      setBusy(false); // Set the view to idle once the operation is complete
    }
  }
}
