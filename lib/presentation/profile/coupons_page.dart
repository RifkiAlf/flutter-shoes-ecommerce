import 'package:flutter/material.dart';

class CouponsPage extends StatelessWidget {
  const CouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendeteksi apakah tema saat ini gelap atau terang
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      // Menggunakan warna background dari tema kelompok
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, size: 18, color: onSurface),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text(
          'My Coupons',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          CouponCard(
            discount: "20%",
            title: "New Arrival Sneakers",
            subtitle: "Minimum purchase Rp 1.500.000",
          ),
          CouponCard(
            discount: "50%",
            title: "Running Series",
            subtitle: "On minimum purchase Rp 2.000.000",
          ),
          CouponCard(
            discount: "25%",
            title: "All Sports Shoes",
            subtitle: "On minimum purchase Rp 999.000",
          ),
        ],
      ),
    );
  }
}

class CouponCard extends StatelessWidget {
  final String discount;
  final String title;
  final String subtitle;

  const CouponCard({
    super.key,
    required this.discount,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 100, // Sedikit lebih tinggi agar lebih lega
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2D3A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Bagian Kiri (Diskon)
          SizedBox(
            width: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  discount,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: onSurface,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  "Off",
                  style: TextStyle(
                    fontSize: 14,
                    color: onSurface.withOpacity(0.6),
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),

          // Garis Putus-putus
          const DashedLinePainter(),

          // Bagian Kanan (Detail)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: onSurface,
                      fontFamily: 'Poppins',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: onSurface.withOpacity(0.5),
                      fontFamily: 'Poppins',
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

class DashedLinePainter extends StatelessWidget {
  const DashedLinePainter({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return CustomPaint(
      size: const Size(1, 60),
      painter: _DashedLineVerticalPainter(
        color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
      ),
    );
  }
}

class _DashedLineVerticalPainter extends CustomPainter {
  final Color color;
  _DashedLineVerticalPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}