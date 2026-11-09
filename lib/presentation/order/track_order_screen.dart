import 'package:flutter/material.dart';
import '../product_detail/product_detail_page.dart';

class TrackOrderScreen extends StatelessWidget {
  final Map<String, String> item;
  const TrackOrderScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1F28) : Colors.white,

      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1F28) : Colors.white,
        elevation: 0,
        leadingWidth: 52,
        centerTitle: true,
        leading: _buildHeaderButton(context, Icons.arrow_back_ios_new, isDark),
        title: Text(
          "Track Order",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductHeader(context, item, isDark),

            const SizedBox(height: 16),

            Divider(
              thickness: 1,
              color: isDark ? Colors.grey.shade800 : const Color(0xFFF3F3F3),
            ),

            const SizedBox(height: 24),

            Text(
              "Track order",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),

            const SizedBox(height: 24),

            _buildTimelineStep(
              "Order Placed",
              "We have received your order",
              "27 Dec 2023",
              true,
              false,
              isDark,
            ),
            _buildTimelineStep(
              "Order Confirm",
              "We has been confirmed",
              "27 Dec 2023",
              true,
              false,
              isDark,
            ),
            _buildTimelineStep(
              "Order Processed",
              "We are preparing your order",
              "28 Dec 2023",
              false,
              false,
              isDark,
            ),
            _buildTimelineStep(
              "Ready To Ship",
              "Your order is ready for shipping",
              "29 Dec 2023",
              false,
              false,
              isDark,
            ),
            _buildTimelineStep(
              "Out For Delivery",
              "Your order is out for delivery",
              "31 Dec 2023",
              false,
              true,
              isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderButton(BuildContext context, IconData icon, bool isDark) {
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

  Widget _buildTimelineStep(
    String title,
    String sub,
    String date,
    bool isDone,
    bool isLast,
    bool isDark,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone
                    ? const Color(0xFFB3261E)
                    : (isDark ? const Color(0xFF1E1F28) : Colors.white),
                border: Border.all(
                  color: isDone ? const Color(0xFFB3261E) : Colors.grey,
                ),
              ),
              child: isDone
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 50,
                color: isDone
                    ? const Color(0xFFB3261E)
                    : (isDark ? Colors.grey.shade700 : Colors.grey[300]),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: isDone
                          ? const Color(0xFFB3261E)
                          : (isDark ? Colors.white : Colors.black),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              Text(
                sub,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white70 : Colors.black,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
