import 'package:flutter/material.dart';
import '../../utils/transitions.dart';
import 'netbanking_screen.dart';
import 'add_card_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Variabel untuk menyimpan metode mana yang sedang dipilih/meluas
  String selectedMethod = "Credit"; // Default: Credit Card

  @override
  Widget build(BuildContext context) {
    // Deteksi Tema
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
          "Payment",
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
                  // --- SECTION CARDS (HORIZONTAL SCROLL) ---
                  _buildCardSection(isDark),
                  const SizedBox(height: 24),

                  // --- DAFTAR METODE PEMBAYARAN (EXPANDABLE) ---
                  _buildExpandableMethod(
                    id: "Cash",
                    icon: Icons.attach_money_rounded,
                    title: "Cash on Delivery(Cash/UPI)",
                    expandedChild: _buildCashDetail(),
                    isDark: isDark,
                  ),
                  _buildExpandableMethod(
                    id: "UPI",
                    icon: Icons.qr_code_scanner_rounded,
                    title: "Google Pay/Phone Pay/BHIM UPI",
                    expandedChild: _buildUPIDetail(isDark),
                    isDark: isDark,
                  ),
                  _buildExpandableMethod(
                    id: "Wallet",
                    icon: Icons.account_balance_wallet_outlined,
                    title: "Payments/Wallet",
                    expandedChild: _buildWalletDetail(isDark),
                    isDark: isDark,
                  ),
                  _buildExpandableMethod(
                    id: "Netbanking",
                    icon: Icons.account_balance_rounded,
                    title: "Netbanking",
                    expandedChild: _buildNetbankingDetail(isDark),
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ),
          // Tombol Continue di Paling Bawah
          _buildContinueButton(isDark),
        ],
      ),
    );
  }

  // --- WIDGET HELPER UTAMA UNTUK KOTAK YANG BISA MELUAS ---
  Widget _buildExpandableMethod({
    required String id,
    required IconData icon,
    required String title,
    required Widget expandedChild,
    required bool isDark,
  }) {
    bool isSelected = selectedMethod == id;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
              )
            : null,
      ),
      child: Column(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () =>
                  setState(() => selectedMethod = isSelected ? "" : id),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: isDark ? Colors.white : Colors.black,
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: isSelected
                          ? (isDark ? Colors.white : Colors.black)
                          : Colors.grey.shade400,
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: SizedBox(
              width: double.infinity,
              child: !isSelected
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        Divider(
                          height: 1,
                          color: isDark
                              ? Colors.grey.shade800
                              : const Color(0xFFF3F3F3),
                        ),
                        TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.fastOutSlowIn,
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, value, child) {
                            return ClipRect(
                              child: Align(
                                alignment: Alignment.topCenter,
                                heightFactor: value,
                                child: Opacity(opacity: value, child: child),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: expandedChild,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // 1. Detail Cash
  Widget _buildCashDetail() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Text(
          "Carry on your cash payment..\nThanx!",
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.grey,
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  // 2. Detail UPI
  Widget _buildUPIDetail(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          "Link via UPI",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        _buildMinimalInputField("Enter your UPI ID", isDark),
        _buildInlineContinueButton(isDark),
        const SizedBox(height: 8),
        const Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green, size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                "Your UPI ID Will be encrypted and is 100% safe with us.",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 3. Detail Wallet
  Widget _buildWalletDetail(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          "Link Your Wallet",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        _buildMinimalInputField("+91", isDark),
        _buildInlineContinueButton(isDark),
      ],
    );
  }

  // 4. Detail Netbanking
  Widget _buildNetbankingDetail(bool isDark) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1F28) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
        ),
      ),
      child: ListTile(
        onTap: () =>
            Navigator.push(context, slideInRoute(const NetbankingScreen())),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: Text(
          "Netbanking",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          "Carry on your payment by select your bank",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  // --- SECTION KARTU KREDIT ---
  Widget _buildCardSection(bool isDark) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Credit/Debit Card",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const AddCardScreen(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 18,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Add Card",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildVisaCard(
                Colors.black,
                "4532",
                "ROOPA SMITH",
                "CREDIT CARD",
              ),
              _buildVisaCard(
                const Color(0xFF3DA384),
                "1234",
                "ROOPA SMITH",
                "DEBIT CARD",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVisaCard(
    Color bgColor,
    String lastFour,
    String name,
    String type,
  ) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.radio_button_checked,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        type,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: type == "DEBIT CARD"
                      ? SizedBox(
                          width: 50,
                          height: 30,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 14,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Image.asset(
                          "assets/images/visa.png",
                          width: 45,
                          color: Colors.white,
                          colorBlendMode: BlendMode.srcIn,
                        ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            "**** **** **** $lastFour",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "EXP",
                    style: TextStyle(color: Colors.white60, fontSize: 10),
                  ),
                  Text(
                    "14/07",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "CVV",
                    style: TextStyle(color: Colors.white60, fontSize: 10),
                  ),
                  Text(
                    "012",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- INPUT FIELD & BUTTON ---
  Widget _buildMinimalInputField(String hint, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextField(
        style: TextStyle(
          fontFamily: 'Poppins',
          color: isDark ? Colors.white : Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.grey,
            fontSize: 14,
          ),
          filled: true,
          fillColor: isDark ? const Color(0xFF1E1F28) : Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
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
    );
  }

  Widget _buildInlineContinueButton(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? Colors.white : Colors.black,
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ).copyWith(overlayColor: WidgetStateProperty.all(Colors.transparent)),
          child: Text(
            "Continue",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: isDark ? Colors.black : Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton(bool isDark) {
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
            "Continue",
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
          style: const ButtonStyle(
            splashFactory: NoSplash.splashFactory,
          ).copyWith(overlayColor: WidgetStateProperty.all(Colors.transparent)),
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
