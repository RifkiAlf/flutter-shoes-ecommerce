import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:footflare/presentation/home/home_page.dart';
import 'package:footflare/presentation/order/cart_screen.dart';
import 'package:footflare/presentation/wishlist/wishlist_page.dart';
import 'package:footflare/presentation/profile/profile_page.dart';
import 'package:footflare/presentation/widgets/custom_bottom_nav.dart';
import 'package:footflare/presentation/home/widgets/side_drawer.dart';
import 'package:footflare/presentation/category/category_page.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;
  DateTime? _lastBackPressTime;

  final List<Widget> _pages = [
    const HomePage(),
    const WishlistPage(),
    const CartScreen(),
    const CategoryPage(),
    const FootFlareProfile(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        // Jika bukan di tab Beranda (tab 0), kembali ke Beranda terlebih dahulu
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return;
        }

        // Jika sudah di Beranda, tekan 2x untuk keluar aplikasi
        final now = DateTime.now();
        if (_lastBackPressTime == null ||
            now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
          _lastBackPressTime = now;
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Tekan sekali lagi untuk keluar',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
          return;
        }

        // Keluar aplikasi jika ditekan 2x (tidak kembali ke welcome screen)
        SystemNavigator.pop();
      },
      child: Scaffold(
        drawer: const SideDrawer(),
        body: FadeIndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: CustomBottomNav(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class FadeIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;
  final Duration duration;

  const FadeIndexedStack({
    super.key,
    required this.index,
    required this.children,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  State<FadeIndexedStack> createState() => _FadeIndexedStackState();
}

class _FadeIndexedStackState extends State<FadeIndexedStack>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.value = 1.0;
  }

  @override
  void didUpdateWidget(FadeIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != oldWidget.index) {
      _currentIndex = widget.index;
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: IndexedStack(
        index: _currentIndex,
        children: widget.children,
      ),
    );
  }
}
