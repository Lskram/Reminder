import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../db/database_helper.dart';
import '../models/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'สมัครสมาชิก',
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
                  Icon(Icons.person_add_alt_1, size: 64, color: Colors.green.shade400),
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
                      child: Text('สมัครสมาชิก', style: GoogleFonts.kanit(fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseHelper().insertUser(
                            User(username: username, password: password),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('สมัครสมาชิกสำเร็จ!', style: GoogleFonts.kanit())),
                          );
                          Navigator.pop(context);
                        }
                      },
                    ),
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
