import 'package:flutter/material.dart';
import '../../utils/wishlist_manager.dart';
import 'package:footflare/presentation/wishlist/widgets/wishlist_card.dart';
import 'package:footflare/presentation/search/search_page.dart';
import 'package:footflare/presentation/product_detail/product_detail_page.dart';
import 'package:footflare/presentation/main_screen.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final List<String> categories = ["All", "Child", "Man", "Woman", "Unisex"];
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return ListenableBuilder(
      listenable: WishlistManager.instance,
      builder: (context, _) {
        final allWishlist = WishlistManager.instance.items;
        final wishlistItems = allWishlist.where((p) {
          if (selectedCategory == "All") return true;
          return p.category.toLowerCase() == selectedCategory.toLowerCase();
        }).toList();

        return Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: AppBar(
            backgroundColor: colorScheme.surface,
            elevation: 0,
            leading: _buildHeaderIcon(
              Icons.arrow_back_ios_new,
              () {
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
              size: 16,
            ),
            title: Text(
              "Wishlist",
              style: TextStyle(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            centerTitle: true,
            actions: [
              _buildHeaderIcon(Icons.search, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              }),
              const SizedBox(width: 8),
            ],
          ),
          body: Column(
            children: [
              _buildCategoryBar(isDark, colorScheme),
              Expanded(
                child: wishlistItems.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white10
                                      : const Color(0xFFF7F7F7),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 48,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                allWishlist.isEmpty
                                    ? "Wishlist kamu masih kosong"
                                    : "Tidak ada produk di kategori $selectedCategory",
                                style: TextStyle(
                                  color: colorScheme.onSurface,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                allWishlist.isEmpty
                                    ? "Klik ikon love pada produk di Beranda untuk menyimpannya ke daftar ini."
                                    : "Coba ganti kategori lain di atas.",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if (allWishlist.isEmpty) ...[
                                const SizedBox(height: 24),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MainScreen(initialIndex: 0),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorScheme.primary,
                                    foregroundColor: isDark
                                        ? Colors.black
                                        : Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  icon: const Icon(Icons.shopping_bag_outlined,
                                      size: 18),
                                  label: const Text(
                                    "Jelajahi Beranda",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.55,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: wishlistItems.length,
                        itemBuilder: (context, index) {
                          final product = wishlistItems[index];
                          return WishlistCard(
                            name: product.name,
                            image: product.image,
                            price: product.price,
                            discount: product.discount,
                            discountBg: product.discountColor ??
                                (product.name.contains('Nova') ||
                                        product.discount.contains('20%')
                                    ? const Color(0xFFC70039)
                                    : Colors.black),
                            onRemove: () {
                              WishlistManager.instance.remove(
                                id: product.id,
                                name: product.name,
                                image: product.image,
                              );
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${product.name} dihapus dari Wishlist',
                                    style: const TextStyle(fontFamily: 'Poppins'),
                                  ),
                                  duration: const Duration(seconds: 1),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailPage(
                                    product: product.toMap(),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeaderIcon(IconData icon, VoidCallback onTap,
      {double size = 20}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          icon: Icon(icon,
              color: Theme.of(context).colorScheme.onSurface, size: size),
          onPressed: onTap,
        ),
      ),
    );
  }

  Widget _buildCategoryBar(bool isDark, ColorScheme colorScheme) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedCategory == categories[index];
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = categories[index]),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.primary
                    : (isDark ? Colors.white10 : const Color(0xFFF2F2F2)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: isSelected
                        ? (isDark ? Colors.black : Colors.white)
                        : colorScheme.onSurface,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
