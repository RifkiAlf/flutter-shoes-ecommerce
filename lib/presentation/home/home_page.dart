import 'package:flutter/material.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/side_drawer.dart';
import 'widgets/promo_banner.dart';
import 'widgets/brand_list.dart';
import 'widgets/product_grid.dart';
import '../main_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedCategory = 0;

  final List<String> cats = [
    'All',
    'Child',
    'Man',
    'Woman',
    'Unisex'
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      drawer: const SideDrawer(),
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: _buildSearchBar(context, isDark),
            ),

            const SizedBox(height: 4), 

            const PromoBanner(),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(context, 'Top Brands', 'View All'),

                  const SizedBox(height: 16),

                  const BrandList(),

                  const SizedBox(height: 16),

                  _buildSectionTitle(context, 'New Arrival', ''),

                  const SizedBox(height: 16),

                  _buildCategories(context, isDark),

                  const SizedBox(height: 20),

                  const ProductGrid(),
                  
                  const SizedBox(height: 30), 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context, bool isDark) {
    return SizedBox(
      height: 40, // Diperkecil tinggi kotaknya agar lebih slim sesuai referensi
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cats.length,
        itemBuilder: (context, i) {
          return _HoverCategoryItem(
            text: cats[i],
            active: selectedCategory == i,
            isDark: isDark,
            onTap: () {
              setState(() {
                selectedCategory = i;
              });

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const MainScreen(initialIndex: 3),
                ),
                (route) => false,
              );
            },            
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isDark) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: TextField(
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
              decoration: InputDecoration(
                hintText: 'Search Product',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500, // Diperjelas warnanya agar lebih terbaca (awalnya shade400)
                  fontSize: 15,
                  fontFamily: 'Poppins',
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                filled: true,
                fillColor: isDark ? const Color(0xFF2A2D3A) : Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDark ? const Color.fromARGB(255, 49, 49, 49) : Colors.grey.shade400, // Dipertegas garisnya (awalnya shade300)
                    width: 1.0 
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDark ? Colors.white54 : Colors.black87, 
                    width: 1.0
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: isDark ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.tune, 
            color: isDark ? Colors.black : Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20, 
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        if (action.isNotEmpty)
          Text(
            action,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
      ],
    );
  }
}

class _HoverCategoryItem extends StatefulWidget {
  final String text;
  final bool active;
  final bool isDark;
  final VoidCallback onTap;

  const _HoverCategoryItem({
    required this.text,
    required this.active,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_HoverCategoryItem> createState() => _HoverCategoryItemState();
}

class _HoverCategoryItemState extends State<_HoverCategoryItem> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.active || hover;

    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(
            horizontal: 20, // Diperkecil sedikit agar tidak terlalu memanjang
            vertical: 8,    // Diperkecil agar lebih ramping
          ),
          decoration: BoxDecoration(
            color: active ? Colors.black : (widget.isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF5F5F5)),
            borderRadius: BorderRadius.circular(10), // Sudut tidak terlalu membulat
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14, // Diperkecil kembali ke 14
                color: active ? Colors.white : (widget.isDark ? Colors.white70 : Colors.black87),
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}