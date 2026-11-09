import 'package:flutter/material.dart';
import 'widgets/cart_item_card.dart';
import 'checkout_screen.dart';
import 'package:footflare/presentation/main_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  List<Map<String, dynamic>> cartItems = [
    {
      "name": "Echo Vibe Urban Runners",
      "price": 179,
      "qty": 1,
      "image": "assets/images/pic6.png",
    },
    {
      "name": "Swift Glide Sprinter Soles",
      "price": 199,
      "qty": 1,
      "image": "assets/images/pic2.png",
    },
    {
      "name": "Zen Dash Active Flex Shoes",
      "price": 150,
      "qty": 1,
      "image": "assets/images/pic3.png",
    },
  ];

  void _removeItem(int index) {
    final removedItem = cartItems[index];

    _listKey.currentState!.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: FadeTransition(
          opacity: animation,
          child: CartItemCard(
            name: removedItem['name'],
            price: "\$${removedItem['price']}",
            imagePath: removedItem['image'],
            quantity: removedItem['qty'],
            onAdd: () {},
            onRemove: () {},
            onDelete: () {},
          ),
        ),
      ),
      duration: const Duration(milliseconds: 300),
    );

    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    int subtotal = cartItems.fold(
      0,
      (sum, item) => sum + (item['price'] * item['qty'] as int),
    );

    return Scaffold(
      // ✅ hanya ini diubah
      backgroundColor: isDark ? const Color(0xFF1E1F28) : Colors.white,

      appBar: AppBar(
        // ✅ ini juga
        backgroundColor: isDark ? const Color(0xFF1E1F28) : Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 52,

        // Cari bagian leading di AppBar, lalu ubah onPressed-nya:
        leading: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            margin: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {
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
          "My Cart",
          style: TextStyle(
            fontFamily: 'Poppins',
            // ✅ ini
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
                // ✅ ini
                color: isDark
                    ? const Color(0xFF2A2D3A)
                    : const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {},
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                ),
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.location_on_outlined,
                  // ✅ ini
                  color: isDark ? Colors.white : Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      // ✅ ini
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 20,
                    ),
                    children: [
                      const TextSpan(text: "Subtotal "),
                      TextSpan(
                        text: "\$$subtotal",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          // ✅ ini
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Your order is eligible for free Delivery",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ✅ divider sedikit disesuaikan
          Divider(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),

          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: cartItems.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index, animation) {
                final item = cartItems[index];

                return CartItemCard(
                  key: ValueKey(item['name']),
                  name: item['name'],
                  price: "\$${item['price']}",
                  imagePath: item['image'],
                  quantity: item['qty'],
                  onAdd: () => setState(() => item['qty']++),
                  onRemove: () => setState(() {
                    if (item['qty'] > 1) item['qty']--;
                  }),
                  onDelete: () => _removeItem(index),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          CheckoutScreen(items: cartItems),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                style:
                    ElevatedButton.styleFrom(
                      // ✅ ini
                      backgroundColor: isDark ? Colors.white : Colors.black,
                      minimumSize: const Size(double.infinity, 60),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledMouseCursor: SystemMouseCursors.click,
                    ).copyWith(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                    ),
                child: Text(
                  "Proceed to Buy (${cartItems.length} Items)",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    // ✅ ini
                    color: isDark ? Colors.black : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
