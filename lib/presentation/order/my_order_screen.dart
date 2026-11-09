import 'package:flutter/material.dart';
import 'track_order_screen.dart';
import 'write_review_screen.dart';
import 'package:footflare/presentation/main_screen.dart';
import 'package:footflare/presentation/product_detail/product_detail_page.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  bool isOngoingSelected = true;

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
        leading: MouseRegion(
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
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                splashFactory: NoSplash.splashFactory,
              ),
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: isDark ? Colors.white : Colors.black,
                size: 18,
              ),
            ),
          ),
        ),
        title: Text(
          "My Order",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              margin: const EdgeInsets.only(right: 16, top: 10, bottom: 10),
              width: 36,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF2A2D3A)
                    : const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                    (route) => false,
                  );
                },
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                ),
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.home_filled,
                  color: isDark ? Colors.white : Colors.black,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: _buildTabButton("Ongoing", isOngoingSelected, () {
                    setState(() => isOngoingSelected = true);
                  }, isDark),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTabButton("Completed", !isOngoingSelected, () {
                    setState(() => isOngoingSelected = false);
                  }, isDark),
                ),
              ],
            ),
          ),
        ),
      ),

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: OrderList(
          key: ValueKey<bool>(isOngoingSelected),
          isOngoing: isOngoingSelected,
        ),
      ),
    );
  }

  Widget _buildTabButton(
    String label,
    bool isActive,
    VoidCallback onTap,
    bool isDark,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive
                ? Colors.black
                : (isDark ? const Color(0xFF1E1F28) : Colors.white),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isDark ? Colors.white : Colors.black,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isActive
                  ? Colors.white
                  : (isDark ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  final bool isOngoing;
  const OrderList({super.key, required this.isOngoing});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, String>> dummyOrders = [
      {
        "name": "Echo Vibe Urban Runners",
        "price": "179",
        "image": "assets/images/pic6.png",
      },
      {
        "name": "Swift Glide Sprinter Soles",
        "price": "199",
        "image": "assets/images/pic2.png",
      },
      {
        "name": "Zen Dash Active Flex Shoes",
        "price": "299",
        "image": "assets/images/pic3.png",
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: dummyOrders.length,
      separatorBuilder: (context, index) => Divider(
        height: 40,
        thickness: 2,
        color: isDark
            ? Colors.grey.shade800
            : const Color.fromARGB(255, 223, 223, 223),
      ),
      itemBuilder: (context, index) {
        final item = dummyOrders[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
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
                  );
                },
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
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
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
                  const SizedBox(height: 4),
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
                  const SizedBox(height: 8),

                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isOngoing) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TrackOrderScreen(item: item),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WriteReviewScreen(item: item),
                            ),
                          );
                        }
                      },
                      style:
                          ElevatedButton.styleFrom(
                            backgroundColor: isDark
                                ? const Color(0xFF2A2D3A)
                                : const Color(0xFFF3F3F3),
                            foregroundColor: isDark
                                ? Colors.white
                                : Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ).copyWith(
                            overlayColor:
                                WidgetStateProperty.resolveWith<Color?>(
                                  (states) =>
                                      states.contains(WidgetState.hovered)
                                      ? (isDark
                                            ? Colors.white.withOpacity(0.1)
                                            : Colors.black.withOpacity(0.05))
                                      : null,
                                ),
                          ),
                      child: Text(isOngoing ? "Track Order" : "Write Review"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
