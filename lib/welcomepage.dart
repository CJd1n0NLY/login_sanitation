import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'dart:async'; // Import for Timer
import 'loginpage.dart';
import 'createacctpage.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();

  // Define your colors here
  final Color primaryColor = Color(0xFF2196F3);
  final Color secondaryColor = Color(0xFF64B5F6);
  final Color tertiaryColor = Color(0xFFBBDEFB);
  final Color altColor = Color(0xFFE3F2FD);
  final Color primaryTextColor = Color(0xFF212121);
  final Color secondaryTextColor = Color(0xFF757575);
}

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _logoAnimationController;
  late ScrollController _scrollController;
  Timer? _scrollTimer;
  double _scrollOffset = 0;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _logoAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _scrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);

    _startAutoScroll(); // Start auto-scrolling
  }

  @override
  void dispose() {
    _pageController.dispose();
    _logoAnimationController.dispose();
    _scrollController.dispose();
    _tabController.dispose();
    _scrollTimer?.cancel(); // Cancel the timer
    super.dispose();
  }

  void _startAutoScroll() {
    const scrollInterval = Duration(seconds: 1); // Interval between scroll updates

    _scrollTimer = Timer.periodic(scrollInterval, (timer) {
      if (_scrollController.hasClients) {
        // Scroll vertically
        _scrollOffset += 300;
        _scrollController.animateTo(
          _scrollOffset,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        // Reset scroll offset if exceeded
        if (_scrollOffset > _scrollController.position.maxScrollExtent) {
          _scrollOffset = 0;
        }
      }
    });
  }

  void _handlePageViewChanged(int currentPageIndex) {
    if (_isOnDesktopAndWeb) {
      _tabController.index = currentPageIndex;
    }
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  bool get _isOnDesktopAndWeb {
    if (kIsWeb) {
      return true;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return true;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE3F2FD),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 600,
                  decoration: BoxDecoration(
                    color: Color(0xFFE3F2FD),
                  ),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: StaggeredGrid.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: List.generate(11, (index) {
                        final images = [
                          'assets/images/water-background.jpg',
                          'assets/images/water7.jpg',
                          'assets/images/water5.jpg',
                          'assets/images/water6.jpg',
                          'assets/images/water9.jpg',
                          'assets/images/water3.jpg',
                          'assets/images/water2.jpg',
                          'assets/images/water8.jpg',
                          'assets/images/water1.jpg',
                          'assets/images/water4.jpg',
                          'assets/images/water5.jpg',
                        ];
                        return StaggeredGridTile.count(
                          crossAxisCellCount: index % 2 == 0 ? 2 : 1,
                          mainAxisCellCount: index % 3 == 0 ? 2 : 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                    ),
                  ).animate().fadeIn(duration: 3000.ms),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 450,
                  constraints: BoxConstraints(maxWidth: 670),
                  decoration: BoxDecoration(
                    color: Color(0xFFE3F2FD),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 230,
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 48),
                              child: PageView(
                                controller: _pageController,
                                onPageChanged: _handlePageViewChanged,
                                children: [
                                  _buildPage('Water Quality Control', 'Implementing filtration, disinfection, and purification processes.'),
                                  _buildPage('Wastewater Treatment', 'Involvement in the treatment and recycling of wastewater to prevent pollution and promote reuse.'),
                                  _buildPage('Technology Use', 'See our services at ease'),
                                ],
                              ),
                            ),
                            if (_isOnDesktopAndWeb)
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: PageIndicator(
                                  tabController: _tabController,
                                  currentPageIndex: _currentPageIndex,
                                  onUpdateCurrentPageIndex: _updateCurrentPageIndex,
                                  isOnDesktopAndWeb: _isOnDesktopAndWeb,
                                  primaryColor: widget.primaryColor,
                                  secondaryColor: widget.secondaryColor,
                                  tertiaryColor: widget.tertiaryColor,
                                  altColor: widget.altColor,
                                  primaryTextColor: widget.primaryTextColor,
                                  secondaryTextColor: widget.secondaryTextColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: 300, // Set your desired width here
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login'); // Navigate to Login Page
                          },
                          child: Text('Login'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            minimumSize: Size(double.infinity, 60), // This keeps the height of the button
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: 300, // Set your desired width here
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/create'); // Navigate to Create Account Page
                          },
                          child: Text('Create an Account'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue,
                            side: BorderSide(color: Colors.blue, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            minimumSize: Size(double.infinity, 60), // This keeps the height of the button
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPage(String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GradientText(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter Tight',
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            colors: [Colors.blue.shade200, Colors.blue, Colors.black],
            gradientDirection: GradientDirection.ltr,
            gradientType: GradientType.linear,
          ),
          SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Inter', fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
    required this.isOnDesktopAndWeb,
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
    required this.altColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;
  final bool isOnDesktopAndWeb;
  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;
  final Color altColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;

  @override
  Widget build(BuildContext context) {
    if (!isOnDesktopAndWeb) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == 0) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex - 1);
            },
            icon: Icon(
              Icons.arrow_left_rounded,
              size: 32.0,
              color: secondaryColor,
            ),
          ),
          TabPageSelector(
            controller: tabController,
            color: tertiaryColor,
            selectedColor: primaryColor,
          ),
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == 2) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex + 1);
            },
            icon: Icon(
              Icons.arrow_right_rounded,
              size: 32.0,
              color: secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
