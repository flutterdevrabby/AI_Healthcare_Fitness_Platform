import 'package:flutter/material.dart';

class PlanWidget extends StatelessWidget {
 
  const PlanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Premium Plan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "month",
                  style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                ),
              ],
            ),

            /// Active status
            Row(
              children: const [
                Icon(Icons.circle, size: 10, color: Color(0xFF22C55E)),
                SizedBox(width: 6),
                Text(
                  "Active",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF22C55E),
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 16),

        /// Plan includes
        const Text(
          "Plan includes:",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF0F172A),
          ),
        ),

        const SizedBox(height: 12),

        ...[
          _buildFeature("Unlimited workouts"),
          _buildFeature("Personal trainer AI"),
          _buildFeature("Nutrition tracking"),
          _buildFeature("Progress analytics"),
          _buildFeature("Custom meal plans"),
        ],

        const SizedBox(height: 16),
        const Divider(color: Color(0xFFE5EAF3)),

        const SizedBox(height: 12),

        /// Billing date
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Next billing date",
              style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
            ),
            Text(
              "March 15, 2026",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0F172A),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check, size: 18, color: Colors.black),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
            ),
          ),
        ],
      ),
    );
  }
}
