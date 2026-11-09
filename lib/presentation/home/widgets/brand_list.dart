import 'package:flutter/material.dart';
import '../../main_screen.dart';

class BrandList extends StatelessWidget {
  const BrandList({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, String>> brands = [
      {'name': 'Nike', 'image': 'assets/images/logo-nike.png'},
      {'name': 'Adidas', 'image': 'assets/images/logo-addidas.png'},
      {'name': 'Reebok', 'image': 'assets/images/logo-reebok.png'},
      {'name': 'Puma', 'image': 'assets/images/logo-puma.png'},
      {'name': 'Bata', 'image': 'assets/images/logo-bata.png'},
      // --- 4 Brand Tambahan ---
      {'name': 'Nike', 'image': 'assets/images/logo-nike.png'},
      {'name': 'Adidas', 'image': 'assets/images/logo-addidas.png'},
      {'name': 'Reebok', 'image': 'assets/images/logo-reebok.png'},
      {'name': 'Bata', 'image': 'assets/images/logo-bata.png'},
    ];

    return SizedBox(
      height: 95, // Diperkecil agar lebih proporsional
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: brands.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const MainScreen(initialIndex: 3),
                ),
                (route) => false,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                children: [
                  Container(
                    width: 62, // Diperkecil agar persis referensi
                    height: 62, 
                    padding: const EdgeInsets.all(14), // Disesuaikan agar logo pas
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                        width: 1.0,
                      ),
                      color: Colors.white,
                    ),
                    child: Image.asset(
                      brands[index]['image']!,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    brands[index]['name']!,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12, // Diperkecil agar lebih rapi
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}