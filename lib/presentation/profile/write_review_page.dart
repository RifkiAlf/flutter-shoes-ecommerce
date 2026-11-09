import 'package:flutter/material.dart';
import 'package:footflare/presentation/order/my_order_screen.dart';
import 'package:footflare/presentation/product_detail/product_detail_page.dart';

class WriteReviewPage extends StatefulWidget {
  const WriteReviewPage({super.key});

  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  int _currentRating = 4;
  bool _isRecommended = true;

  final Map<String, dynamic> productData = {
    "name": "Echo Vibe Urban Runners",
    "price": "\$179",
    "image": "assets/images/pic1.png",
  };

  @override
  Widget build(BuildContext context) {
    // Mengecek apakah mode saat ini adalah Dark Mode
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // Warna background scaffold
      backgroundColor: isDark ? const Color(0xFF1E1F28) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1F28) : Colors.white,
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
          'Write Review',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // --- Product Card ---
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2A2D3A) : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isDark
                      ? Colors.grey.shade800
                      : const Color(0xFFEEEEEE),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1E1F28)
                          : const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      productData['image'],
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productData['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              productData['price'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "FREE Delivery",
                              style: TextStyle(
                                color: Colors.green.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "40% Off",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailPage(product: productData),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF1E1F28)
                            : const Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 20,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Divider(
              color: isDark ? Colors.grey.shade800 : const Color(0xFFEEEEEE),
            ),
            const SizedBox(height: 20),

            // --- Rating Section ---
            Text(
              "Overall Rating",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Your Average Rating Is ${_currentRating.toDouble()}",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentRating = index + 1;
                    });
                  },
                  child: Icon(
                    index < _currentRating ? Icons.star : Icons.star_border,
                    color: const Color(0xFFE91E63),
                    size: 45,
                  ),
                );
              }),
            ),

            const SizedBox(height: 30),

            _buildInputLabel("Review Title", isDark),
            _buildTextField(hint: "Enter your review title", isDark: isDark),
            const SizedBox(height: 20),
            _buildInputLabel("Product Review", isDark),
            _buildTextField(
              hint: "Write your experience with this product",
              maxLines: 4,
              isDark: isDark,
            ),

            const SizedBox(height: 25),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Would you recommend this product to a friend?",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => _isRecommended = true),
                  child: _buildRadioButton(_isRecommended, "Yes", isDark),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () => setState(() => _isRecommended = false),
                  child: _buildRadioButton(!_isRecommended, "No", isDark),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // --- SUBMIT BUTTON ---
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyOrderScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? Colors.white : Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  "Submit Review",
                  style: TextStyle(
                    color: isDark ? Colors.black : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---
  Widget _buildInputLabel(String label, bool isDark) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            fontFamily: 'Poppins',
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    int maxLines = 1,
    required bool isDark,
  }) {
    return TextField(
      maxLines: maxLines,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        filled: true,
        fillColor: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF7F7F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildRadioButton(bool isSelected, String label, bool isDark) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? const Color(0xFFE91E63) : Colors.grey,
              width: 2,
            ),
          ),
          child: Center(
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? const Color(0xFFE91E63)
                    : Colors.transparent,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
