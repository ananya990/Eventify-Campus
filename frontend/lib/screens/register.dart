import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isPasswordVisible = false;

  Future<void> signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Google Sign-In canceled")));
        setState(() => _isLoading = false);
        return;
      }

      Navigator.pushNamed(context, 'home');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signed in as ${googleUser.displayName}")),
      );
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Google Sign-In failed: $error")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/register'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 201) {
        Navigator.pushNamed(context, 'home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration failed: ${response.body}")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $error")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/register.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
          body: Stack(
            children: [
              if (_isLoading) Center(child: CircularProgressIndicator()),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 35),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                style: TextStyle(color: Colors.purple),
                                decoration: _inputDecoration("Name"),
                                validator:
                                    (value) =>
                                        value!.isEmpty ? "Enter name" : null,
                              ),
                              SizedBox(height: 30),
                              TextFormField(
                                controller: _emailController,
                                style: TextStyle(color: Colors.purple),
                                decoration: _inputDecoration("Email"),
                                keyboardType: TextInputType.emailAddress,
                                validator:
                                    (value) =>
                                        value!.isEmpty || !value.contains('@')
                                            ? "Enter valid email"
                                            : null,
                              ),
                              SizedBox(height: 30),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: !_isPasswordVisible,
                                style: TextStyle(color: Colors.purple),
                                decoration: _inputDecoration(
                                  "Password",
                                ).copyWith(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.purple,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                                validator:
                                    (value) =>
                                        value!.length < 6
                                            ? "Password too short"
                                            : null,
                              ),
                              SizedBox(height: 40),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 76, 80, 91),
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color.fromARGB(
                                      255,
                                      76,
                                      80,
                                      91,
                                    ),
                                    child: IconButton(
                                      color: Colors.white,
                                      onPressed: _registerUser,
                                      icon: Icon(Icons.arrow_forward),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: signInWithGoogle,
                                icon: Image.asset(
                                  'assets/googlelogo.jpg',
                                  height: 24,
                                ),
                                label: Text(
                                  "Sign in with Google",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center, // Center the text
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, 'login');
                                    },
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color.fromARGB(255, 76, 80, 91),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.purple),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purple),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
