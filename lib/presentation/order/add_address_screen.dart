import 'package:flutter/material.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  String selectedCategory = "Home";

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1F28) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1F28) : Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 52,
        leading: _buildBackButton(context, isDark),
        title: Text(
          "Add delivery address",
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
                  Text(
                    "Contact Details",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  _buildInputField("Full Name", isDark),
                  _buildInputField("Mobile No.", isDark),

                  const SizedBox(height: 24),

                  Text(
                    "Address",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  _buildInputField("Pin Code", isDark),
                  _buildInputField("Address", isDark),
                  _buildInputField("Locality/Town", isDark),
                  _buildInputField("City/District", isDark),
                  _buildInputField("State", isDark),

                  const SizedBox(height: 24),

                  Text(
                    "Save Address As",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      _buildCategoryChip("Home", isDark),
                      const SizedBox(width: 12),
                      _buildCategoryChip("Shop", isDark),
                      const SizedBox(width: 12),
                      _buildCategoryChip("Office", isDark),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          _buildSaveButton(isDark),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            style: TextStyle(
              fontFamily: 'Poppins',
              color: isDark ? Colors.white : Colors.black,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: isDark ? const Color(0xFF2A2D3A) : Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
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
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isDark) {
    bool isSelected = selectedCategory == label;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => selectedCategory = label),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.black
                : (isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF3F3F3)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: isSelected
                  ? Colors.white
                  : (isDark ? Colors.white : Colors.black),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? Colors.white : Colors.black,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ).copyWith(overlayColor: WidgetStateProperty.all(Colors.transparent)),
          child: Text(
            "Save Address",
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

  Widget _buildBackButton(BuildContext context, bool isDark) {
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
