import 'package:flutter/material.dart';

class CreateAcctPage extends StatelessWidget {
  // Define your colors here
  final Color primaryColor = Color(0xFF2196F3);
  final Color secondaryColor = Color(0xFF64B5F6);
  final Color tertiaryColor = Color(0xFFBBDEFB);
  final Color altColor = Color(0xFFE3F2FD);
  final Color primaryTextColor = Color(0xFF212121);
  final Color secondaryTextColor = Color(0xFF757575);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: altColor,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: altColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 300.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40), // Space from the top
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [primaryColor, secondaryColor],
                tileMode: TileMode.mirror,
              ).createShader(bounds),
              child: Text(
                'Create Your Account',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Fill in the details to create a new account.',
              style: TextStyle(
                fontSize: 16,
                color: secondaryTextColor,
              ),
            ),
            SizedBox(height: 24),

            // Personal Details Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Personal Details:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Display Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
            SizedBox(height: 24),

            // Account Details Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Account Details:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility_off),
                    onPressed: () {
                      // Add functionality to toggle password visibility
                    },
                  ),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility_off),
                    onPressed: () {
                      // Add functionality to toggle password visibility
                    },
                  ),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 24),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                onPressed: () {
                  // Add your account creation logic here
                },
                child: Text('Create Account'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
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
