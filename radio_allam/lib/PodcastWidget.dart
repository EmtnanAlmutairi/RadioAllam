import 'package:flutter/material.dart';

class PodcastList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final podcasts = [
      {'title': 'صباح السعودية', 'subtitle': 'mbcfm', 'duration': '40 دقيقة', 'imagePath': 'assets/images/p1.png'},
      {'title': 'اخبار علام', 'subtitle': 'mbcfm', 'duration': '40 دقيقة', 'imagePath': 'assets/images/p2.png'},
      {'title': 'الشعر العربي', 'subtitle': 'mbcfm', 'duration': '40 دقيقة', 'imagePath': 'assets/images/p3.png'},
      {'title': 'اخبار الذكاء الاصطناعي', 'subtitle': 'mbcfm', 'duration': '40 دقيقة', 'imagePath': 'assets/images/p4.png'},
      {'title': 'الشعر العربي', 'subtitle': 'mbcfm', 'duration': '40 دقيقة', 'imagePath': 'assets/images/p5.png'},
    ];

    return SingleChildScrollView(
      child: Column(
        children: podcasts.map((podcast) {
          return Frame3(
            title: podcast['title']!,
            subtitle: podcast['subtitle']!,
            duration: podcast['duration']!,
            imagePath: podcast['imagePath']!,
          );
        }).toList(),
      ),
    );
  }
}

class Frame3 extends StatelessWidget {
  final String title;
  final String subtitle;
  final String duration;
  final String imagePath;

  const Frame3({
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        width: double.infinity,
        height: 96,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // زر التشغيل على اليسار
            Container(
              width: 48,
              height: 48,
              child: Image.asset('assets/icons/play.png'),
            ),
            // التفاصيل النصية
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Color(0xFF1F1F1F),
                        fontSize: 14,
                        fontFamily: 'Public Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6.5),
                    Opacity(
                      opacity: 0.7,
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          color: Color(0xFF1F1F1F),
                          fontSize: 14,
                          fontFamily: 'Public Sans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6.5),
                    Opacity(
                      opacity: 0.7,
                      child: Text(
                        duration,
                        style: TextStyle(
                          color: Color(0xFF1F1F1F),
                          fontSize: 14,
                          fontFamily: 'Public Sans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // صورة البودكاست على اليمين
            Container(
              width: 108,
              height: 96,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
