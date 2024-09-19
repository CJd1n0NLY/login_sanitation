import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import SVG package
import 'package:test_drive/forgotpasspage.dart';
import 'welcomepage.dart'; // Import the welcome page
import 'loginpage.dart'; // Import your login page
import 'createacctpage.dart'; // Import your create account page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color primaryColor = Color(0xFF2196F3);
  final Color secondaryColor = Color(0xFF64B5F6);
  final Color tertiaryColor = Color(0xFFBBDEFB);
  final Color altColor = Color(0xFFE3F2FD);
  final Color primaryTextColor = Color(0xFF212121);
  final Color secondaryTextColor = Color(0xFF757575);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ec-Clean water Sanitation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/create': (context) => CreateAcctPage(),
        '/welcome': (context) => WelcomePage(),
        '/forgotpass': (context) => ForgotPassPage(),
      },
    );
  }
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  double _logoOpacity = 0.0;
  double _welcomeTextOpacity = 0.0;
  double _startTextOpacity = 0.0;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // Set up animation controllers for pulsing text
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 6.28).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    // Start the fade-in animations after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _logoOpacity = 1.0;
      });
    });
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _welcomeTextOpacity = 1.0;
      });
    });
    Future.delayed(Duration(milliseconds: 1500), () {
      setState(() {
        _startTextOpacity = 1.0;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleLogoTap() async {
    // Start spinning animation for 3 seconds
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SpinScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE3F2FD),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with fade-in animation and gesture detection
            GestureDetector(
              onTap: () {
                // Navigate to SpinScreen to show the spinning logo
                _handleLogoTap();
              },
              child: AnimatedOpacity(
                opacity: _logoOpacity,
                duration: Duration(seconds: 2),
                child: SvgPicture.asset(
                  'assets/logo.svg', // Make sure the logo is in the assets folder
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Welcome Text with gradient and fade-in animation
            AnimatedOpacity(
              opacity: _welcomeTextOpacity,
              duration: Duration(seconds: 2),
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    Color(0xFF64B5F6), // First color
                    Color(0xFF2196F3), // Second color
                    Color(0xFF212121), // Third color
                  ],
                  tileMode: TileMode.mirror,
                ).createShader(bounds),
                child: Text(
                  'Welcome to Our App!',
                  style: TextStyle(
                    fontFamily: 'Inter Tight',
                    fontSize: 32,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Gradient requires a color to render
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Pulsing Text with animation
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: AnimatedOpacity(
                    opacity: _startTextOpacity,
                    duration: Duration(seconds: 2),
                    child: Text(
                      'Press the logo to start',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SpinScreen extends StatefulWidget {
  @override
  _SpinScreenState createState() => _SpinScreenState();
}

class _SpinScreenState extends State<SpinScreen> with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE3F2FD),
      body: Center(
        child: AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationController.value * 6.28, // Rotate 360 degrees
              child: SvgPicture.asset(
                'assets/logo.svg', // Make sure the logo is in the assets folder
                width: 200,
                height: 200,
              ),
            );
          },
        ),
      ),
    );
  }
}
