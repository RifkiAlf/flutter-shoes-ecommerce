import 'package:flutter/material.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  // Indeks untuk melacak FAQ mana yang sedang terbuka
  int? _openTileIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Cek status Dark Mode
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // ✅ Background Scaffold
      backgroundColor: isDark ? const Color(0xFF1E1F28) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1F28) : Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              // ✅ Background tombol kembali
              color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: isDark ? Colors.white : Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          'FAQ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildFaqItem(
            index: 0,
            isDark: isDark,
            question: "What is included with my purchase?",
            answer:
                "Package have the HTML files, SCSS files, CSS files, JS files, Well Define Documentation, Fonts and Icons, Responsive Designs, Image Assets, Customization Options, and many more.",
          ),
          _buildFaqItem(
            index: 1,
            isDark: isDark,
            question: "What features does FootFlare offer?",
            answer:
                "FootFlare offers a wide range of features including responsive design, customizable layouts, product catalog pages, shopping cart functionality, checkout pages, user account management, and more.",
          ),
          _buildFaqItem(
            index: 2,
            isDark: isDark,
            question: "Can I customize the template's design?",
            answer:
                "Absolutely! FootFlare is built using Bootstrap, which makes it highly customizable. You can easily adjust colors, fonts, layout structures, and more to match your brand's identity.",
          ),
          _buildFaqItem(
            index: 3,
            isDark: isDark,
            question: "Is the template SEO-friendly?",
            answer:
                "FootFlare is built with best practices in mind, including SEO optimization. You can optimize your product pages, meta tags, and other elements to improve your website's search engine visibility.",
          ),
          _buildFaqItem(
            index: 4,
            isDark: isDark,
            question: "Are there pre-designed page templates included?",
            answer:
                "Yes, FootFlare typically includes pre-designed templates for essential pages like the homepage, product listings, product details, shopping cart, checkout, and user account pages.",
          ),
          _buildFaqItem(
            index: 5,
            isDark: isDark,
            question: "Does FootFlare provide customer support?",
            answer:
                "FootFlare offers customer support options for their clients. Check the template documentation or you can directly contact to our support team from here - Click Here",
          ),
          _buildFaqItem(
            index: 6,
            isDark: isDark,
            question: "Is coding knowledge required to use FootFlare?",
            answer:
                "Basic knowledge of HTML, CSS, and Bootstrap can be helpful for customizing FootFlare to your needs. However, it's designed to be user-friendly and doesn't necessarily require extensive coding skills.",
          ),
          _buildFaqItem(
            index: 7,
            isDark: isDark,
            question: "How can I get started with FootFlare?",
            answer:
                "To get started, purchase and download the FootFlare template. Then, follow the included documentation to set up and customize your e-commerce website based on your specific requirements.",
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem({
    required int index,
    required bool isDark,
    required String question,
    required String answer,
  }) {
    bool isOpen = _openTileIndex == index;

    // Warna container saat tertutup
    Color collapsedBg = isDark
        ? const Color(0xFF2A2D3A)
        : const Color(0xFFF7F7F7);
    // Warna container saat terbuka (biar tetap kontras)
    Color expandedBg = isDark
        ? const Color(0xFF3A3E4E)
        : const Color(0xFF333333);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: isOpen ? expandedBg : collapsedBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          key: Key('faq_${index}_$isOpen'),
          initiallyExpanded: isOpen,
          onExpansionChanged: (expanded) {
            setState(() {
              _openTileIndex = expanded ? index : null;
            });
          },
          title: Text(
            question,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              fontFamily: 'Poppins',
              color: isOpen
                  ? Colors.white
                  : (isDark ? Colors.white : Colors.black),
            ),
          ),
          iconColor: Colors.white,
          collapsedIconColor: isDark ? Colors.white : Colors.black,
          showTrailingIcon: true,
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              // ✅ Background jawaban agar menyatu dengan container utama
              color: isOpen ? expandedBg : collapsedBg,
              child: Text(
                answer,
                style: TextStyle(
                  color: isOpen
                      ? Colors.white70
                      : (isDark ? Colors.white70 : Colors.black87),
                  height: 1.5,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
