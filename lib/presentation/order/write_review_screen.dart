import 'package:flutter/material.dart';
import '../product_detail/product_detail_page.dart';
import 'my_order_screen.dart';

class WriteReviewScreen extends StatefulWidget {
  final Map<String, String> item;
  const WriteReviewScreen({super.key, required this.item});

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  int rating = 4;
  String recommendation = "Yes";

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1F28) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E2C) : Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 52, // ✅ TAMBAH INI
        leading: _buildHeaderButton(
          Icons.arrow_back_ios_new,
          () => Navigator.pop(context),
        ),
        title: Text(
          "Write Review",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProductHeader(context, widget.item, isDark),
            const SizedBox(height: 16),
            Divider(
              thickness: 1,
              color: isDark ? Colors.grey.shade800 : const Color(0xFFF3F3F3),
            ),
            const SizedBox(height: 24),
            Text(
              "Overall Rating",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const Text(
              "Your Average Rating Is 4.0",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (i) => IconButton(
                  onPressed: () => setState(() => rating = i + 1),
                  icon: Icon(
                    i < rating ? Icons.star : Icons.star_border,
                    color: const Color(0xFFB3261E),
                    size: 36,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildInputLabel("Review Title", isDark),
            _buildTextField(1, isDark),
            const SizedBox(height: 20),
            _buildInputLabel("Product Review", isDark),
            _buildTextField(4, isDark),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Would you recommend this product to a friend?",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            Row(
              children: [
                Radio(
                  value: "Yes",
                  groupValue: recommendation,
                  activeColor: isDark ? Colors.white : Colors.black,
                  onChanged: (v) =>
                      setState(() => recommendation = v.toString()),
                ),
                Text(
                  "Yes",
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                ),
                const SizedBox(width: 16),
                Radio(
                  value: "No",
                  groupValue: recommendation,
                  activeColor: isDark ? Colors.white : Colors.black,
                  onChanged: (v) =>
                      setState(() => recommendation = v.toString()),
                ),
                Text(
                  "No",
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MyOrderScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? Colors.white : Colors.black,
            foregroundColor: isDark ? Colors.black : Colors.white,
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Submit Order",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderButton(IconData icon, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        margin: const EdgeInsets.only(
          left: 16, // ✅ SAMA PERSIS
          top: 10,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          onPressed: onTap,
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
          ),
          padding: EdgeInsets.zero,
          icon: Icon(
            icon,
            color: isDark ? Colors.white : Colors.black,
            size: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildProductHeader(
    BuildContext context,
    Map<String, String> item,
    bool isDark,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                  product: {
                    "name": item['name'],
                    "price": "\$${item['price']}",
                    "image": item['image'],
                  },
                ),
              ),
            ),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF2A2D3A)
                    : const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  item['image']!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name']!,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "\$${item['price']}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "FREE Delivery",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Text(
                  "40% Off",
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            product: {
                              "name": item['name'],
                              "price": "\$${item['price']}",
                              "image": item['image'],
                            },
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF2A2D3A)
                              : const Color(0xFFF3F3F3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputLabel(String label, bool isDark) => Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    ),
  );

  Widget _buildTextField(int lines, bool isDark) => TextField(
    maxLines: lines,
    style: TextStyle(color: isDark ? Colors.white : Colors.black),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      filled: true,
      fillColor: isDark ? const Color(0xFF2A2D3A) : Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark ? Colors.grey.shade700 : const Color(0xFFD9D9D9),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: isDark ? Colors.white : Colors.black),
      ),
    ),
  );
}
