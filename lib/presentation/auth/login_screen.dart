import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';
import '../main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. HEADER AREA (COKLAT FULL, TUMPUL BAWAH)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.42,
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // BACKGROUND COKLAT/KREM
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 84,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      child: Container(
                        color: const Color(0xFFF3EFE9),
                        child: Stack(
                          children: [
                            _buildWatermarkText("SHOES", top: 20, left: 20),
                            _buildWatermarkText("SHOES", bottom: 20, right: 20),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // GAMBAR KAKI
                  Positioned(
                    right: 0,
                    bottom: 10,
                    height: MediaQuery.of(context).size.height * 0.43,
                    child: Image.asset(
                      'assets/images/kaki-1.png', // Ganti dengan asetmu
                      fit: BoxFit.contain,
                    ),
                  ),

                  // TOMBOL KEMBALI
                  Positioned(
                    top: 25,
                    left: 20,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. FORM SECTION (TRANSPARAN)
            Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                color: Colors.transparent, // Background transparan
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Sign In To Your Account",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Welcome Back You've Been Missed!",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 30),

                    // INPUT EMAIL
                    _buildInputField(
                      icon: Icons.email_outlined,
                      label: "Email Address",
                      hint: "example@gmail.com",
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 20),

                    // INPUT PASSWORD
                    _buildInputField(
                      icon: Icons.lock_outline,
                      label: "Password",
                      hint: "Password",
                      isPassword: true,
                      backgroundColor: Colors.white,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // BUTTON SIGN IN
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                    _buildSocialSection(),
                    const SizedBox(height: 30),

                    // CREATE ACCOUNT
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Not a member? ",
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Create an account",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPERS (SUPAYA TIDAK ERROR) ---

  Widget _buildWatermarkText(
    String text, {
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Transform.rotate(
        angle: -0.15,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 100,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w900,
            color: const Color(0xFFDFD7CA).withOpacity(0.4),
            letterSpacing: -5,
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String label,
    required String hint,
    bool isPassword = false,
    required Color backgroundColor, // Sekarang parameter ini WAJIB ada
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(icon, color: Colors.black),
          ),
          Container(width: 1, height: 40, color: Colors.grey.shade300),
          Expanded(
            child: TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                border: InputBorder.none,
                labelText: label,
                hintText: hint,
                labelStyle: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontFamily: 'Poppins',
                ),
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade300)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Or Continue With",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade300)),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: _socialButton(
                label: "Google",
                iconPath: 'assets/images/google.png',
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _socialButton(
                label: "Apple",
                iconPath: 'assets/images/apple.png',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _socialButton({required String label, required String iconPath}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 20,
              errorBuilder: (c, e, s) => const Icon(Icons.star_border),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
