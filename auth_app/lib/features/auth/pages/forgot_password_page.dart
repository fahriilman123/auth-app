import 'package:flutter/material.dart';
import '../../../shared/widget/custom_button.dart';
import '../../../shared/utils/validators.dart';
import '../controllers/auth_controller.dart';
import 'login_page.dart';
import 'reset_password_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  final AuthController _authController = AuthController();

  void _submitEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final token = await _authController.forgotPassword(
      email: _emailController.text,
    );

    if (!mounted) return;

    setState(() => _isLoading = false);

    if(token != null){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ResetPasswordPage(token: token)),
      );
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_authController.errorMessage ?? 'Gagal mendapatkan token')),
      );
    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lupa Password? 🔒',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Masukkan email Anda untuk mereset password',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 24),

                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: Validators.email,
                    ),
                    const SizedBox(height: 24),

                    CustomButton(
                      text: 'Reset Password',
                      isLoading: _isLoading,
                      onPressed: _submitEmail,
                    ),
                    const SizedBox(height: 16),

                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginPage()),
                          );
                        },
                        child: const Text(
                          'Kembali ke Login',
                          style: TextStyle(color: Colors.purple),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
