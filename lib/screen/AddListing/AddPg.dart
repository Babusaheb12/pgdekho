import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPgScreen extends StatefulWidget {
  const AddPgScreen({super.key});

  @override
  State<AddPgScreen> createState() => _AddPgScreenState();
}

class _AddPgScreenState extends State<AddPgScreen> {
  final _formKey = GlobalKey<FormState>();

  // Design Constants
  final Color primaryBlue = const Color(0xFF1E6AFE);
  final Color scaffoldBg = const Color(0xFFF8FAFF);

  // Form State
  String? _selectedCategory;
  String? _selectedRoomType;
  String? _selectedPricing = "Monthly";
  DateTime? _availableDate;
  bool _isSubmitting = false;

  // Controllers
  final _nameController = TextEditingController();
  final _rentController = TextEditingController();
  final _addressController = TextEditingController();
  final _descController = TextEditingController();

  // Multi-select Data
  final Map<String, bool> _facilities = {
    'WiFi': false, 'AC': false, 'Food': false, 'Parking': false,
    'Laundry': false, 'Power': false, 'CCTV': false, 'RO Water': false,
  };

  final List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      body: CustomScrollView(
        slivers: [
          // 1. Dynamic Header
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Create Listing", style: TextStyle(fontWeight: FontWeight.bold)),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [primaryBlue, primaryBlue.withOpacity(0.7)]),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Section 1: Basic Details
                    _buildSectionCard("Basic Details", Icons.info_outline, [
                      _buildTextField("PG Name / Title", "e.g. Sharma Boys PG", _nameController, Icons.business),
                      _buildDropdown("Category", ["Boys", "Girls", "Co-Living"], (val) => _selectedCategory = val),
                      Row(
                        children: [
                          Expanded(child: _buildTextField("Rent (₹/mo)", "5000", _rentController, Icons.payments_outlined, isNumber: true)),
                          const SizedBox(width: 12),
                          Expanded(child: _buildTextField("Security Deposit", "Optional", null, Icons.lock_outline, isNumber: true)),
                        ],
                      ),
                    ]),

                    // Section 2: Location
                    _buildSectionCard("Location Details", Icons.location_on_outlined, [
                      _buildTextField("City", "Delhi", null, Icons.location_city),
                      _buildTextField("Area", "Laxmi Nagar", null, Icons.map_outlined),
                      _buildTextField("Full Address", "House no, Street...", _addressController, Icons.home_work_outlined, maxLines: 2),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.my_location),
                        label: const Text("Set Map Coordinates"),
                        style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                      ),
                    ]),

                    // Section 3: Room Details
                    _buildSectionCard("Room Details", Icons.bed_outlined, [
                      _buildDropdown("Room Type", ["Single", "Double Sharing", "Triple Sharing"], (val) => _selectedRoomType = val),
                      Row(
                        children: [
                          Expanded(child: _buildTextField("Available Beds", "2", null, Icons.airline_seat_individual_suite)),
                          const SizedBox(width: 12),
                          Expanded(child: _buildTextField("Total Rooms", "10", null, Icons.meeting_room_outlined)),
                        ],
                      ),
                    ]),

                    // Section 4: Facilities (Grid View)
                    _buildSectionCard("Facilities", Icons.bolt, [
                      _buildFacilitiesGrid(),
                    ]),

                    // Section 5: Media
                    _buildSectionCard("Photos & Video", Icons.camera_alt_outlined, [
                      _buildImagePicker(),
                      const Text("Min 3 images required", style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ]),

                    // Section 6: Description & Contacts
                    _buildSectionCard("Extra Info & Contact", Icons.description_outlined, [
                      _buildTextField("Description", "Rules, Timing, Extra info...", _descController, Icons.notes, maxLines: 3),
                      _buildTextField("Owner Name", "Name", null, Icons.person_outline),
                      _buildTextField("Mobile Number", "10 Digit Number", null, Icons.phone_android_outlined, isNumber: true),
                    ]),

                    // Section 7: Availability & Tags
                    _buildSectionCard("Advance Features", Icons.star_outline, [
                      _buildDropdown("Pricing Type", ["Monthly", "Daily"], (val) => _selectedPricing = val),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(_availableDate == null ? "Select Available Date" : "Available: ${_availableDate!.day}/${_availableDate!.month}"),
                        trailing: const Icon(Icons.calendar_month, color: Color(0xFF1E6AFE)),
                        onTap: () async {
                          final date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
                          if (date != null) setState(() => _availableDate = date);
                        },
                      ),
                    ]),

                    const SizedBox(height: 24),
                    _buildSubmitButton(),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // UI Components
  Widget _buildSectionCard(String title, IconData icon, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Icon(icon, color: primaryBlue, size: 20), const SizedBox(width: 8), Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))]),
          const Divider(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController? controller, IconData icon, {bool isNumber = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label, hintText: hint, prefixIcon: Icon(icon, size: 20),
          filled: true, fillColor: scaffoldBg,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(labelText: label, filled: true, fillColor: scaffoldBg, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildFacilitiesGrid() {
    return Wrap(
      spacing: 8, runSpacing: 8,
      children: _facilities.keys.map((key) {
        bool selected = _facilities[key]!;
        return FilterChip(
          label: Text(key), selected: selected,
          onSelected: (val) => setState(() => _facilities[key] = val),
          selectedColor: primaryBlue.withOpacity(0.2),
          checkmarkColor: primaryBlue,
        );
      }).toList(),
    );
  }

  Widget _buildImagePicker() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          GestureDetector(
            onTap: () async {
              final picked = await _picker.pickMultiImage();
              setState(() => _images.addAll(picked));
            },
            child: Container(width: 100, decoration: BoxDecoration(color: scaffoldBg, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)), child: const Icon(Icons.add_a_photo, color: Colors.grey)),
          ),
          ..._images.map((file) => Container(margin: const EdgeInsets.only(left: 8), width: 100, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), image: DecorationImage(image: FileImage(File(file.path)), fit: BoxFit.cover)))),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity, height: 55,
      child: ElevatedButton(
        onPressed: _isSubmitting ? null : () {
          setState(() => _isSubmitting = true);
          Future.delayed(const Duration(seconds: 2), () => setState(() => _isSubmitting = false));
        },
        style: ElevatedButton.styleFrom(backgroundColor: primaryBlue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        child: _isSubmitting ? const CircularProgressIndicator(color: Colors.white) : const Text("Publish PG Listing", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}