import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/product_action_sheet.dart';
import '../product_detail/product_detail_page.dart';
import '../main_screen.dart';
import '../../models/product_models.dart';
import '../../utils/wishlist_manager.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with TickerProviderStateMixin {
  // --- STATE UTAMA ---
  int selectedIndex = 0;
  int selectedGender = 0;
  int selectedSort = 0;
  bool isListView = false;

  // State Filter Multi-select
  List<String> selectedBrands = [];
  List<String> selectedCategories = ["Heels", "Boots"];
  List<String> selectedSizes = ["6.5", "7.5"];
  RangeValues priceRange = const RangeValues(50, 200);

  // State Kontrol Popup
  bool isPopupOpen = false;
  String currentActiveMenu = "";
  String popupTitle = "";
  double popupHeight = 0;
  Widget? popupContent;

  final Color softColor = const Color(0xFFF6F6F6);

  // Animasi Popup
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  // --- DATA PRODUK LENGKAP ---
  final List<Map<String, dynamic>> items = [
    {
      "id": "1",
      "name": "Swift Glide Sprinter Soles",
      "price": "\$199",
      "image": "assets/product/pic1.png",
      "sale": "30% OFF",
      "black": true,
      "fav": false,
      "category": "Man",
    },
    {
      "id": "2",
      "name": "Echo Vibe Urban Runners",
      "price": "\$149",
      "image": "assets/product/pic2.png",
      "sale": "",
      "black": false,
      "fav": false,
      "category": "Woman",
    },
    {
      "id": "3",
      "name": "Zen Dash Active Flex Shoes",
      "price": "\$299",
      "image": "assets/product/pic3.png",
      "sale": "",
      "black": false,
      "fav": false,
      "category": "Unisex",
    },
    {
      "id": "4",
      "name": "Nova Stride Street Stompers",
      "price": "\$99",
      "image": "assets/product/pic4.png",
      "sale": "30% OFF",
      "black": false,
      "fav": false,
      "category": "Child",
    },
    {
      "id": "5",
      "name": "Evo Quip Evo Quick Strides",
      "price": "\$199",
      "image": "assets/product/pic5.png",
      "sale": "30% OFF",
      "black": true,
      "fav": false,
      "category": "Man",
    },
    {
      "id": "6",
      "name": "Urban Kicks Classic",
      "price": "\$84",
      "image": "assets/product/pic6.png",
      "sale": "20% OFF",
      "black": false,
      "fav": false,
      "category": "Woman",
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // --- LOGIKA POPUP ---
  void _handleMenuTap(String menuType) {
    if (isPopupOpen && currentActiveMenu == menuType) {
      _closePopup();
      return;
    }
    if (isPopupOpen) {
      _animationController.reverse().then((_) {
        setState(() {
          currentActiveMenu = menuType;
          _preparePopupContent(menuType);
        });
        _animationController.forward();
      });
    } else {
      setState(() {
        currentActiveMenu = menuType;
        _preparePopupContent(menuType);
        isPopupOpen = true;
      });
      _animationController.forward();
    }
  }

  void _preparePopupContent(String type) {
    if (type == "GENDER") {
      popupTitle = "Gender";
      popupHeight = 220;
      popupContent = _buildGenderContent();
    } else if (type == "SORT") {
      popupTitle = "Sort By";
      popupHeight = 310;
      popupContent = _buildSortContent();
    } else if (type == "FILTER") {
      popupTitle = "Filters";
      popupHeight = 780;
      popupContent = _buildFilterContent();
    }
  }

  void _closePopup() {
    _animationController.reverse().then((_) {
      setState(() {
        isPopupOpen = false;
        currentActiveMenu = "";
      });
    });
  }

  // --- POPUP CONTENT BUILDERS ---
  Widget _buildGenderContent() {
    return StatefulBuilder(
      builder: (context, setPS) {
        return Row(
          children: [
            ActionChipBtn(
              text: "Male",
              active: selectedGender == 0,
              onTap: () {
                setPS(() => selectedGender = 0);
                setState(() {});
              },
            ),
            const SizedBox(width: 12),
            ActionChipBtn(
              text: "Female",
              active: selectedGender == 1,
              onTap: () {
                setPS(() => selectedGender = 1);
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSortContent() {
    final list = [
      "Relevance",
      "Popularity",
      "Price - Low to High",
      "Price - High to Low",
      "Newest First",
    ];
    return StatefulBuilder(
      builder: (context, setPS) {
        return Wrap(
          spacing: 12,
          runSpacing: 14,
          children: List.generate(
            list.length,
            (i) => ActionChipBtn(
              text: list[i],
              active: selectedSort == i,
              onTap: () {
                setPS(() => selectedSort = i);
                setState(() {});
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterContent() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return StatefulBuilder(
      builder: (context, setPS) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _filterHeader("Top Brands", "View All"),
            const SizedBox(height: 12),
            SizedBox(
              height: 95,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _brandItem("Nike", "assets/logo_brand/nike_logo.png", setPS),
                  _brandItem(
                    "Adidas",
                    "assets/logo_brand/adidas_logo.png",
                    setPS,
                  ),
                  _brandItem(
                    "Reebok",
                    "assets/logo_brand/reebok_logo.png",
                    setPS,
                  ),
                  _brandItem("Puma", "assets/logo_brand/puma_logo.png", setPS),
                  _brandItem("Bata", "assets/logo_brand/bata_logo.png", setPS),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _filterHeader("Categories:", "See All"),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 10,
              children:
                  [
                        "All",
                        "Heels",
                        "Boots",
                        "Loafers",
                        "Monk",
                        "Sandals",
                        "Court Shoe",
                        "Outdoor",
                        "Formal",
                      ]
                      .map(
                        (e) => _multiSelectChip(e, selectedCategories, setPS),
                      )
                      .toList(),
            ),
            const SizedBox(height: 24),
            _filterHeader("Size:", "See All"),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                "6.5",
                "7",
                "7.5",
                "8",
                "8.5",
              ].map((e) => _multiSelectChip(e, selectedSizes, setPS)).toList(),
            ),
            const SizedBox(height: 24),
            const Text(
              "Price:",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            Row(
              children: [
                _priceBox("\$${priceRange.start.round()}", isDark),
                const SizedBox(width: 10),
                _priceBox("\$${priceRange.end.round()}", isDark),
              ],
            ),
            RangeSlider(
              values: priceRange,
              max: 300,
              divisions: 300,
              activeColor: Colors.black,
              inactiveColor: Colors.black12,
              onChanged: (val) => setPS(() => priceRange = val),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: _actionBtn(
                    "Reset",
                    Colors.transparent,
                    Colors.black,
                    () {
                      setPS(() {
                        selectedBrands.clear();
                        selectedCategories.clear();
                        selectedSizes.clear();
                        priceRange = const RangeValues(0, 300);
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _actionBtn(
                    "Apply",
                    Colors.black,
                    Colors.white,
                    _closePopup,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // --- UI COMPONENTS ---
  Widget _filterHeader(String title, String action) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      Text(
        action,
        style: const TextStyle(
          fontFamily: 'Poppins',
          decoration: TextDecoration.underline,
          fontSize: 12,
        ),
      ),
    ],
  );

  Widget _brandItem(String name, String img, StateSetter setPS) {
    bool isSelected = selectedBrands.contains(name);
    return GestureDetector(
      onTap: () => setPS(
        () =>
            isSelected ? selectedBrands.remove(name) : selectedBrands.add(name),
      ),
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.black : Colors.white,
                border: Border.all(
                  color: isSelected ? Colors.black : Colors.black12,
                ),
              ),
              child: Center(
                child: isSelected
                    ? ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(
                          img,
                          width: 32,
                          errorBuilder: (c, e, s) =>
                              const Icon(Icons.broken_image, size: 20),
                        ),
                      )
                    : Image.asset(
                        img,
                        width: 32,
                        errorBuilder: (c, e, s) =>
                            const Icon(Icons.broken_image, size: 20),
                      ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              name,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _multiSelectChip(String label, List<String> list, StateSetter setPS) {
    bool isSelected = list.contains(label);
    return ActionChipBtn(
      text: label,
      active: isSelected,
      onTap: () =>
          setPS(() => isSelected ? list.remove(label) : list.add(label)),
    );
  }

  Widget _priceBox(String text, bool isDark) => Container(
    margin: const EdgeInsets.only(top: 8),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: isDark
        ? const Color(0xFF2A2D3A)
        : softColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      text,
      style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
    ),
  );

  Widget _actionBtn(
    String t,
    Color bg,
    Color txt,
    VoidCallback onTap,
  ) => ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      backgroundColor: bg,
      foregroundColor: txt,
      elevation: 0,
      side: BorderSide(
        color: bg == Colors.transparent ? Colors.black12 : Colors.transparent,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      minimumSize: const Size(double.infinity, 50),
    ),
    child: Text(
      t,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    ),
  );

@override
Widget build(BuildContext context) {
  final isDark =
      Theme.of(context).brightness == Brightness.dark;

  final width = MediaQuery.of(context).size.width;
  const double bottomBarHeight = 58.0;

  return Scaffold(
    backgroundColor:
        isDark ? const Color(0xFF222431) : Colors.white,

    body: Stack(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              14,
              14,
              14,
              bottomBarHeight + 20,
            ),
            child: Column(
              children: [
                _buildTopBar(isDark),

                const SizedBox(height: 16),

                _buildTabs(isDark),

                const SizedBox(height: 14),

                isListView
                    ? _buildProductList(isDark)
                    : _buildProductGrid(
                        width,
                        isDark,
                      ),
              ],
            ),
          ),
        ),

        if (isPopupOpen)
          GestureDetector(
            onTap: _closePopup,
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Container(
                  color: Colors.black.withOpacity(
                    _fadeAnimation.value,
                  ),
                );
              },
            ),
          ),

        if (isPopupOpen)
          AnimatedBuilder(
            animation: _slideAnimation,
            builder: (context, child) {
              return Positioned(
                left: 0,
                right: 0,
                bottom:
                    bottomBarHeight +
                    ((popupHeight -
                                bottomBarHeight) *
                            (_slideAnimation.value -
                                1)),
                child: _buildPopupUI(
                  popupHeight,
                  isDark,
                ),
              );
            },
          ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child:
              ProductActionSheet.bottomMenu(
            onGenderTap: () =>
                _handleMenuTap("GENDER"),
            onSortTap: () =>
                _handleMenuTap("SORT"),
            onFilterTap: () =>
                _handleMenuTap("FILTER"),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPopupUI(
  double height,
  bool isDark,
) {
  double maxHeight =
      MediaQuery.of(context).size.height *
          0.85;

  return Material(
    color: Colors.transparent,
    child: Container(
      height:
          height > maxHeight
              ? maxHeight
              : height,

      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF2B2E3D)
            : Colors.white,

        borderRadius:
            const BorderRadius.vertical(
          top: Radius.circular(32),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.35,
            ),
            blurRadius: 18,
            offset: const Offset(
              0,
              -4,
            ),
          ),
        ],
      ),

      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.fromLTRB(
              24,
              16,
              16,
              8,
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
              children: [
                Text(
                  popupTitle,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                    fontWeight:
                        FontWeight.w600,
                    color:
                        isDark
                            ? Colors.white
                            : Colors.black,
                  ),
                ),

                IconButton(
                  onPressed:
                      _closePopup,
                  icon: Icon(
                    Icons.close,
                    size: 24,
                    color:
                        isDark
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
              ],
            ),
          ),

          Divider(
            height: 1,
            color:
                isDark
                    ? Colors.white12
                    : Colors.black12,
          ),

          Expanded(
            child:
                SingleChildScrollView(
              physics:
                  const BouncingScrollPhysics(),
              padding:
                  const EdgeInsets.all(
                24,
              ),
              child:
                  popupContent ??
                  const SizedBox(),
            ),
          ),
        ],
      ),
    ),
  );
}

  // --- REUSABLE PRODUCT UI ---
Widget _buildTopBar(bool isDark) => Row(
  children: [
    _iconBtn(
      "assets/icon/kembali.svg",
      () => Navigator.pop(context),
      isDark,
    ),

    const SizedBox(width: 8),

    Expanded(
      child: _searchField(isDark),
    ),

    const SizedBox(width: 10),

    GestureDetector(
      onTap: () {
        setState(() {
          isListView = !isListView;
        });
      },
      child: SvgPicture.asset(
        isListView
            ? "assets/icon/layoutgrid.svg"
            : "assets/icon/menu.svg",
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          isDark
              ? Colors.white
              : Colors.black,
          BlendMode.srcIn,
        ),
      ),
    ),

    const SizedBox(width: 10),

    _cartIcon(isDark),
  ],
);

// BACK BUTTON
// ==========================
Widget _iconBtn(
  String path,
  VoidCallback onTap,
  bool isDark,
) =>
    InkWell(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF2A2D3A)
              : softColor,
          borderRadius:
              BorderRadius.circular(10),
        ),
        child: Padding(
          padding:
              const EdgeInsets.all(9),
          child: SvgPicture.asset(
            path,
            colorFilter:
                ColorFilter.mode(
              isDark
                  ? Colors.white
                  : Colors.black,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
    
// SEARCH FIELD
// ==========================
Widget _searchField(bool isDark) =>
    Container(
      height: 36,
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF2A2D3A)
            : Colors.white,
        borderRadius:
            BorderRadius.circular(8),
        border: Border.all(
          color: isDark
              ? Colors.white24
              : Colors.black12,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 18,
            color: isDark
                ? Colors.white70
                : Colors.black54,
          ),
          const SizedBox(width: 8),
          Text(
            "Search Products",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: isDark
                  ? Colors.white70
                  : Colors.black54,
            ),
          ),
        ],
      ),
    );

// CART ICON
// ==========================
Widget _cartIcon(bool isDark) =>
    GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const MainScreen(
              initialIndex: 2,
            ),
          ),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SvgPicture.asset(
            "assets/icon/keranjang.svg",
            width: 24,
            height: 24,
            colorFilter:
                ColorFilter.mode(
              isDark
                  ? Colors.white
                  : Colors.black,
              BlendMode.srcIn,
            ),
          ),

          Positioned(
            right: -4,
            top: -5,
            child: Container(
              width: 16,
              height: 16,
              decoration:
                  const BoxDecoration(
                color: Colors.red,
                shape:
                    BoxShape.circle,
              ),
              child:
                  const Center(
                child: Text(
                  "14",
                  style:
                      TextStyle(
                    color:
                        Colors.white,
                    fontSize: 8,
                    fontWeight:
                        FontWeight
                            .bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

  Widget _buildProductGrid(double width, bool isDark) => Expanded(
    child: ListenableBuilder(
      listenable: WishlistManager.instance,
      builder: (context, _) => GridView.builder(
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 14,
          childAspectRatio: width < 380 ? 0.61 : 0.64,
        ),
        itemBuilder: (context, index) {
          final i = Map<String, dynamic>.from(items[index]);
          i["fav"] = WishlistManager.instance.isFavorite(
            id: i["id"],
            name: i["name"],
            image: i["image"],
          );
          return _ProductItemCard(
            item: i,
            onFavToggle: () {
              final prod = Product.fromMap(i);
              WishlistManager.instance.toggle(prod);
            },
          );
        },
      ),
    ),
  );

  Widget _buildProductList(bool isDark) => Expanded(
    child: ListenableBuilder(
      listenable: WishlistManager.instance,
      builder: (context, _) => ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final i = Map<String, dynamic>.from(items[index]);
          final isFav = WishlistManager.instance.isFavorite(
            id: i["id"],
            name: i["name"],
            image: i["image"],
          );
          i["fav"] = isFav;

        return StatefulBuilder(
          builder: (context, setLocal) {
            bool animate = false;

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailPage(product: i),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.black12),
                ),
                child: Row(
                  children: [
                    // ======================
                    // IMAGE + LOVE
                    // ======================
                    Stack(
                      children: [
                        Container(
                          width: 125,
                          height: 125,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6F6F6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: OverflowBox(
                            maxWidth: 180,
                            maxHeight: 180,
                            child: Transform.scale(
                              scale: 0.8,
                              child: Image.asset(
                                i["image"],
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 8,
                          left: 8,
                          child: GestureDetector(
                            onTap: () {
                              setLocal(() {
                                animate = true;
                              });

                              final prod = Product.fromMap(i);
                              WishlistManager.instance.toggle(prod);

                              Future.delayed(
                                const Duration(milliseconds: 180),
                                () {
                                  if (mounted) {
                                    setLocal(() {
                                      animate = false;
                                    });
                                  }
                                },
                              );
                            },
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 1, end: isFav ? 1.35 : 1),
                              duration: const Duration(milliseconds: 220),
                              curve: Curves.easeOutBack,
                              builder: (context, value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: child,
                                );
                              },
                              child: Icon(
                                isFav
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFav
                                    ? Colors.red
                                    : Colors.grey.shade400,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 12),

                    // ======================
                    // INFO
                    // ======================
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 8,
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Text(
                              i["name"],
                              maxLines: 2,
                              overflow:
                                  TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              i["price"],
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 28,
                                fontWeight:
                                    FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),

                            const SizedBox(height: 4),

                            const Text(
                              "FREE Delivery",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 2),

                            Text(
                              i["sale"] == ""
                                  ? "40% OFF"
                                  : i["sale"],
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight:
                                    FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ),
  ),
  );

  Widget _buildTabs(bool isDark) => SizedBox(
    height: 38,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      itemBuilder: (context, index) {
        final t = [
          "Crazy Deals",
          "Budget Buys",
          "Best Offer",
          "Trending",
          "Sneakers",
          "New Arrival",
        ];
        return _HoverTab(
          text: t[index],
          active: selectedIndex == index,
          onTap: () => setState(() => selectedIndex = index),
        );
      },
    ),
  );
}

// --- ITEM CARD DENGAN NAVIGASI KE DETAIL ---
class _ProductItemCard extends StatefulWidget {
  final Map<String, dynamic> item;
  final VoidCallback onFavToggle;
  const _ProductItemCard({required this.item, required this.onFavToggle});

  @override
  State<_ProductItemCard> createState() => _ProductItemCardState();
}

class _ProductItemCardState extends State<_ProductItemCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _s;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _s = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final i = widget.item;
    return GestureDetector(
      // Navigasi ke halaman detail saat kartu di-tap
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: i),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Image.asset(i["image"], fit: BoxFit.contain),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    // Menggunakan GestureDetector di sini agar klik favorit tidak memicu onTap navigasi di atas
                    onTap: () {
                      _c.forward().then((_) => _c.reverse());
                      widget.onFavToggle();
                    },
                    child: ScaleTransition(
                      scale: _s,
                      child: Icon(
                        i["fav"] ? Icons.favorite : Icons.favorite_border,
                        color: i["fav"] ? Colors.red : Colors.grey.shade400,
                        size: 22,
                      ),
                    ),
                  ),
                ),
                if (i["sale"] != "")
                  Positioned(
                    left: 10,
                    top: 0,
                    child: Container(
                      width: 28,
                      height: 88,
                      decoration: BoxDecoration(
                        color: i["black"] ? Colors.black : Colors.red,
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(16),
                        ),
                      ),
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Center(
                          child: Text(
                            i["sale"],
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            i["name"],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                i["price"],
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset("assets/icon/arrow_right.svg"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HoverTab extends StatefulWidget {
  final String text;
  final bool active;
  final VoidCallback onTap;
  const _HoverTab({
    required this.text,
    required this.active,
    required this.onTap,
  });
  @override
  State<_HoverTab> createState() => _HoverTabState();
}

class _HoverTabState extends State<_HoverTab> {
  bool h = false;
  @override
  Widget build(BuildContext context) {
    bool d = widget.active || h;
    return MouseRegion(
      onEnter: (_) => setState(() => h = true),
      onExit: (_) => setState(() => h = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: d ? Colors.black : const Color(0xFFF6F6F6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: d ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
