import 'package:auth_app/features/auth/pages/forgot_password_page.dart';
import 'package:auth_app/features/auth/pages/home_page.dart';
import 'package:flutter/material.dart';
import '../../../shared/widget/custom_button.dart';
import '../../../shared/utils/validators.dart';
import '../controllers/auth_controller.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthController _authController = AuthController();

  bool _isLoading = false;

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final success = await _authController.login(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login berhasil')),
      );

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _authController.errorMessage ?? 'Login gagal',
          ),
        ),
      );
    }

    setState(() => _isLoading = false);
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
                      'Welcome Back 👋',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Silakan login untuk melanjutkan',
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
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: Validators.password,
                    ),
                    const SizedBox(height: 24),

                    CustomButton(
                      text: 'Login',
                      isLoading: _isLoading,
                      onPressed: _login,
                    ),

                    const SizedBox(height: 16),

                    Center(
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              // pindah ke halaman Register
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const RegisterPage()),
                              );
                            },
                            child: const Text(
                              'Belum punya akun? Register',
                              style: TextStyle(
                                  color: Colors.purple
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
                              );
                            },
                            child: const Text(
                              'Lupa password?',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
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
