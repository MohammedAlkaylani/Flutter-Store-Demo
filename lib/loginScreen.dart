import 'package:flutter/material.dart';
import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback toggleTheme;

  const LoginScreen({
    super.key,
    required this.isDark,
    required this.toggleTheme,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 400;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.1),
              Center(
                child: Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 24 : 28,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Center(
                child: Text(
                  'Login to your account',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    color: theme.colorScheme.onBackground.withOpacity(0.7),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),

              // Email Label
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onBackground,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              // Email TextField
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: isSmallScreen ? 14 : 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.colorScheme.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.colorScheme.primary),
                  ),
                  hintText: 'mohammedAlkaylani@mail.com',
                  hintStyle: TextStyle(color: theme.hintColor),
                  prefixIcon: Icon(Icons.mail_outline, color: theme.iconTheme.color),
                  filled: true,
                  fillColor: theme.cardColor,
                ),
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onBackground,
                ),
              ),
              SizedBox(height: size.height * 0.025),

              // Password Label
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onBackground,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              // Password TextField
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: isSmallScreen ? 14 : 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.colorScheme.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.colorScheme.primary),
                  ),
                  hintText: '**********',
                  hintStyle: TextStyle(color: theme.hintColor),
                  prefixIcon: Icon(Icons.lock_outlined, color: theme.iconTheme.color),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: theme.iconTheme.color,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: theme.cardColor,
                ),
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onBackground,
                ),
              ),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot your password?',
                    style: TextStyle(
                      fontSize: 16,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.03),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: isSmallScreen ? 50 : 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppScreen(
                          isDark: widget.isDark,
                          toggleTheme: widget.toggleTheme,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.05),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: theme.dividerColor,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Or Login with',
                      style: TextStyle(
                        color: theme.colorScheme.onBackground.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: theme.dividerColor,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(
                    context,
                    iconPath: 'assets/facebook.png',
                    onPressed: () {},
                  ),
                  SizedBox(width: size.width * 0.04),
                  _buildSocialButton(
                    context,
                    iconPath: 'assets/google.png',
                    onPressed: () {},
                  ),
                  SizedBox(width: size.width * 0.04),
                  _buildSocialButton(
                    context,
                    iconPath: 'assets/apple.png',
                    onPressed: () {},
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.05),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(BuildContext context,
      {required String iconPath, required VoidCallback onPressed}) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return SizedBox(
      width: size.width * 0.18,
      height: size.width * 0.18,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: theme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: theme.dividerColor,
              width: 1,
            ),
          ),
          elevation: 0,
        ),
        child: Image.asset(
          iconPath,
          width: size.width * 0.08,
          height: size.width * 0.08,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}