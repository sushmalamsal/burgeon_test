import 'package:burgeon/services/storage_service.dart';
import 'package:burgeon/viewmodels/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(
        showDialogCallback: (title, message) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
        storageService: StorageService(),
      ),
      onModelReady: (model) => model.checkRememberedCredentials(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  onChanged: model.onEmailChanged,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Email'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  obscureText: model.isPasswordObscured,
                  onChanged: (value) {
                    model.password = value;
                    model.notifyListeners();
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        model.isPasswordObscured
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: model.togglePasswordVisibility,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: model.rememberMe,
                      onChanged: (value) {
                        model.rememberMe = value ?? false;
                        model.notifyListeners();
                      },
                    ),
                    const Text('Remember me'),
                  ],
                ),
                ElevatedButton(
                  onPressed:
                      model.isFormValid && !model.isBusy ? model.login : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.deepPurpleAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: model.isBusy
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Login'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
