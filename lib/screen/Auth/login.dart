import 'package:flutter/material.dart';
import 'Otp.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isPressed = false;
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.network(
                  'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=1400&q=80',
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
               SizedBox(height: 14),
               Text(
                'Welcome Back',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                  fontFamily: 'Nunito',
                ),
              ),
               SizedBox(height: 4),
               Text(
                'Enter your email to receive a login code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF6B7280),
                  fontFamily: 'DM Sans',
                ),
              ),
               SizedBox(height: 16),
               Text(
                'Email Address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                  fontFamily: 'Nunito',
                ),
              ),
               SizedBox(height: 8),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'enter your email',
                  hintStyle:  TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 13,
                    fontFamily: 'DM Sans',
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:  EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide:  BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide:  BorderSide(color: Color(0xFF14B8A6), width: 1.2),
                  ),
                ),
              ),
               SizedBox(height: 12),
              SizedBox(
                height: 56,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient:  LinearGradient(
                      colors: [Color(0xFF2DD4BF), Color(0xFF0EA5A8)],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyOtpScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child:  Text(
                      'Send Code',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Nunito',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
               SizedBox(height: 14),
              Row(
                children:  [
                  Expanded(child: Divider(color: Color(0xFF9CA3AF), thickness: 1.2)),
                  SizedBox(width: 14),
                  Text(
                    'Or continue with',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 12,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(child: Divider(color: Color(0xFF9CA3AF), thickness: 1.2)),
                ],
              ),
               SizedBox(height: 22),
              GestureDetector(
                onTapDown: (_) => setState(() => _isPressed = true),
                onTapUp: (_) => setState(() => _isPressed = false),
                onTapCancel: () => setState(() => _isPressed = false),
                onTap: () {
                  // 👉 Handle Google Login
                },
                child: AnimatedContainer(
                  duration:  Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    gradient: _isPressed
                        ?  LinearGradient(
                      colors: [Color(0xFF2DD4BF), Color(0xFF0EA5A8)],
                    )
                        : null,
                    color: _isPressed ? null : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color:  Color(0xFFE5E7EB)),
                  ),
                  padding:  EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// ✅ Image Icon
                      Image.asset(
                        "assets/icon/google.png",
                        height: 20,
                        width: 20,
                      ),
                       SizedBox(width: 10),
                      /// ✅ Text
                      Text(
                        'Continue with Google',
                        style: TextStyle(
                          color: _isPressed ? Colors.white :  Color(0xFF111827),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'DM Sans',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
               SizedBox(height: 14),
              RichText(
                textAlign: TextAlign.center,
                text:  TextSpan(
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 14,
                    fontFamily: 'DM Sans',
                  ),
                  children: [
                    TextSpan(text: 'By signing in, you agree to our '),
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(
                        color: Color(0xFF0F4C81),
                        fontWeight: FontWeight.w700,
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
}