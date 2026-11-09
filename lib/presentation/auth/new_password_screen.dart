import 'package:flutter/material.dart';
import 'login_screen.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. HEADER AREA (IDENTIK DENGAN LOGIN)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.42,
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
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
                            _buildWatermark(top: 20, left: 20),
                            _buildWatermark(bottom: 20, right: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 10,
                    height: MediaQuery.of(context).size.height * 0.43,
                    child: Image.asset(
                      'assets/images/kaki-1.png', // Gambar sepatu kets krem
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: 25,
                    left: 20,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, size: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. FORM SECTION
            Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.55,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Enter New Password",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Your New Password Must Be Different From Previously Used Password.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 35),
                        _buildInputField(
                          icon: Icons.lock_outline,
                          label: "Password",
                          hint: "••••••••",
                          isPassword: true,
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          icon: Icons.lock_outline,
                          label: "Confirm Password",
                          hint: "Confirm Password",
                          isPassword: true,
                        ),
                      ],
                    ),

                    // BUTTONS AT BOTTOM
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              // Menuju halaman Login dan menghapus semua history (OTP, Forgot Pwd, dll)
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) =>
                                    false, // Ini yang bikin user nggak bisa klik 'back' lagi
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Continue",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            // Ini akan menghapus semua tumpukan halaman dan langsung ke Login
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(text: "Back To "),
                                TextSpan(
                                  text: "Sign In",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // REUSABLE WIDGETS
  Widget _buildWatermark({
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
          "SHOES",
          style: TextStyle(
            fontSize: 100,
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
                labelStyle: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
