import 'package:burgeon/services/api_services.dart';
import 'package:stacked/stacked.dart';
import 'package:burgeon/services/storage_service.dart'; // Assuming you have this service

class LoginViewModel extends BaseViewModel {
  final ApiService _apiService = ApiService();
  final StorageService storageService;
  final Function(String title, String message) showDialogCallback;

  String email = '';
  String password = '';
  bool rememberMe = false;
  bool isPasswordObscured = true;

  onEmailChanged(String value) {
    email = value;
    notifyListeners();
  }

  LoginViewModel({
    required this.showDialogCallback,
    required this.storageService,
  });

  // Login logic
  Future<void> login() async {
    setBusy(true);
    try {
      final response = await _apiService.login(email, password);

      if (response['success'] == true) {
        showDialogCallback('Success', 'Login successful!');
        print('Login successful: ${response['data']}');

        // Save credentials if "remember me" is checked
        if (rememberMe) {
          await storageService.saveCredentials(email, password);
          await checkRememberedCredentials(); // Reload the credentials
        }
      }
    } catch (e) {
      print('Error: $e');
      showDialogCallback('Error', '$e');
    } finally {
      setBusy(false);
    }
  }

  // Load saved credentials
  Future<void> checkRememberedCredentials() async {
    email = await storageService.getEmail() ?? '';
    password = await storageService.getPassword() ?? '';
    notifyListeners();
  }

  // Validate form inputs
  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    notifyListeners();
  }
}
