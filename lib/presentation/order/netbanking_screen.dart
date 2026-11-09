import 'package:flutter/material.dart';

class NetbankingScreen extends StatelessWidget {
  const NetbankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close, color: isDark ? Colors.white : Colors.black),
        ),
        title: Text(
          "Net Banking",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search
            TextField(
              style: TextStyle(
                fontFamily: 'Poppins',
                color: isDark ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                hintText: "Search by bank name",
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  color: isDark ? Colors.grey.shade400 : Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: isDark ? Colors.white : Colors.black,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Popular Banks
            _buildPopularBanksCard(isDark),

            const SizedBox(height: 24),
            Text(
              "All Banks",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            _buildAllBanksList(isDark),

            const SizedBox(height: 40),
            _buildReturnButton(context, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildReturnButton(BuildContext context, bool isDark) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(
              color: isDark ? Colors.white : Colors.black,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                size: 18,
                color: isDark ? Colors.white : Colors.black,
              ),
              const SizedBox(width: 8),
              Text(
                "Return",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularBanksCard(bool isDark) {
    final bankImages = [
      "assets/images/bank1.png",
      "assets/images/bank2.png",
      "assets/images/bank3.png",
      "assets/images/bank4.png",
      "assets/images/bank5.png",
      "assets/images/bank6.png",
      "assets/images/bank7.png",
      "assets/images/bank8.png",
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2D3A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Popular Banks",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 8),

          Container(
            width: double.infinity,
            height: 1,
            color: isDark ? Colors.grey.shade700 : const Color(0xFFEAEAEA),
          ),

          const SizedBox(height: 16),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: bankImages.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return Center(
                child: Image.asset(
                  bankImages[index],
                  width: 56,
                  height: 56,
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAllBanksList(bool isDark) {
    final banks = [
      "Bank of india",
      "Bank Of Maharasthra",
      "Canara Bank",
      "HDFC Bank",
      "IDFC Bank",
      "Catholic Syrian Bank",
      "City Union Bank",
      "Central Bank of India",
      "Cosmos Bank",
      "Corporation Bank",
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildBankColumn(banks.sublist(0, 5), isDark)),
        Expanded(child: _buildBankColumn(banks.sublist(5), isDark)),
      ],
    );
  }

  Widget _buildBankColumn(List<String> list, bool isDark) {
    return Column(
      children: list
          .map(
            (name) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_forward,
                    size: 14,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
