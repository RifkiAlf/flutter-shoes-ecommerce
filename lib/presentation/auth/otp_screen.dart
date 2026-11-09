import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'new_password_screen.dart';
import 'login_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. HEADER AREA (IDENTIK DENGAN LOGIN/REGISTER/FORGOT)
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
                            _buildWatermark(top: 20, left: 20),
                            _buildWatermark(bottom: 20, right: 20),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // GAMBAR SEPATU (image_afe29d.png)
                  Positioned(
                    right: 0,
                    bottom: 10,
                    height: MediaQuery.of(context).size.height * 0.43,
                    child: Image.asset(
                      'assets/images/kaki-3.png',
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

            // 2. FORM SECTION
            Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                // Menggunakan constraints agar tombol terdorong ke bawah layar
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.55,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // BAGIAN ATAS: Judul & Input OTP
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Enter Code",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontFamily: 'Poppins',
                              height: 1.4,
                            ),
                            children: [
                              TextSpan(
                                text: "An Authentication Code Has Sent To ",
                              ),
                              TextSpan(
                                text: "testing@gmail.com",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Enter OTP",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 15),

                        // 6 KOTAK INPUT OTP
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            6,
                            (index) => _buildOtpBox(context, index),
                          ),
                        ),
                      ],
                    ),

                    // BAGIAN BAWAH: Tombol Verify & Back
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const NewPasswordScreen(),
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
                              "Verify And Proceed",
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

  // --- HELPER WIDGETS ---

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
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w900,
            color: const Color(0xFFDFD7CA).withOpacity(0.4),
            letterSpacing: -5,
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox(BuildContext context, int index) {
    return Container(
      height: 60,
      width: 45, // Ukuran kotak agar muat 6 baris
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            FocusScope.of(
              context,
            ).nextFocus(); // Pindah otomatis ke kotak berikutnya
          }
        },
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
