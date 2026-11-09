import 'package:flutter/material.dart';
import '../main_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int selectedCategory = 0;

  final List<String> cats = ['All', 'Child', 'Man', 'Woman', 'Unisex'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white : Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: isDark ? Colors.black : Colors.white,
                        size: 20,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Best items for You',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 16),

              _buildCategories(context, isDark),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Search History',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Clear All',
                    style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Expanded(
                child: ListView(
                  children: [
                    _buildHistoryItem(context, 'Woman Fashion Shoes'),
                    _buildHistoryItem(context, 'Man Shoes'),
                    _buildHistoryItem(context, 'Girl Shoes'),
                    _buildHistoryItem(context, 'Shorts Shoes'),
                    _buildHistoryItem(context, 'Shorts'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context, bool isDark) {
    return SizedBox(
      height: 42,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cats.length,
        itemBuilder: (context, index) {
          return _HoverCategoryItem(
            text: cats[index],
            active: selectedCategory == index,
            onTap: () {
              setState(() {
                selectedCategory = index;
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

  Widget _buildHistoryItem(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const Icon(Icons.close, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}

class _HoverCategoryItem extends StatefulWidget {
  final String text;
  final bool active;
  final VoidCallback onTap;

  const _HoverCategoryItem({
    required this.text,
    required this.active,
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
      onEnter: (_) {
        setState(() {
          hover = true;
        });
      },
      onExit: (_) {
        setState(() {
          hover = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: active ? Colors.black : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                color: active ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
