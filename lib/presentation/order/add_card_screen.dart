import 'package:flutter/material.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1C1F2A) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1C1F2A) : Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 52,
        leading: _buildSquareBackButton(context, isDark),
        title: Text(
          "Add Card",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildVisualCard(),
                  const SizedBox(height: 24),

                  _buildInputLabel("Card Name", isDark),
                  _buildInputField(_nameController, "Roopa Smith", isDark),

                  const SizedBox(height: 16),
                  _buildInputLabel("Card Number", isDark),
                  _buildInputField(
                    _numberController,
                    "**** **** **** 4532",
                    isDark,
                    isNumber: true,
                  ),

                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInputLabel("Expiry Date", isDark),
                            _buildInputField(
                              _expiryController,
                              "mm/dd/yyyy",
                              isDark,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInputLabel("CVV", isDark),
                            _buildInputField(
                              _cvvController,
                              "012",
                              isDark,
                              isNumber: true,
                              isObscure: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _buildAddCardButton(isDark),
        ],
      ),
    );
  }

  // --- VISUAL CARD (TIDAK DIUBAH) ---
  Widget _buildVisualCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF8D1C3D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "CREDIT CARD",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Text(
                "VISA",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            "**** **** **** 4532",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "ROOPA SMITH",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Row(
                children: [
                  _buildCardInfoPair("EXP", "14/07"),
                  const SizedBox(width: 16),
                  _buildCardInfoPair("CVV", "012"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardInfoPair(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "EXP",
          style: TextStyle(color: Colors.white70, fontSize: 10),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // --- LABEL ---
  Widget _buildInputLabel(String label, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  // --- INPUT ---
  Widget _buildInputField(
    TextEditingController controller,
    String hint,
    bool isDark, {
    bool isNumber = false,
    bool isObscure = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      obscureText: isObscure,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 15,
        color: isDark ? Colors.white : Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: isDark ? const Color(0xFF2A2D3A) : Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDark ? Colors.white : Colors.black,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  // --- BUTTON ---
  Widget _buildAddCardButton(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1F2A) : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.grey.shade800 : const Color(0xFFF3F3F3),
          ),
        ),
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? Colors.white : Colors.black,
            minimumSize: const Size(double.infinity, 56),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ).copyWith(overlayColor: WidgetStateProperty.all(Colors.transparent)),
          child: Text(
            "Add Card",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: isDark ? Colors.black : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // --- BACK BUTTON ---
  Widget _buildSquareBackButton(BuildContext context, bool isDark) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        margin: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: isDark ? Colors.white : Colors.black,
            size: 18,
          ),
        ),
      ),
    );
  }
}
