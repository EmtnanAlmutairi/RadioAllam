import 'package:flutter/material.dart';

class Live extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:260, // Set height for the Live widget
      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0), // Adjusted padding to reduce space above
      child: SingleChildScrollView(
        reverse: true, // Enable scrolling from the right
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true, // Enable horizontal scrolling from the right
                    child: Row(
                      children: [
                        _buildLiveImage("assets/images/Live1.png"),
                        SizedBox(width: 16), // Space between images
                        _buildLiveImage("assets/images/Live2.png"),
                        SizedBox(width: 16), // Space between images
                        _buildLiveImage("assets/images/Live3.png"),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16), // Space between images and title
                Padding(
                  padding: const EdgeInsets.only(top: 16.0), // Align title with images
                  child: Text(
                    'بث مباشر',
                    style: TextStyle(
                      color: Color(0xFF1F1F1F),
                      fontSize: 20,
                      fontFamily: 'Public Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveImage(String imagePath) {
    return Container(
      width: 331, // Width of each live stream image container
      height: 200, // Height of each live stream image container
      decoration: BoxDecoration(
        color: Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken), // Darken image
        ),
      ),
    );
  }
}
