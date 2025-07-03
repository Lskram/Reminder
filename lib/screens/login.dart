import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../db/database_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'เข้าสู่ระบบ',
          style: GoogleFonts.kanit(
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.green.shade400,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.lock_outline, size: 64, color: Colors.green.shade400),
                  const SizedBox(height: 24),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: GoogleFonts.kanit(),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.green.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.green.shade400, width: 2),
                      ),
                    ),
                    style: GoogleFonts.kanit(),
                    onChanged: (val) => username = val,
                    validator: (val) => val!.isEmpty ? 'กรุณากรอก username' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: GoogleFonts.kanit(),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.green.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.green.shade400, width: 2),
                      ),
                    ),
                    style: GoogleFonts.kanit(),
                    obscureText: true,
                    onChanged: (val) => password = val,
                    validator: (val) => val!.isEmpty ? 'กรุณากรอก password' : null,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade400,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        textStyle: GoogleFonts.kanit(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      child: Text('เข้าสู่ระบบ', style: GoogleFonts.kanit(fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final user = await DatabaseHelper().getUser(
                            username,
                            password,
                          );
                          if (user != null) {
                            Navigator.pushReplacementNamed(context, '/questionnaire');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Username หรือ Password ไม่ถูกต้อง', style: GoogleFonts.kanit()),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    child: Text('สมัครสมาชิก', style: GoogleFonts.kanit(fontWeight: FontWeight.w500, color: Colors.green.shade400)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
