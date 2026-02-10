import 'package:flutter/material.dart';
import '../../../shared/utils/validators.dart';
import '../../../shared/widget/custom_button.dart';
import '../controllers/auth_controller.dart';
import 'login_page.dart';


class ResetPasswordPage extends StatefulWidget {
  final String token; // token dari ForgotPasswordPage

  const ResetPasswordPage({super.key, required this.token});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final AuthController _authController = AuthController();

  String? _errorMessage; // untuk menyimpan pesan error token kadaluarsa

  void _submitNewPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final success = await _authController.resetPassword(
      token: widget.token,
      password: _passwordController.text,
    );

    if (!mounted) return;

    setState(() => _isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password berhasil diubah!')),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false,
      );
    } else {
      // tampilkan error token kadaluarsa
      setState(() {
        _errorMessage = _authController.errorMessage ?? 'Gagal ganti password';
      });
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reset Password 🔒',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Masukkan password baru Anda jangan lebih dari 5 menit!',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),

                    // Jika ada error, tampilkan pesan merah dan tombol kembali
                    if (_errorMessage != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _errorMessage!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              // kembali ke halaman ForgotPasswordPage
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Masukkan email lagi',
                              style: TextStyle(color: Colors.purple),
                            ),
                          ),
                        ],
                      ),

                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password Baru',
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: Validators.password,
                    ),
                    const SizedBox(height: 24),

                    CustomButton(
                      text: 'Ubah Password',
                      isLoading: _isLoading,
                      onPressed: _submitNewPassword,
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
