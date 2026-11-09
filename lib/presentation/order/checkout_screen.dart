import 'package:flutter/material.dart';
import 'address_list_screen.dart';
import 'payment_screen.dart';
import 'my_order_screen.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const CheckoutScreen({super.key, required this.items});

  void _navigateTo(BuildContext context, Widget target) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => target,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    double subtotal = items.fold(
      0.0,
      (sum, item) => sum + (item['price'] * item['qty']),
    );
    double discount = 100.0;
    double totalOrder = subtotal - discount;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1F28) : Colors.white,

      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1F28) : Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 52,
        leading: _buildBackButton(context, isDark),
        title: Text(
          "Checkout",
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
                  _buildListTile(
                    context,
                    icon: Icons.location_on,
                    title: "Delivery Address",
                    subtitle: "123 Main Street, Anytown, USA 12345",
                    onTap: () =>
                        _navigateTo(context, const AddressListScreen()),
                    isDark: isDark,
                  ),

                  Divider(
                    height: 1,
                    thickness: 1.5,
                    color: isDark
                        ? Colors.grey.shade800
                        : const Color(0xFFF3F3F3),
                  ),

                  _buildListTile(
                    context,
                    icon: Icons.account_balance_wallet,
                    title: "Payment",
                    subtitle: "XXXX XXXX XXXX 3456",
                    onTap: () => _navigateTo(context, const PaymentScreen()),
                    isDark: isDark,
                  ),

                  const SizedBox(height: 24),

                  Text(
                    "Additional Notes:",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),

                  const SizedBox(height: 12),

                  _buildNoteField(isDark),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1F28) : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark
                      ? Colors.grey.shade800
                      : const Color(0xFFF3F3F3),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...items.map(
                  (item) => _buildSummaryRow(
                    item['name'],
                    "${item['qty']} x \$${(item['price'] as num).toStringAsFixed(2)}",
                    isBold: true,
                    isDark: isDark,
                  ),
                ),

                _buildSummaryRow(
                  "Discount",
                  "-\$${discount.toStringAsFixed(2)}",
                  isBold: true,
                  isDark: isDark,
                ),

                _buildSummaryRow(
                  "Shipping",
                  "FREE Delivery",
                  isGreen: true,
                  isBold: true,
                  isDark: isDark,
                ),

                Divider(
                  height: 30,
                  thickness: 1.5,
                  color: isDark ? Colors.white : Colors.black,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Order",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      "\$${totalOrder.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                _buildSubmitButton(context, isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      subtitle,
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

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isGreen = false,
    bool isBold = false,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              color: isGreen
                  ? Colors.green
                  : (isDark ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context, bool isDark) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const MyOrderScreen(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? Colors.white : Colors.black,
          minimumSize: const Size(double.infinity, 56),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ).copyWith(overlayColor: WidgetStateProperty.all(Colors.transparent)),
        child: Text(
          "Submit Order",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: isDark ? Colors.black : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
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

  Widget _buildNoteField(bool isDark) {
    return TextField(
      maxLines: 3,
      style: TextStyle(
        fontFamily: 'Poppins',
        color: isDark ? Colors.white : Colors.black,
      ),
      decoration: InputDecoration(
        hintText: "Write Here",
        hintStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: isDark ? const Color(0xFF2A2D3A) : Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.grey.shade700 : const Color(0xFFF3F3F3),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.white : Colors.black,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
