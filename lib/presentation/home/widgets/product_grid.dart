import 'package:flutter/material.dart';
import '../../product_detail/product_detail_page.dart';
import '../../../models/product_models.dart';
import '../../../utils/wishlist_manager.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});
  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  final List<Map<String, dynamic>> _products = [
    {
      'id': '1',
      'name': 'Swift Glide Sprinter Soles', 
      'price': '\$199', 
      'rawPrice': 199.0,
      'image': 'assets/images/pic1.png',
      'discount': '30% OFF',
      'category': 'Man',
    },
    {
      'id': '2',
      'name': 'Echo Vibe Urban Runners', 
      'price': '\$149', 
      'rawPrice': 149.0,
      'image': 'assets/images/pic2.png',
      'discount': '',
      'category': 'Woman',
    },
    {
      'id': '3',
      'name': 'Zen Dash Active Flex Shoes', 
      'price': '\$299', 
      'rawPrice': 299.0,
      'image': 'assets/images/pic3.png',
      'discount': '',
      'category': 'Unisex',
    },
    {
      'id': '4',
      'name': 'Nova Stride Street Stompers', 
      'price': '\$99', 
      'rawPrice': 99.0,
      'image': 'assets/images/pic4.png',
      'discount': '30% OFF',
      'category': 'Child',
    },
    {
      'id': '5',
      'name': 'Evo Quip Evo Quick Strides', 
      'price': '\$199', 
      'rawPrice': 199.0,
      'image': 'assets/images/pic5.png',
      'discount': '30% OFF',
      'category': 'Man',
    },
    {
      'id': '6',
      'name': 'Urban Kicks Classic', 
      'price': '\$84', 
      'rawPrice': 84.0,
      'image': 'assets/images/pic6.png',
      'discount': '20% OFF',
      'category': 'Woman',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListenableBuilder(
      listenable: WishlistManager.instance,
      builder: (context, _) {
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, 
            crossAxisSpacing: 16, 
            mainAxisSpacing: 24, 
            childAspectRatio: 0.58, 
          ),
          itemCount: _products.length,
          itemBuilder: (context, index) {
            final product = _products[index];
            final isFav = WishlistManager.instance.isFavorite(
              id: product['id'],
              name: product['name'],
              image: product['image'],
            );
            
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product: product)
                  )
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white, // Kotak gambar tetap putih mutlak
                        borderRadius: BorderRadius.circular(16)
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16), 
                              child: Image.asset(
                                product['image'],
                                fit: BoxFit.cover, 
                              ),
                            ),
                          ), 
                          
                          if (product['discount'] != null && product['discount'].toString().isNotEmpty)
                            Positioned(
                              top: 0, 
                              left: 16, 
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                                decoration: BoxDecoration(
                                  color: product['name'].toString().contains('Nova') || product['discount'].toString().contains('20%')
                                      ? const Color(0xFFC70039) 
                                      : Colors.black,
                                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(100)),
                                ),
                                child: RotatedBox(
                                  quarterTurns: 3, 
                                  child: Text(
                                    product['discount'],
                                    style: const TextStyle(
                                      color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'Poppins', letterSpacing: 1.0, 
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          
                          Positioned(
                            top: 10,
                            right: 10,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                final prodObj = Product.fromMap(product);
                                final isAdded = WishlistManager.instance.toggle(prodObj);
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isAdded
                                          ? '${product['name']} ditambahkan ke Wishlist'
                                          : '${product['name']} dihapus dari Wishlist',
                                      style: const TextStyle(fontFamily: 'Poppins'),
                                    ),
                                    duration: const Duration(seconds: 1),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  isFav ? Icons.favorite : Icons.favorite_border,
                                  color: isFav ? const Color(0xFFC70039) : Colors.grey.shade400, 
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // --- PERBAIKAN: Kunci tinggi teks agar harga di bawahnya sejajar ---
                  SizedBox(
                    height: 40, // Tinggi tetap (ideal untuk 2 baris teks)
                    child: Text(
                      product['name'], 
                      style: TextStyle(
                        fontFamily: 'Poppins', 
                        fontWeight: FontWeight.w600, 
                        fontSize: 14, 
                        color: Theme.of(context).colorScheme.onSurface
                      ), 
                      maxLines: 2, 
                      overflow: TextOverflow.ellipsis
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product['price'], 
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold, 
                          fontSize: 18, 
                          color: Theme.of(context).colorScheme.onSurface
                        )
                      ),
                      
                      Container(
                        padding: const EdgeInsets.all(6), 
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF5F5F5), 
                          borderRadius: BorderRadius.circular(8), 
                        ),
                        child: Icon(
                          Icons.arrow_forward, 
                          size: 18, 
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
