import 'package:flutter/material.dart';
import '../../Ads/VideoAdCard.dart';
import '../../AddListing/AddPg.dart';

class AddCategoryScreen extends StatefulWidget {
  AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:  Text('Add Category',
          style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor:  Color(0xFF424242),
        automaticallyImplyLeading: false,

      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8F9FF),
              Color(0xFFEFF2FF),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome text
              Text(
                'Select Property Type',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Choose the type of property you want to add',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 24),

              // Video Ad Card
              VideoAdCard(),
              
              SizedBox(height: 20),
              
              // Category Grid
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.75,
                children: [
                  _buildCategoryCard(
                    icon: Icons.hotel_rounded,
                    label: 'PG',
                    description: 'Paying guest stays',
                    isSelected: _selectedCategory == 'PG',
                    onTap: () {
                      setState(() => _selectedCategory = 'PG');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddPgScreen()),
                      );
                    },
                  ),

                  _buildCategoryCard(
                    icon: Icons.business_rounded,
                    label: 'Flats',
                    description: 'Apartments',
                    isSelected: _selectedCategory == 'Flats',
                    onTap: () => setState(() => _selectedCategory = 'Flats'),
                  ),
                  _buildCategoryCard(
                    icon: Icons.campaign_rounded,
                    label: 'Tenant Ads',
                    description: 'Rental ads',
                    isSelected: _selectedCategory == 'Tenant Ads',
                    onTap: () => setState(() => _selectedCategory = 'Tenant Ads'),
                  ),
                  _buildCategoryCard(
                    icon: Icons.school_rounded,
                    label: 'Library',
                    description: 'Study spaces',
                    isSelected: _selectedCategory == 'Library',
                    onTap: () => setState(() => _selectedCategory = 'Library'),
                  ),
                  _buildCategoryCard(
                    icon: Icons.apartment_rounded,
                    label: 'Commercial Flats',
                    description: 'Office spaces',
                    isSelected: _selectedCategory == 'Commercial Flats',
                    onTap: () => setState(() => _selectedCategory = 'Commercial Flats'),
                  ),
                ],
              ),
              
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable function to build individual category cards
  Widget _buildCategoryCard({
    required IconData icon,
    required String label,
    required String description,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: isSelected ? Color(0xFF1E6AFE) : Colors.grey.shade200,
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected 
                  ? Color(0xFF1E6AFE).withOpacity(0.15)
                  : Colors.black.withOpacity(0.04),
              blurRadius: isSelected ? 12 : 8,
              offset: Offset(0, isSelected ? 4 : 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon container
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isSelected 
                      ? Color(0xFFE8F1FF) 
                      : Colors.grey.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isSelected 
                      ? Color(0xFF1E6AFE) 
                      : Color(0xFF6B7280),
                  size: 28.0,
                ),
              ),
              // Label and Description
              Column(
                children: [
                  // Label
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      color: isSelected 
                          ? Color(0xFF1E6AFE) 
                          : Color(0xFF1A1A1A),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.0),
                  // Description
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade500,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              // Selection indicator
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF1E6AFE) : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
                child: isSelected
                    ? Icon(Icons.check, color: Colors.white, size: 12)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}