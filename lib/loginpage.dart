import 'package:flutter/material.dart';
import 'createacctpage.dart';
import 'forgotpasspage.dart'; // Import the Forgot Password page

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();

  // Define your colors here
  final Color primaryColor = Color(0xFF2196F3);
  final Color secondaryColor = Color(0xFF64B5F6);
  final Color tertiaryColor = Color(0xFFBBDEFB);
  final Color altColor = Color(0xFFE3F2FD);
  final Color primaryTextColor = Color(0xFF212121);
  final Color secondaryTextColor = Color(0xFF757575);
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logging in...')),
      );
      // Perform login logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE3F2FD),
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color(0xFFE3F2FD),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 300.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [widget.secondaryColor, widget.primaryColor, widget.primaryTextColor],
                tileMode: TileMode.mirror,
              ).createShader(bounds),
              child: Text(
                'Login to my account',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Enter your credentials to access your account',
              style: TextStyle(
                fontSize: 16,
                color: widget.secondaryTextColor,
              ),
            ),
            SizedBox(height: 24),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_passwordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 16),
            // Forgot Password Button
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPassPage()),
                );
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: widget.primaryColor,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 24),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
