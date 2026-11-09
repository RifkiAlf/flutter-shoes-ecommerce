import 'package:flutter/material.dart';

class LanguageModal {
  static void show(BuildContext context, Function(String) onLanguageSelected) {
    // Mendeteksi tema
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            // Warna mengikuti tema Dark/Light
            color: isDark ? const Color(0xFF2A2D3A) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle Bar (Dekorasi swipe)
              Container(
                margin: const EdgeInsets.only(bottom: 20, top: 5),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Language",
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: onSurface,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: onSurface),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              
              // Daftar Bahasa (Disesuaikan ke pasar Indonesia & Global)
              _buildLangItem(context, "Indonesia", "🇮🇩", onLanguageSelected),
              _buildLangItem(context, "English", "🇺🇸", onLanguageSelected),
              _buildLangItem(context, "Japanese", "🇯🇵", onLanguageSelected),
              _buildLangItem(context, "German", "🇩🇪", onLanguageSelected),
              _buildLangItem(context, "Spanish", "🇪🇸", onLanguageSelected),
              
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildLangItem(
    BuildContext context, 
    String name, 
    String emoji, 
    Function(String) onLanguageSelected,
  ) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      leading: Text(
        emoji, 
        style: const TextStyle(fontSize: 24),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 16, 
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          color: onSurface,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios, 
        size: 14, 
        color: onSurface.withOpacity(0.5),
      ),
      onTap: () {
        onLanguageSelected(name);
        Navigator.pop(context);
      },
    );
  }
}