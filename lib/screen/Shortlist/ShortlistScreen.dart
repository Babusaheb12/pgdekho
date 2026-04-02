import 'package:flutter/material.dart';

class ShortlistScreen extends StatefulWidget {
   ShortlistScreen({super.key});

  @override
  State<ShortlistScreen> createState() => _ShortlistScreenState();
}

class _ShortlistScreenState extends State<ShortlistScreen> {
  // Keep track of shortlisted items by their title (or unique ID)
  final Set<String> _shortlistedTitles = {};

  final List<Map<String, dynamic>> _shortlistedItems = [
    {
      "image": 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750',
      "title": "Modern Studio in Brooklyn",
      "location": "Williamsburg, NY",
      "price": "1,200",
      "rating": "4.8",
      "reviews": "120 REVIEWS",
    },
    {
      "image": 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c',
      "title": "Cozy Loft in Manhattan",
      "location": "Chelsea, NY",
      "price": "2,500",
      "rating": "4.9",
      "reviews": "85 REVIEWS",
    },
    {
      "image": 'https://images.unsplash.com/photo-1493809842364-78817add7ffb',
      "title": "Skyline Penthouse",
      "location": "Upper East Side, NY",
      "price": "4,800",
      "rating": "5.0",
      "reviews": "42 REVIEWS",
    },
    {
      "image": 'https://images.unsplash.com/photo-1484154218962-a197022b5858',
      "title": "Minimalist Garden Suite",
      "location": "Greenwich Village, NY",
      "price": "2,100",
      "rating": "4.7",
      "reviews": "96 REVIEWS",
    },
    {
      "image": 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688',
      "title": "Vintage Industrial Loft",
      "location": "Dumbo, Brooklyn",
      "price": "3,200",
      "rating": "4.6",
      "reviews": "112 REVIEWS",
    },
    {
      "image": 'https://images.unsplash.com/photo-1613490493576-7fde63acd811',
      "title": "Sunset View Terrace",
      "location": "Astoria, Queens",
      "price": "1,850",
      "rating": "4.9",
      "reviews": "64 REVIEWS",
    },
  ];

  void _toggleShortlist(String title) {
    setState(() {
      if (_shortlistedTitles.contains(title)) {
        _shortlistedTitles.remove(title);
      } else {
        _shortlistedTitles.add(title);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text(
          'Shortlist',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false, // removes back button
      ),
      body: ListView.builder(
        padding:  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        itemCount: _shortlistedItems.length,
        itemBuilder: (context, index) {
          final item = _shortlistedItems[index];
          return _buildListingCard(item);
        },
      ),
    );
  }

  Widget _buildListingCard(Map<String, dynamic> item) {
    bool isShortlisted = _shortlistedTitles.contains(item["title"]);

    return Container(
      margin:  EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Property Image and Heart Button
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  item["image"],
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 15,
                right: 15,
                child: GestureDetector(
                  onTap: () => _toggleShortlist(item["title"]),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      isShortlisted ? Icons.favorite : Icons.favorite_border,
                      color: isShortlisted ? Colors.red : Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
           SizedBox(height: 12),
          // Title and Rating Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item["title"],
                  style:  TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color:  Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                     Icon(Icons.star, color: Color(0xFF1976D2), size: 16),
                     SizedBox(width: 4),
                    Text(
                      item["rating"],
                      style:  TextStyle(
                        color: Color(0xFF1976D2),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
           SizedBox(height: 6),
          // Location Row
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.grey[400], size: 16),
               SizedBox(width: 4),
              Expanded(
                child: Text(
                  item["location"],
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
           SizedBox(height: 8),
          // Price and Reviews Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "₹${item['price']}",
                      style:  TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    TextSpan(
                      text: " /mo",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                item["reviews"],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}