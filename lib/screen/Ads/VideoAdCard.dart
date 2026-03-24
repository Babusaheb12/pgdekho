import 'package:flutter/material.dart';

class VideoAdCard extends StatelessWidget {
   VideoAdCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.all(2),
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), // More rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset:  Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // 1. Background Image
            Positioned.fill(
              child: Image.network(
                'https://images.unsplash.com/photo-1600210492486-724fe5c67fb0',
                fit: BoxFit.cover,
              ),
            ),

            // 2. Gradient Overlay (Heavier at the bottom for text contrast)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops:  [0.5, 1.0],
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),

            // 3. AD Badge
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color:  Color(0xFFE5574D), // Soft Red/Coral
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  Row(
                  children: [
                    Icon(Icons.ads_click, color: Colors.white, size: 14),
                    SizedBox(width: 6),
                    Text(
                      'AD',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 4. Play Button
            Center(
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child:  Icon(
                  Icons.play_arrow_rounded,
                  color: Color(0xFFE5574D),
                  size: 45,
                ),
              ),
            ),

            // 5. Bottom Info
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children:  [
                        Text(
                          'Professional Moving Services',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16, // Reduced from 30 to match image
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Hassle-free relocation experts',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14, // Reduced from 20 to match image
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 6. Timestamp Badge
                  Container(
                    padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:  Row(
                      children: [
                        Icon(Icons.videocam, size: 16, color: Colors.white),
                        SizedBox(width: 6),
                        Text(
                          '1:45',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}