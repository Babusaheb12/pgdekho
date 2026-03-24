import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;
  final bool showFilterIcon;

  const SectionHeader({
    Key? key,
    required this.title,
    required this.onSeeAll,
    this.showFilterIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          showFilterIcon
              ? Icon(Icons.sort, color: Colors.blue.shade200)
              : TextButton(onPressed: onSeeAll, child: const Text("See All")),
        ],
      ),
    );
  }
}
