import 'package:flutter/material.dart';

import '../../widgets/bootomNavBar/navBar/bootomNavBar.dart';

class MyOtpScreen extends StatefulWidget {
   MyOtpScreen({super.key});

  @override
  State<MyOtpScreen> createState() => _MyOtpScreenState();
}

class _MyOtpScreenState extends State<MyOtpScreen> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(4, (_) => TextEditingController());
    _focusNodes = List.generate(4, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  /// ✅ Get OTP Value
  String getOtp() {
    return _controllers.map((e) => e.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF111827)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Verification',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Nunito',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// 🖼️ Banner Image
              ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.network(
                  'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1400&q=80',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),

               SizedBox(height: 20),

              /// 🔤 Title
               Text(
                'Enter Code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                  fontFamily: 'Nunito',
                ),
              ),
               SizedBox(height: 5),
              /// 📩 Subtitle
               Text(
                "We've sent a 4-digit code to your email",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                  fontFamily: 'DM Sans',
                ),
              ),

               SizedBox(height: 2),

               Text(
                'name@example.com',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF6B7280),
                  fontFamily: 'DM Sans',
                ),
              ),
               SizedBox(height: 8),
              /// 🔢 OTP Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) => _otpBox(index)),
              ),

               SizedBox(height: 18),

              /// 🔘 Verify Button
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
                      String otp = getOtp();

                      if (otp.length == 4) {
                        print("Entered OTP: $otp");

                        /// ✅ Navigate to Home Screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomeScreen(
                              onToggleTheme: () {}, // pass your function
                            ),
                          ),
                        );
                      } else {
                        /// ❌ Show error if OTP incomplete
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter complete OTP"),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child:  Text(
                      'Verify & Proceed',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Nunito',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

               SizedBox(height: 16),

              /// 🔁 Resend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    "Didn't receive the code? ",
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  Text(
                    'Resend',
                    style: TextStyle(
                      color: Color(0xFF0EA5A8),
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔢 OTP Box Widget
  Widget _otpBox(int index) {
    return SizedBox(
      width: 70,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style:  TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontFamily: 'Nunito',
          color: Color(0xFF111827),
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          contentPadding:  EdgeInsets.symmetric(vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide:  BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide:
             BorderSide(color: Color(0xFF14B8A6), width: 1.5),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < _focusNodes.length - 1) {
            _focusNodes[index + 1].requestFocus();
          }
          if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}