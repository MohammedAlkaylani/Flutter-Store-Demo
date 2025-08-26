import 'package:flutter/material.dart';
import 'dart:async';
import 'loginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primaryColor: const Color(0xff156651),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff156651),
          brightness: isDark ? Brightness.dark : Brightness.light,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: isDark ? Colors.grey[900] : Colors.white,
          foregroundColor: isDark ? Colors.white : Colors.black,
          elevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: isDark ? Colors.grey[900] : Colors.white,
          selectedItemColor: const Color(0xff156651),
          unselectedItemColor: isDark ? Colors.grey[400] : Colors.grey[600],
        ),
      ),
      home: WelcomeScreen(
        isDark: isDark,
        toggleTheme: toggleTheme,
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback toggleTheme;

  const WelcomeScreen({
    Key? key,
    required this.isDark,
    required this.toggleTheme,
  }) : super(key: key);

  @override
  _WelcomeScreen createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to home after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            isDark: widget.isDark,
            toggleTheme: widget.toggleTheme,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1A7F65), // Top color
              Color(0xFF115543) // Bottom color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/logo.png',
            width: size.width * 1,
            height: size.height * 0.5,
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback toggleTheme;

  const HomeScreen({
    Key? key,
    required this.isDark,
    required this.toggleTheme,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      "image": "assets/firstone.png",
      "title": "Your Library in Your Pocket",
      "subtitle":
      "Discover thousands of Arabic books and novels with various categories and prices for every reader."
    },
    {
      "image": "assets/secondone.png",
      "title": "Fast Delivery to Your Door",
      "subtitle":
      "Enjoy reliable and quick delivery of your favorite books right to your home."
    },
    {
      "image": "assets/thirdone.png",
      "title": "Easy & Secure Payments",
      "subtitle":
      "Choose your preferred payment method with full security and convenience for every purchase."
    },
  ];


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: PageView.builder(
        controller: _controller,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              // Image with circular bottom cut
              ClipPath(
                clipper: CircleClipper(),
                child: Image.asset(
                  pages[index]["image"]!,
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 24),

              // Title
              Text(
                pages[index]["title"]!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onBackground,
                ),
              ),

              const SizedBox(height: 12),

              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  pages[index]["subtitle"]!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: theme.colorScheme.onBackground.withOpacity(0.7),
                  ),
                ),
              ),
              const SizedBox(height: 100),

              // Page indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                      (dotIndex) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == dotIndex
                          ? theme.colorScheme.primary
                          : Colors.grey.shade400,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 150),

              Row(
                children: [
                  if (_currentPage > 0)
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(120, 50),
                          side: BorderSide(color: theme.colorScheme.primary),
                        ),
                        onPressed: () {
                          _controller.previousPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: theme.colorScheme.primary),
                        ),
                      ),
                    ),

                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        minimumSize: Size(120, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: theme.colorScheme.primary),
                        ),
                      ),
                      onPressed: () {
                        if (_currentPage == pages.length - 1) {
                          // Last page → Go to main app screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(
                                isDark: widget.isDark,
                                toggleTheme: widget.toggleTheme,
                              ),
                            ),
                          );
                        } else {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Text(
                        _currentPage == pages.length - 1 ? "Finish" : "Next",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);

    // Large arc bottom
    path.quadraticBezierTo(
      size.width / 2, size.height + 80, // control point
      size.width, size.height - 80, // end point
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);

    // Add an arc at the bottom
    path.quadraticBezierTo(
      size.width / 2, size.height + 60,
      // control point (pushes down for circle look)
      size.width, size.height - 60, // end point
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}