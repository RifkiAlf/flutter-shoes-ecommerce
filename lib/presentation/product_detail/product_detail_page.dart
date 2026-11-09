import 'package:flutter/material.dart';
import '../order/cart_screen.dart';
import '../main_screen.dart'; // PASTIKAN IMPORT INI ADA
import '../../models/product_models.dart';
import '../../utils/wishlist_manager.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;
  int _selectedThumbnailIndex = 0;

  final List<String> _sizes = ['6.5', '7', '7.5', '8', '8.5', '9', '9.5'];

  final List<Color> _colors = [
    Colors.transparent,
    const Color(0xFF5C71D4),
    const Color(0xFFD4A05C),
    const Color(0xFF9E9E9E),
  ];

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.onSurface;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListenableBuilder(
      listenable: WishlistManager.instance,
      builder: (context, _) {
        final isFavorite = WishlistManager.instance.isFavorite(
          id: widget.product['id']?.toString(),
          name: widget.product['name']?.toString(),
          image: widget.product['image']?.toString(),
        );

        return Scaffold(
          backgroundColor: bgColor,

      // ================= APPBAR =================
      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.arrow_back_ios_new, size: 16, color: iconColor),
            ),
          ),
        ),

        title: Text(
          "Product Details",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: iconColor,
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CartScreen()),
                );
              },
              child: Container(
                width: 42,
                height: 42, // samakan tinggi
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  size: 18,
                  color: iconColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildImageGallery(),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product['name'],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Items Size:",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(_sizes.length, (index) {
                      final selected = _selectedSizeIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSizeIndex = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 45,
                          height: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selected
                                ? Colors.black
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _sizes[index],
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Description:",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "There are many variations of passages of Lorem Ipsum available.",
                    style: TextStyle(color: Colors.grey.shade600, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // ================= BOTTOM BAR =================
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.product['price'],
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Row(
                children: [
                  // LOVE BUTTON
                  GestureDetector(
                    onTap: () {
                      final prod = Product.fromMap(widget.product);
                      final isAdded = WishlistManager.instance.toggle(prod);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isAdded
                                ? '${widget.product['name']} ditambahkan ke Wishlist'
                                : '${widget.product['name']} dihapus dari Wishlist',
                            style: const TextStyle(fontFamily: 'Poppins'),
                          ),
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 180),
                      scale: isFavorite ? 1.08 : 1,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: isFavorite
                              ? const Color(0xFFFF375F)
                              : (isDark ? Colors.white10 : const Color(0xFFF2F2F2)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.favorite,
                          size: 18,
                          color: isFavorite
                              ? Colors.white
                              : (isDark ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // ADD TO CART
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(
                            initialIndex:
                                2, // Sesuaikan index Tab Cart kamu (biasanya 2 atau 3)
                          ),
                        ),
                        (route) => false,
                      );
                    },
                    child: Container(
                      height: 42,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Add To Cart",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
      },
    );
  }

  // ================= IMAGE =================
  Widget _buildImageGallery() {
    final List<String> thumbnails = [
      widget.product['image'],
      'assets/images/pic2.png',
      'assets/images/pic3.png',
      'assets/images/pic4.png',
    ];

    return Container(
      height: 420,
      width: double.infinity,
      color: Colors.grey.shade100,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              thumbnails[_selectedThumbnailIndex],
              fit: BoxFit.cover,
            ),
          ),

          // KEMBALIKAN PILIHAN WARNA
          Positioned(
            top: 20,
            left: 20,
            child: Column(
              children: List.generate(_colors.length, (index) {
                final selected = _selectedColorIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColorIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected ? Colors.black : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _colors[index] == Colors.transparent
                              ? const Color(0xFFDCDCDC)
                              : _colors[index],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          // THUMBNAIL BAWAH
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(thumbnails.length, (index) {
                final selected = _selectedThumbnailIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedThumbnailIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: selected ? Colors.red : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Image.asset(
                        thumbnails[index],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
