import 'package:flutter/material.dart';


class InternetPromoBanner extends StatelessWidget {
  const InternetPromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF30D5C8), Color(0xFF41B6FF)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF30D5C8).withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withOpacity(0.35)),
            ),
            child: const Icon(Icons.wifi_rounded, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'High-Speed Internet\nUnlimited data plans',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                height: 1.15,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Row(
              children: [
                Text(
                  'View Plans',
                  style: TextStyle(
                    color: Color(0xFF36AEB9),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 6),
                Icon(Icons.arrow_forward, size: 18, color: Color(0xFF36AEB9)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}