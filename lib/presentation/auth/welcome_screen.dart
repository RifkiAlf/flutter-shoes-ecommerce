import 'package:flutter/material.dart';
import 'login_screen.dart';
// Jika kamu sudah membuat LoginScreen, import di sini:
// import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Kita hapus backgroundColor putih di sini agar background image terlihat penuh
      body: Stack(
        children: [
          // 1. Background Image FULL SCREEN
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_welcome.png', // Background pilihanmu
              fit: BoxFit.cover, // Gunakan BoxFit.cover agar memenuhi layar
              alignment: Alignment.center,
            ),
          ),

          // 2. Konten Teks dan Tombol (Mengambang di Atas Background)
          Align(
            alignment:
                Alignment.bottomLeft, // Sesuai gambar, teks di kiri bawah
            child: Container(
              // Hapus tinggi statis, biarkan membungkus konten
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: 60,
                top: 40,
              ),
              // PENTING: Hapus 'color: Colors.white' di sini
              decoration: const BoxDecoration(
                color: Colors.transparent, // Jadikan transparan
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Bungkus konten rapat
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Teks: YOUR FEET WILL NEVER LOOK THE (Tipis)
                  const Text(
                    "YOUR FEET WILL\nNEVER LOOK THE",
                    style: TextStyle(
                      color: Colors
                          .black, // Jika background gelap, ganti ke Colors.white
                      fontSize: 32,
                      fontWeight: FontWeight.w300, // Light/Thin
                      fontFamily: 'Poppins',
                      height: 1.1,
                    ),
                  ),
                  // Teks: SAME AGAIN (Tebal)
                  const Text(
                    "SAME AGAIN",
                    style: TextStyle(
                      color: Colors
                          .black, // Jika background gelap, ganti ke Colors.white
                      fontSize: 32,
                      fontWeight: FontWeight.w900, // Extra Bold/Black
                      fontFamily: 'Poppins',
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Tombol: Get Started (Hitam Pekat)
                  SizedBox(
                    width: 160,
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
                        foregroundColor: Colors.white,
                        elevation:
                            4, // Beri sedikit bayangan agar menonjol dari background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
