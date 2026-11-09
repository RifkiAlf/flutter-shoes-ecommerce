import 'dart:math' as math;
import 'package:flutter/material.dart';

class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  final PageController _pageController = PageController(initialPage: 3000);

  // Data Produk Promo
  final List<Map<String, String>> _promos = [
    {
      'subtitle': "WOMAN'S SHOES",
      'title': 'Nike SB\nZoom Stefan\nJanoski', 
      'image': 'assets/images/kaki-1.png',
    },
    {
      'subtitle': "MEN'S RUNNING",
      'title': 'Adidas\nUltraBoost\nPerformance',
      'image': 'assets/images/kaki-2.png',
    },
    {
      'subtitle': "LIMITED EDITION",
      'title': 'Air Jordan 1\nRetro High\nClassic',
      'image': 'assets/images/kaki-3.png',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Deteksi tema aktif (Dark/Light) dari context
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: 215, // Tinggi Banner Dinaikkan
      decoration: const BoxDecoration(
        color: Color(0xFFF3EFE6), // Background Banner
      ),
      child: Stack(
        children: [
          // --- RECTANGLE PUTIH STATIS ---
          Positioned(
            right: 35, 
            bottom: 0, 
            width: 110, // Diperlebar
            height: 195, // Dipertinggi
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(200), // Rounded Top
                  bottom: Radius.zero,       // Flat Bottom
                ),
              ),
            ),
          ),

          // --- FOTO KAKI (ANIMASI MEMUDAR INFINITE LOOP) ---
          Positioned(
            right: 0, 
            top: 0, 
            bottom: 0, 
            child: AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                double page = _pageController.initialPage.toDouble();
                if (_pageController.hasClients && _pageController.position.haveDimensions) {
                  page = _pageController.page!;
                }
                
                double realPage = page % _promos.length;

                return Stack(
                  alignment: Alignment.centerRight,
                  children: List.generate(_promos.length, (i) {
                    double diff = (realPage - i).abs();
                    double circularDiff = math.min(diff, _promos.length - diff);
                    double opacity = (1 - circularDiff).clamp(0.0, 1.0);

                    return Opacity(
                      opacity: opacity,
                      child: Padding(
                        // PERUBAHAN UTAMA: Hapus padding/margin di bagian atas
                        // Hanya beri sedikit jarak bawah agar gambar tidak terpotong
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Image.asset(
                          _promos[i]['image']!,
                          fit: BoxFit.fitHeight, // Mengisi Tinggi
                          alignment: Alignment.topCenter, // Menempel ke Atas
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),

          // --- KONTEN DINAMIS (TEKS & TOMBOL) ---
          PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              final realIndex = index % _promos.length;
              final promo = _promos[realIndex];

              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double pageOffset = (_pageController.initialPage - index).toDouble();
                  if (_pageController.hasClients && _pageController.position.haveDimensions) {
                    pageOffset = _pageController.page! - index;
                  }

                  double subtitleOffset = pageOffset * 150;
                  double titleOffset = pageOffset * 50;
                  double buttonOffset = -pageOffset * 150;
                  double opacity = (1 - pageOffset.abs() * 1.5).clamp(0.0, 1.0);

                  return Container(
                    width: double.infinity,
                    color: Colors.transparent, // Background Transparan
                    child: Stack(
                      children: [
                        Positioned(
                          left: 20 + subtitleOffset,
                          top: 28, // Jarak Atas Diselaraskan
                          child: Opacity(
                            opacity: opacity,
                            child: Text(
                              promo['subtitle']!,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                color: Colors.redAccent, 
                                fontSize: 12, // Diperbesar
                                letterSpacing: 1.2
                              ),
                            ),
                          ),
                        ),
                        
                        Positioned(
                          left: 20 + titleOffset,
                          top: 52, // Jarak Atas Diselaraskan
                          child: Opacity(
                            opacity: opacity,
                            child: Text(
                              promo['title']!,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 24, // Diperkecil Sedikit
                                height: 1.15, // Jarak Baris Rapat
                                color: Colors.black, // Judul Hitam
                              ),
                            ),
                          ),
                        ),
                        
                        Positioned(
                          left: 20 + buttonOffset,
                          bottom: 25, // Jarak Bawah Diselaraskan
                          child: Opacity(
                            opacity: opacity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                // PERUBAHAN: Padding Diperkecil
                                padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                                  if (states.contains(WidgetState.pressed)) {
                                    return isDark ? Colors.black : Colors.white; // Pressed BG
                                  }
                                  return isDark ? Colors.white : Colors.black;   // Normal BG
                                }),
                                foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                                  if (states.contains(WidgetState.pressed)) {
                                    return isDark ? Colors.white : Colors.black; // Pressed Text
                                  }
                                  return isDark ? Colors.black : Colors.white;   // Normal Text
                                }),
                                side: WidgetStateProperty.resolveWith<BorderSide>((Set<WidgetState> states) {
                                  if (!isDark && states.contains(WidgetState.pressed)) {
                                    return const BorderSide(color: Colors.black, width: 1); // Border Pressed (Light)
                                  }
                                  return BorderSide.none;
                                }),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Shop Now', 
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13, // Diperkecil
                                  fontWeight: FontWeight.w600 
                                )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}