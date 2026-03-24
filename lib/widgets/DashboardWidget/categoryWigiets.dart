import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  final Function(String) onCategorySelected;
  
  const CategorySelector({super.key, required this.onCategorySelected});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int _selectedIndex = 0;
  final List<String> _categories = ['All', 'PG', 'Room', 'Library'];

  void _selectCategory(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onCategorySelected(_categories[index]);
  }

  @override
  Widget build(BuildContext context) {
    // Data list matching the Figma screenshot icons
    final List<Map<String, dynamic>> categories = [
      {"name": "All", "icon": Icons.grid_view_rounded},
      {"name": "PG", "icon": Icons.domain_rounded},
      {"name": "Room", "icon": Icons.bed_rounded},
      {"name": "Library", "icon": Icons.local_library_rounded},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: categories.asMap().entries.map((entry) {
          int index = entry.key;
          var cat = entry.value;
          bool isSelected = _selectedIndex == index;
          
          return Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: GestureDetector(
              onTap: () => _selectCategory(index),
              child: Column(
                children: [
                  // Circular Icon Container
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFF5F7FA), // Light grey background
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF1E6AFE) // Blue border if selected
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      cat['icon'],
                      size: 28,
                      color: isSelected 
                          ? const Color(0xFF1E6AFE) // Blue icon when selected
                          : const Color(0xFF4A5568), // Dark blue-grey icon when not selected
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Text Label
                  Text(
                    cat['name'],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? const Color(0xFF1E6AFE) : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}