import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. HEADER AREA (SAMA DENGAN LOGIN)
            // 1. HEADER AREA (IDENTIK DENGAN LOGIN PAGE)
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
                    bottom: 84, // Disamakan dengan login page
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
                    bottom: 10, // Disamakan dengan login page
                    height: MediaQuery.of(context).size.height * 0.43,
                    child: Image.asset(
                      'assets/images/kaki-3.png', // Aset gambar register kamu
                      fit: BoxFit.contain,
                    ),
                  ),

                  // TOMBOL KEMBALI (IDENTIK DENGAN LOGIN PAGE)
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

            // 2. FORM SECTION
            Transform.translate(
              offset: const Offset(0, -40),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Create Your Account",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const Text(
                      "Welcome Back! Please Enter Your Details",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 25),

                    // INPUT NAME
                    _buildInputField(
                      icon: Icons.person_outline,
                      label: "Name",
                      hint: "Amelia",
                    ),
                    const SizedBox(height: 15),

                    // INPUT EMAIL
                    _buildInputField(
                      icon: Icons.email_outlined,
                      label: "Email Address",
                      hint: "example@gmail.com",
                    ),
                    const SizedBox(height: 15),

                    // INPUT PASSWORD
                    _buildInputField(
                      icon: Icons.lock_outline,
                      label: "Password",
                      hint: "Password",
                      isPassword: true,
                    ),
                    const SizedBox(height: 15),

                    // CHECKBOX TERMS
                    Row(
                      children: [
                        Checkbox(
                          value: _isAgreed,
                          activeColor: Colors.black,
                          onChanged: (val) => setState(() => _isAgreed = val!),
                        ),
                        const Expanded(
                          child: Text(
                            "I agree to all Term, Privacy and Fees",
                            style: TextStyle(fontSize: 13, fontFamily: 'Poppins'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // BUTTON SIGN UP
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),
                    _buildSocialSection(),
                    const SizedBox(height: 25),

                    // FOOTER LOGIN LINK
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have and account? ",
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (c) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- REUSABLE WIDGETS ---

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
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
        const SizedBox(height: 20),
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
    return Container(
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
    );
  }
}
