import 'package:flutter/material.dart';
import '../../../core/storage/token_storage.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final userName = await TokenStorage.getName();
    setState(() {
      name = userName;
    });
  }

  Future<void> _logout() async {
      await TokenStorage.clear();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false
      );
  }

  Future<void> _confirmLogout() async {
    final result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah anda yakin ingin logout?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Batal')),
            ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Logout'))
          ],
        )
    );
    if(result == true){
      _logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Home Page',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
        ),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _confirmLogout, // panggil konfirmasi logout
          ),
        ],
      ),
      body: Center(
        child: Text(
          name == null ? 'Loading...' : 'Hallo, $name 👋',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
