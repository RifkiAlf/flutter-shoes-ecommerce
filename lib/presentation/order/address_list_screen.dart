import 'package:flutter/material.dart';
import 'add_address_screen.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  int selectedIndex = 1;

  final List<Map<String, dynamic>> addressList = [
    {
      "id": 0,
      "type": "Home Address",
      "desc": "123 Main Street, USA",
      "icon": Icons.home_rounded,
    },
    {
      "id": 1,
      "type": "Office Address",
      "desc": "456 Elm Avenue, USA",
      "icon": Icons.location_on_rounded,
    },
    {
      "id": 2,
      "type": "Home Address",
      "desc": "789 Maple Lane, USA",
      "icon": Icons.home_rounded,
    },
    {
      "id": 3,
      "type": "Shop Address",
      "desc": "654 Pine Road, USA",
      "icon": Icons.shopping_bag_rounded,
    },
  ];

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
        leading: _buildSquareButton(
          icon: Icons.arrow_back_ios_new,
          onPressed: () => Navigator.pop(context),
          isDark: isDark,
        ),
        title: Text(
          "Delivery Address",
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
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ...addressList.map((addr) => _buildAddressItem(addr, isDark)),
                const SizedBox(height: 20),
                _buildAddAddressButton(context, isDark),
              ],
            ),
          ),
          _buildSaveButton(isDark),
        ],
      ),
    );
  }

  Widget _buildAddressItem(Map<String, dynamic> addr, bool isDark) {
    bool isSelected = selectedIndex == addr['id'];

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => selectedIndex = addr['id']),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                width: 2.0,
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(addr['icon'], color: Colors.white, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      addr['type'],
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      addr['desc'],
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: isSelected
                    ? (isDark ? Colors.white : Colors.black)
                    : Colors.grey.shade300,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddAddressButton(BuildContext context, bool isDark) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  const AddAddressScreen(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.add_circle_outline,
                color: isDark ? Colors.white : Colors.black,
                size: 22,
              ),
              const SizedBox(width: 12),
              Text(
                "Add Address",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: isDark ? Colors.white : Colors.black,
              ),
            ],
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
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ).copyWith(overlayColor: WidgetStateProperty.all(Colors.transparent)),
          child: Text(
            "Save Address",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: isDark ? Colors.black : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSquareButton({
    required IconData icon,
    required VoidCallback onPressed,
    required bool isDark,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        margin: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          onPressed: onPressed,
          style: const ButtonStyle(
            splashFactory: NoSplash.splashFactory,
          ).copyWith(overlayColor: WidgetStateProperty.all(Colors.transparent)),
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
}
