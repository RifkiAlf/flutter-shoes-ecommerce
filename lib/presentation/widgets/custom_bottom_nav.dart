import 'package:flutter/material.dart';
import '../../utils/wishlist_manager.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final navBg = isDark ? const Color(0xFF1B1D27) : Colors.white;
    final borderColor = isDark ? Colors.white10 : Colors.grey.shade200;

    return Container(
      decoration: BoxDecoration(
        color: navBg,
        border: Border(
          top: BorderSide(color: borderColor, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListenableBuilder(
            listenable: WishlistManager.instance,
            builder: (context, _) {
              final wishlistCount = WishlistManager.instance.count;

              return Row(
                children: [
                  _NavItem(
                    index: 0,
                    imagePath: 'assets/images/nav-home.png',
                    isActive: currentIndex == 0,
                    onTap: () => onTap(0),
                    isDark: isDark,
                  ),
                  _NavItem(
                    index: 1,
                    imagePath: 'assets/images/nav-wishlist.png',
                    isActive: currentIndex == 1,
                    onTap: () => onTap(1),
                    isDark: isDark,
                    badgeCount: wishlistCount,
                  ),
                  _NavItem(
                    index: 2,
                    imagePath: 'assets/images/nav-mycart.png',
                    isActive: currentIndex == 2,
                    onTap: () => onTap(2),
                    isDark: isDark,
                  ),
                  _NavItem(
                    index: 3,
                    imagePath: 'assets/images/nav-category.png',
                    isActive: currentIndex == 3,
                    onTap: () => onTap(3),
                    isDark: isDark,
                  ),
                  _NavItem(
                    index: 4,
                    imagePath: 'assets/images/nav-profile.png',
                    isActive: currentIndex == 4,
                    onTap: () => onTap(4),
                    isDark: isDark,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final String imagePath;
  final bool isActive;
  final VoidCallback onTap;
  final bool isDark;
  final int badgeCount;

  const _NavItem({
    required this.index,
    required this.imagePath,
    required this.isActive,
    required this.onTap,
    required this.isDark,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = isDark ? Colors.white : Colors.black;
    final inactiveColor = isDark ? Colors.grey.shade600 : Colors.grey.shade400;

    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSlide(
                offset: Offset(0, isActive ? -0.07 : 0.0),
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOutCubic,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 240),
                  curve: Curves.easeOutCubic,
                  width: 48,
                  height: 38,
                  decoration: BoxDecoration(
                    color: isActive
                        ? (isDark
                            ? Colors.white.withValues(alpha: 0.12)
                            : Colors.black.withValues(alpha: 0.06))
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      AnimatedScale(
                        scale: isActive ? 1.12 : 1.0,
                        duration: const Duration(milliseconds: 240),
                        curve: Curves.easeOutCubic,
                        child: Image.asset(
                          imagePath,
                          width: 24,
                          height: 24,
                          color: isActive ? activeColor : inactiveColor,
                        ),
                      ),
                      if (badgeCount > 0)
                        Positioned(
                          top: 4,
                          right: 6,
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.elasticOut,
                            builder: (context, scale, child) {
                              return Transform.scale(
                                scale: scale,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 1.5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFC70039),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFC70039)
                                            .withValues(alpha: 0.4),
                                        blurRadius: 4,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: Center(
                                    child: Text(
                                      badgeCount > 9 ? '9+' : '$badgeCount',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOutCubic,
                height: 3,
                width: isActive ? 20 : 0,
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: activeColor.withValues(alpha: 0.25),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
