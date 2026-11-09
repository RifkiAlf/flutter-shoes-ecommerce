import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// --- Import Halaman Tujuan ---
import 'package:footflare/presentation/main_screen.dart';
import 'package:footflare/presentation/order/my_order_screen.dart';
import 'package:footflare/presentation/wishlist/wishlist_page.dart';
import 'package:footflare/presentation/order/track_order_screen.dart';
import 'package:footflare/presentation/order/payment_screen.dart';
import 'package:footflare/presentation/order/add_address_screen.dart';
import 'package:footflare/presentation/notification/notification_page.dart';
import 'package:footflare/presentation/search/search_page.dart';

// --- Komponen Pendukung Lainnya ---
import 'package:footflare/presentation/profile/language_modal.dart';
import 'package:footflare/presentation/profile/write_review_page.dart';
import 'package:footflare/presentation/profile/faq_page.dart';
import 'package:footflare/presentation/profile/coupons_page.dart';

class FootFlareProfile extends StatefulWidget {
  const FootFlareProfile({super.key});

  @override
  State<FootFlareProfile> createState() => _FootFlareProfileState();
}

class _FootFlareProfileState extends State<FootFlareProfile> {
  String selectedLanguage = "Select Language";

  @override
  Widget build(BuildContext context) {
    // Deteksi Mode Gelap
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final scaffoldBg = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: scaffoldBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
          child: GestureDetector(
            onTap: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(initialIndex: 0),
                  ),
                  (route) => false,
                );
              }
            },
            child: _buildSquareButton(
              context,
              Icons.arrow_back_ios_new,
              size: 18,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: textColor,
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              ),
              child: _buildSquareButton(context, Icons.search, size: 22),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/wajahAmel.png'),
                ),
                const SizedBox(width: 15),
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      color: textColor,
                      fontFamily: 'Poppins',
                    ),
                    children: [
                      const TextSpan(text: "Hello, "),
                      const TextSpan(
                        text: "Amelia",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // --- Tombol Navigasi Cepat ---
            Row(
              children: [
                Expanded(
                  child: _buildUpperButton(
                    context,
                    "Your Order",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyOrderScreen(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildUpperButton(
                    context,
                    "Wishlist",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WishlistPage(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildUpperButton(
                    context,
                    "Coupons",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CouponsPage(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildUpperButton(
                    context,
                    "Track Order",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TrackOrderScreen(
                          item: {
                            'name': 'Swift Glide Sprinter Soles',
                            'price': '199',
                            'image': 'assets/images/pic1.png',
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 35),
            Text(
              "Account Settings",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),

            _buildMenuTile(
              context,
              Icons.person_outline,
              "Edit Profile",
              isEditProfile: true,
            ),

            _buildMenuTile(
              context,
              Icons.account_balance_wallet_outlined,
              "Saved Cards & Wallet",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PaymentScreen()),
              ),
            ),

            _buildMenuTile(
              context,
              Icons.location_on_outlined,
              "Saved Addresses",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddAddressScreen(),
                ),
              ),
            ),

            _buildMenuTile(
              context,
              Icons.translate,
              selectedLanguage,
              isLanguage: true,
            ),

            _buildMenuTile(
              context,
              Icons.notifications_none_outlined,
              "Notifications Settings",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationPage(),
                ),
              ),
            ),

            const SizedBox(height: 25),
            Text(
              "My Activity",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),
            _buildMenuTile(context, Icons.star_outline, "Reviews"),
            _buildMenuTile(context, Icons.message_outlined, "FAQ"),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareButton(
    BuildContext context,
    IconData icon, {
    double size = 20,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(
        icon,
        color: isDark ? Colors.white : Colors.black,
        size: size,
      ),
    );
  }

  Widget _buildUpperButton(
    BuildContext context,
    String label, {
    VoidCallback? onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            fontFamily: 'Poppins',
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuTile(
    BuildContext context,
    IconData icon,
    String title, {
    bool isEditProfile = false,
    bool isLanguage = false,
    VoidCallback? onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: textColor, size: 24),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          color: textColor,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 14, color: textColor),
      onTap: onTap ??
          () {
            if (isEditProfile) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfilePage(),
                ),
              );
            } else if (isLanguage) {
              LanguageModal.show(
                context,
                (val) => setState(() => selectedLanguage = val),
              );
            } else if (title == "Reviews") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WriteReviewPage(),
                ),
              );
            } else if (title == "FAQ") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FaqPage()),
              );
            }
          },
    );
  }
}

// --- Halaman Edit Profile ---
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) setState(() => _imageFile = File(pickedFile.path));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final scaffoldBg = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: scaffoldBg,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: textColor,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.arrow_back_ios_new, size: 18, color: textColor),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : const AssetImage('assets/images/wajahAmel.png') as ImageProvider,
                        ),
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: isDark ? Colors.white : Colors.black,
                            child: Icon(
                              Icons.camera_alt,
                              color: isDark ? Colors.black : Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildOutlineField(context, Icons.person_outline, "Full Name", "Amelia"),
                  const SizedBox(height: 15),
                  _buildOutlineField(context, Icons.mail_outline, "Email", ""),
                  const SizedBox(height: 15),
                  _buildOutlineField(context, Icons.phone_outlined, "Phone Number", ""),
                  const SizedBox(height: 15),
                  _buildOutlineField(context, Icons.location_on_outlined, "Location", ""),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? Colors.white : Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  "Update Profile",
                  style: TextStyle(
                    color: isDark ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutlineField(BuildContext context, IconData icon, String label, String initialValue) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            SizedBox(width: 50, child: Icon(icon, color: textColor, size: 22)),
            VerticalDivider(
              width: 1,
              thickness: 1,
              color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextFormField(
                  initialValue: initialValue,
                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: textColor),
                  decoration: InputDecoration(
                    labelText: label,
                    labelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}