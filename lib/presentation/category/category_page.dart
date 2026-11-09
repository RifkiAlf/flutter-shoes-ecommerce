import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../main_screen.dart';
import 'product_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int selectedIndex = 0;

  final softColor = const Color(0xFFF6F6F6);
  final brandController = ScrollController();
  final categoryController = ScrollController();

  final brands = [
    {"name": "Nike", "image": "assets/logo_brand/nike_logo.png"},
    {"name": "Adidas", "image": "assets/logo_brand/adidas_logo.png"},
    {"name": "Reebok", "image": "assets/logo_brand/reebok_logo.png"},
    {"name": "Puma", "image": "assets/logo_brand/puma_logo.png"},
    {"name": "Bata", "image": "assets/logo_brand/bata_logo.png"},
  ];

  final categories = ["All", "Child", "Man", "Woman", "Unisex"];

  final collections = [
    {
      "title": "Woman",
      "items": "44 Items",
      "image": "assets/kategory/Woman.png",
      "color": Color(0xFFBE9D74),
    },
    {
      "title": "Man",
      "items": "84 Items",
      "image": "assets/kategory/Man.png",
      "color": Color(0xFFA77231),
    },
    {
      "title": "Child",
      "items": "30 Items",
      "image": "assets/kategory/Child.png",
      "color": Color(0xFF89A8C3),
    },
    {
      "title": "Fashion",
      "items": "40 Items",
      "image": "assets/kategory/Fashion.png",
      "color": Color(0xFFCEA990),
    },
  ];

  @override
  void dispose() {
    brandController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  void openProductPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProductPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF222431) : Colors.white,      

      appBar: _buildAppBar(isDark),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Top Brands", action: "View All"),
            const SizedBox(height: 18),
            _buildBrandList(),

            const SizedBox(height: 24),
            _sectionTitle("New Arrival"),
            const SizedBox(height: 14),
            _buildCategoryTabs(),

            const SizedBox(height: 24),
            _sectionTitle("Discover Latest Collection"),
            const SizedBox(height: 18),
            _buildGrid(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isDark) {
    return AppBar(
      backgroundColor: isDark ? const Color(0xFF222431) : Colors.white,      elevation: 0,
      centerTitle: true,
      leadingWidth: 52, // Sudah sama
      leading: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          // Margin disamakan ke 16 agar sejajar dengan cart_screen
          margin: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: isDark
              ? const Color(0xFF2A2D3A)
              : const Color(0xFFF3F3F3),
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
        "Category",
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 22,
          fontWeight: FontWeight
              .w700, // Kamu bisa sesuaikan w500/w700 agar konsisten dengan cart
          color: isDark ? Colors.white : Colors.black,        
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: 16,
          ), // Disamakan ke 16 agar simetris dengan leading
          child: _iconBox(Icons.search, isDark),
        ),
      ],
    );
  }

  Widget _iconBox(IconData icon, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isDark
            ? const Color(0xFF2A2D3A)
            : softColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 18, color: Colors.black),
      ),
    );
  }

  Widget _sectionTitle(String title, {String? action}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (action != null)
          Text(
            action,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
      ],
    );
  }

  Widget _buildBrandList() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 110,
      child: _scrollConfig(
        ListView.builder(
          controller: brandController,
          scrollDirection: Axis.horizontal,
          itemCount: brands.length,
          itemBuilder: (_, i) {
            final item = brands[i];

            return GestureDetector(
              onTap: openProductPage,
              child: Container(
                margin: const EdgeInsets.only(right: 14),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 66,
                      height: 66,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark ? Colors.white24 : Colors.black12,
                        ),
                      ),
                      child: Image.asset(
                        item["image"]!,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item["name"]!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return SizedBox(
      height: 44,
      child: _scrollConfig(
        ListView.builder(
          controller: categoryController,
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (_, i) {
            return _HoverItem(
              text: categories[i],
              active: selectedIndex == i,
              softColor: softColor,
              onTap: () => setState(() => selectedIndex = i),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: collections.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.82,
      ),
      itemBuilder: (_, i) {
        final item = collections[i];

        return GestureDetector(
          onTap: openProductPage,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF2A2D3A)
                : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                    child: Image.asset(
                      item["image"] as String,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: item["color"] as Color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "${item["title"]} (${item["items"]})",
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _scrollConfig(Widget child) {
    return ScrollConfiguration(
      behavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
      ),
      child: child,
    );
  }
}

class _HoverItem extends StatefulWidget {
  final String text;
  final bool active;
  final Color softColor;
  final VoidCallback onTap;

  const _HoverItem({
    required this.text,
    required this.active,
    required this.softColor,
    required this.onTap,
  });

  @override
  State<_HoverItem> createState() => _HoverItemState();
}

class _HoverItemState extends State<_HoverItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final dark = widget.active || isHover;

    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: dark ? Colors.black : widget.softColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: dark ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
