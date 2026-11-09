import 'dart:async';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late Animation<Offset> _walkAnimation;
  late Animation<double> _bounceAnimation;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;

  bool _showFinalImage = false;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // 1. Walk Animation - Menggunakan Curve di luar Interval agar tidak error
    _walkAnimation =
        Tween<Offset>(begin: const Offset(-3.0, 0.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _mainController,
            curve: const Interval(0.0, 0.7),
          ).drive(CurveTween(curve: Curves.easeOutCubic)),
        ); // Pindah ke sini kurvanya

    // 2. Bounce Animation (Tetap aman tanpa kurva di Interval)
    _bounceAnimation =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: -30.0), weight: 25),
          TweenSequenceItem(tween: Tween(begin: -30.0, end: 0.0), weight: 25),
          TweenSequenceItem(tween: Tween(begin: 0.0, end: -15.0), weight: 25),
          TweenSequenceItem(tween: Tween(begin: -15.0, end: 0.0), weight: 25),
        ]).animate(
          CurvedAnimation(
            parent: _mainController,
            curve: const Interval(0.0, 0.7),
          ),
        );

    // 3. Text Opacity (Fade In)
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _mainController, curve: const Interval(0.6, 0.9)),
    );

    // 4. Text Slide (Muncul dari bawah ke atas)
    _textSlide =
        Tween<Offset>(
          begin: const Offset(
            0.0,
            0.2,
          ), // GANTI DARI 0.5 KE 0.2 AGAR MULAI LEBIH DEKAT
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _mainController,
            curve: const Interval(0.6, 0.9),
          ).drive(CurveTween(curve: Curves.decelerate)),
        ); // Ganti backout ke decelerate (smooth)

    _mainController.forward().then((_) {
      if (mounted) {
        setState(() => _showFinalImage = true);

        // TAMBAHKAN INI: Tunggu 2 detik setelah animasi selesai, lalu pindah
        Timer(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/bg_splash.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // LOGO: Bouncing & Walking
                AnimatedBuilder(
                  animation: _mainController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                        _walkAnimation.value.dx *
                            MediaQuery.of(context).size.width *
                            0.5,
                        _bounceAnimation.value,
                      ),
                      child: child,
                    );
                  },
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    child: AnimatedCrossFade(
                      duration: const Duration(milliseconds: 180),
                      // Image ke-1 (saat jalan) - biarkan ukurannya
                      firstChild: Image.asset(
                        'assets/images/footflare1.png',
                        width: 120,
                      ),

                      // Image ke-2 (saat berhenti) - UBAH BAGIAN INI UNTUK MEMBESARKAN
                      secondChild: Image.asset(
                        'assets/images/footflare2.png',
                        width:
                            160, // GANTI DARI 140 MENJADI 180 (SESUAI KEINGINAN)
                      ),

                      crossFadeState: _showFinalImage
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // TEXT: FOOTFLARE
                FadeTransition(
                  opacity: _textOpacity,
                  child: SlideTransition(
                    position: _textSlide,
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 40,
                          letterSpacing: 3,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: "FOOT",
                            style: TextStyle(fontWeight: FontWeight.w200),
                          ),
                          TextSpan(
                            text: "FLARE",
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // VERSION
          Align(
            alignment: Alignment.bottomCenter,
            child: FadeTransition(
              opacity: _textOpacity,
              child: const Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Text(
                  "VERSION 1.0",
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 12,
                    letterSpacing: 2,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
