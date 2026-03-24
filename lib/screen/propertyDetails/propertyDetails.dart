import 'package:flutter/material.dart';

class PropertyDetailScreen extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String price;
  final String rating;
  final String distance;

  const PropertyDetailScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
    required this.rating,
    required this.distance,
  });

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  int _currentImageIndex = 0;
  
  // Sample property images - in real app, these would come from API/database
  late final List<String> _propertyImages;
  
  @override
  void initState() {
    super.initState();
    _propertyImages = [
      widget.imageUrl,
      'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688',
      'https://images.unsplash.com/photo-1493809842364-78817add7ffb',
      'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267',
      'https://images.unsplash.com/photo-1513694203232-719a280e022f',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Header Image Slider and Top Buttons (Stack)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: PageView.builder(
                      itemCount: _propertyImages.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Image.network(
                          _propertyImages[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                // Page indicator dots
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _propertyImages.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentImageIndex == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentImageIndex == index 
                              ? Colors.white 
                              : Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: _buildCircularButton(Icons.arrow_back),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Shortlist functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Added to shortlist'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: _buildCircularButton(Icons.favorite_border, color: Colors.black),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          // Share functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Share property'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: _buildCircularButton(Icons.share_outlined),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          // Full screen gallery
                          _showFullScreenGallery();
                        },
                        child: _buildCircularButton(Icons.photo_library, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // 2. Property Information Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Rating Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.star, color: Color(0xFF1E6AFE), size: 16),
                            SizedBox(width: 4),
                            Text(
                              "4.8",
                              style: TextStyle(
                                color: Color(0xFF1E6AFE),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Location and Reviews
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey[400], size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "${widget.location} • 124 reviews",
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Rent and Availability Info Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.monetization_on_outlined,
                          title: "Monthly Rent",
                          value: "£${widget.price}/mo",
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.calendar_today_outlined,
                          title: "Availability",
                          value: "Available Now",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // 3. About This Space Section
                  const Text(
                    "About this space",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Experience London living at its finest in this light-filled, modern studio. Located in the heart of Soho, this apartment offers minimalist design, high-end appliances, and a quiet retreat from the bustling city streets. Perfect for young professionals.",
                    style: TextStyle(color: Colors.grey, height: 1.6),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Show more",
                    style: TextStyle(color: Color(0xFF1E6AFE), fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 30),

                  // 4. Amenities Section
                  const Text(
                    "Amenities",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 20,
                    runSpacing: 15,
                    children: [
                      _buildAmenity(Icons.wifi, "High-speed WiFi"),
                      _buildAmenity(Icons.ac_unit, "Air Conditioning"),
                      _buildAmenity(Icons.soup_kitchen, "Modern Kitchen"),
                      _buildAmenity(Icons.fitness_center, "Gym Access"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildOutlineButton("Show all 24 amenities"),
                ],
              ),
            ),

            // 5. Host Information Card (Integrated into the list)
            _buildHostCard(),
            const SizedBox(height: 100), // Space for bottom booking bar
          ],
        ),
      ),

      // 6. Sticky Bottom Booking Bar
      bottomSheet: _buildBottomBookingBar(),
    );
  }

  // Reusable helper methods for different sections

  Widget _buildCircularButton(IconData icon, {Color color = Colors.black54}) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white70, shape: BoxShape.circle),
      padding: const EdgeInsets.all(8),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _buildInfoCard({required IconData icon, required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF1E6AFE), size: 24),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildAmenity(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.grey[700], size: 18),
        const SizedBox(width: 10),
        Text(label, style: TextStyle(color: Colors.grey[800], fontSize: 14)),
      ],
    );
  }

  Widget _buildOutlineButton(String label) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey.shade300),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(label, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildHostCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1522778119026-d647f0596c20'),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Alexander Wright", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("Superhost • Joined 2021", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.verified, color: Color(0xFF1E6AFE), size: 18),
              const Text("VERIFIED", style: TextStyle(color: Color(0xFF1E6AFE), fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: const Text("Contact Host"),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E6AFE), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), elevation: 0),
                ),
              ),
              const SizedBox(width: 15),
              Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.call, color: Colors.black87)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBottomBookingBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade200))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(TextSpan(children: [
            TextSpan(text: "£${widget.price}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const TextSpan(text: " / month", style: TextStyle(color: Colors.grey, fontSize: 12)),
          ])),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E6AFE), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), elevation: 0),
            child: const Text("Book Room", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          )
        ],
      ),
    );
  }

  void _showFullScreenGallery() {
    int currentIndex = _currentImageIndex;
    
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        child: Stack(
          children: [
            // Full screen image slider
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                itemCount: _propertyImages.length,
                controller: PageController(initialPage: currentIndex),
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return InteractiveViewer(
                    child: Image.network(
                      _propertyImages[index],
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
            // Close button
            Positioned(
              top: 40,
              right: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 24),
                ),
              ),
            ),
            // Image counter
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${currentIndex + 1} / ${_propertyImages.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}