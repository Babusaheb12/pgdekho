import 'package:flutter/material.dart';
import 'package:pgdekho/screen/Ads/ad_widgets.dart';
import '../../../widgets/DashboardWidget/categoryWigiets.dart';
import '../../Ads/VideoAdCard.dart';
import '../../propertyDetails/propertyDetails.dart';

class MyDashboardScreen extends StatefulWidget {
   MyDashboardScreen({super.key});

  @override
  State<MyDashboardScreen> createState() => _MyDashboardScreenState();
}

class _MyDashboardScreenState extends State<MyDashboardScreen> {
  String _currentCategory = "Rooms";
  Set<String> _shortlistedProperties = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(height: 10),
              _buildHeader(),
               SizedBox(height: 20),
              _buildSearchBar(),
               SizedBox(height: 20),
              PropertyAdCarouselCard(),
               SizedBox(height: 20),
              CategorySelector(
                onCategorySelected: (selectedCategory) {
                  print("Selected category: $selectedCategory");
                  // You can also update your state here if needed:
                  setState(() {
                    _currentCategory = selectedCategory;
                  });
                },
              ),
               SizedBox(height: 25),
              // _buildSectionHeader("Nearby Rooms"),
              //  SizedBox(height: 15),
              _buildSectionHeader(
                "Near pg",
                onSeeAllTap: () {
                  print("See All tapped for Near pg");
                },
              ),
              SizedBox(height: 15),
              _buildNearbyList(),
              VideoAdCard(),
              SizedBox(height: 25),
              SizedBox(height: 15),
              _buildSectionHeader(
                "Near room",
                onSeeAllTap: () {
                  print("See All tapped for Near room");
                },
              ),
              SizedBox(height: 15),
              _buildNearbyList(),
               SizedBox(height: 25),
              VideoAdCard(),
              SizedBox(height: 25),
              _buildSectionHeader(
                "Near Library",
                onSeeAllTap: () {
                  print("See All tapped for Near room");
                },
              ),
              SizedBox(height: 15),
              _buildNearbyList(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionHeader("Featured Listings"),
                   Icon(Icons.filter_list_rounded, color: Colors.blueAccent),
                ],
              ),
               SizedBox(height: 15),
              _buildFeaturedCard(
                imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750',
                title: "The Glass Suite",
                location: "Mayfair, London",
                price: "1,250",
                isPremium: true,
              ),
               SizedBox(height: 20),
              _buildFeaturedCard(
                imageUrl: 'https://images.unsplash.com/photo-1493809842364-78817add7ffb',
                title: "Artist Loft Studio",
                location: "Shoreditch, London",
                price: "950",
                isPremium: false,
              ),
               SizedBox(height: 100), // Space for FAB
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
             CircleAvatar(
              backgroundColor: Color(0xFFE8F1FF),
              child: Icon(Icons.location_on, color: Color(0xFF1E6AFE)),
            ),
             SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text("CURRENT LOCATION", style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                Text("London, UK", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
             Icon(Icons.keyboard_arrow_down),
          ],
        ),
        Container(
          padding:  EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200),
          ),
          child:  Icon(Icons.notifications_none_outlined),
        )
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.grey.shade400),
          hintText: "Search rooms, flats, or studios",
          hintStyle: TextStyle(color: Colors.grey.shade400),
          border: InputBorder.none,
          suffixIcon:  Icon(Icons.tune, color: Color(0xFF1E6AFE)),
        ),
      ),
    );
  }


  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAllTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        if (onSeeAllTap != null)
          GestureDetector(
            onTap: onSeeAllTap,
            child: const Text(
              "See All",
              style: TextStyle(
                color: Color(0xFF1E6AFE),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildNearbyList() {
    return SizedBox(
      height: 240,
      child: ClipRect(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            _buildNearbyCard("Modern Studio, Soho", "0.5 miles away", "850", "4.8", 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267'),
            _buildNearbyCard("Quiet Room, ...", "1.2 miles away", "720", "4.5", 'https://images.unsplash.com/photo-1513694203232-719a280e022f'),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbyCard(String title, String dist, String price, String rate, String img) {
    final propertyId = img; // Using image URL as unique identifier
    final isShortlisted = _shortlistedProperties.contains(propertyId);
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailScreen(
              imageUrl: img,
              title: title,
              location: dist.split(',').length > 1 ? dist.split(',')[0] : 'London',
              price: price,
              rating: rate,
              distance: dist,
            ),
          ),
        );
      },
      child: Container(
        width: 220,
        margin:  EdgeInsets.only(right: 15),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:  BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.network(img, height: 140, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 10, 
                  right: 10, 
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isShortlisted) {
                          _shortlistedProperties.remove(propertyId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$title removed from shortlist'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          _shortlistedProperties.add(propertyId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$title added to shortlist'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      });
                    },
                    child: CircleAvatar(
                      radius: 15, 
                      backgroundColor: Colors.white, 
                      child: Icon(
                        isShortlisted ? Icons.favorite : Icons.favorite_border, 
                        color: isShortlisted ? Colors.red : Colors.grey, 
                        size: 16
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(title, style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Row(children: [ Icon(Icons.star, color: Colors.orange, size: 14), Text(rate, style:  TextStyle(fontSize: 12))])
                  ]),
                   SizedBox(height: 4),
                  Text(dist, style:  TextStyle(color: Colors.grey, fontSize: 12)),
                   SizedBox(height: 8),
                  Text("£$price/mo", style:  TextStyle(color: Color(0xFF1E6AFE), fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedCard({required String imageUrl, required String title, required String location, required String price, required bool isPremium}) {
    final propertyId = imageUrl; // Using image URL as unique identifier
    final isShortlisted = _shortlistedProperties.contains(propertyId);
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailScreen(
              imageUrl: imageUrl,
              title: title,
              location: location,
              price: price,
              rating: "4.9",
              distance: "London",
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:  BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.network(imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
                ),
                if (isPremium)
                  Positioned(top: 15, left: 15, child: Container(padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color:  Color(0xFF1E6AFE), borderRadius: BorderRadius.circular(5)), child:  Text("PREMIUM", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
                Positioned(
                  top: 15, 
                  right: 15, 
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isShortlisted) {
                          _shortlistedProperties.remove(propertyId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$title removed from shortlist'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          _shortlistedProperties.add(propertyId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$title added to shortlist'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      });
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white, 
                      child: Icon(
                        isShortlisted ? Icons.favorite : Icons.favorite_border, 
                        color: isShortlisted ? Colors.red : Colors.grey, 
                        size: 20
                      ),
                    ),
                  ),
                ),
                Positioned(bottom: 15, left: 15, child: Container(padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(15)), child: Row(children: [ Icon(Icons.location_on, color: Colors.white, size: 12),  SizedBox(width: 4), Text(location, style:  TextStyle(color: Colors.white, fontSize: 11))]))),
              ],
            ),
            Padding(
              padding:  EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(title, style:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("£$price", style:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E6AFE))),
                  ]),
                   Row(mainAxisAlignment: MainAxisAlignment.end, children: [Text("PER MONTH", style: TextStyle(fontSize: 8, color: Colors.grey))]),
                   SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Row(children: [
                        Icon(Icons.star, color: Colors.orange, size: 16),
                        SizedBox(width: 4),
                        Text("4.9", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 4),
                        Text("(124 reviews)", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor:  Color(0xFFE8F1FF), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        child:  Text("Details", style: TextStyle(color: Color(0xFF1E6AFE))),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }




}