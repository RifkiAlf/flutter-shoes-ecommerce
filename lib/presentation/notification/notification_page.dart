import 'package:flutter/material.dart';
import '../search/search_page.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final boxColor = isDark ? const Color(0xFF2A2D3A) : Colors.grey.shade100;
    final iconColor = Theme.of(context).colorScheme.onSurface;

    // Data List Notifikasi sesuai dengan teks dan gambar dari desainmu
    final List<Map<String, String>> notifications = [
      {'title': 'New Arrivals Alert!', 'date': '15 July 2023', 'image': 'assets/images/notif-1.png'},
      {'title': 'Flash Sale Announcement', 'date': '21 July 2023', 'image': 'assets/images/notif-2.png'},
      {'title': 'Exclusive Discounts Inside', 'date': '10 March 2023', 'image': 'assets/images/notif-3.png'},
      {'title': 'Limited Stock - Act Fast!', 'date': '20 September 2023', 'image': 'assets/images/notif-4.png'},
      {'title': 'Get Ready to Shop', 'date': '15 July 2023', 'image': 'assets/images/notif-5.png'},
      // Karena fotonya ada 5, kita ulangi fotonya untuk notifikasi ke-6 dst
      {'title': 'Don\'t Miss Out on Savings', 'date': '24 July 2023', 'image': 'assets/images/notif-1.png'},
      {'title': 'Special Offer Just for You', 'date': '28 August 2023', 'image': 'assets/images/notif-2.png'},
      {'title': 'Don\'t Miss Out on Savings', 'date': '15 July 2023', 'image': 'assets/images/notif-3.png'},
      {'title': 'Get Ready to Shop', 'date': '15 July 2023', 'image': 'assets/images/notif-4.png'},
      {'title': 'Special Offer Just for You', 'date': '15 July 2023', 'image': 'assets/images/notif-5.png'},
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: boxColor, 
                borderRadius: BorderRadius.circular(12) // Kotak dengan sudut melengkung
              ),
              child: Icon(Icons.arrow_back_ios_new, size: 18, color: iconColor),
            ),
          ),
        ),
        title: Text(
          'Notification (12)',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 18, color: iconColor),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 16.0,
              top: 8.0,
              bottom: 8.0,
            ),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const SearchPage(),
                ),
              ),
              child: Container(
                width: 40,
                height: 40, // samakan tinggi
                decoration: BoxDecoration(
                  color: boxColor,
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.search,
                  size: 20,
                  color: iconColor,
                ),
              ),
            ),
          ),
        ],        
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (context, index) => Divider(
          height: 1, 
          color: isDark ? Colors.white10 : Colors.black12,
          indent: 20, // Garis pembatas tidak full layar, diberi jarak dari kiri
          endIndent: 20,
        ),
        itemBuilder: (context, index) {
          final notif = notifications[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                // --- FOTO PROFIL KOTAK MELENGKUNG ---
                ClipRRect(
                  borderRadius: BorderRadius.circular(16), // Radius tidak 100%, jadi kotak melengkung
                  child: Image.asset(
                    notif['image']!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                
                // --- TEKS NOTIFIKASI ---
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notif['title']!, 
                        style: TextStyle(
                          fontFamily: 'Poppins', // Font judul
                          fontWeight: FontWeight.w600, 
                          fontSize: 15,
                          color: iconColor
                        )
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notif['date']!, 
                        style: TextStyle(
                          fontFamily: 'Inter', // Font tanggal yang lebih bersih
                          color: Colors.grey.shade500, 
                          fontSize: 12
                        )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}