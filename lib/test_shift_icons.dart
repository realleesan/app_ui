import 'package:flutter/material.dart';

class TestShiftIcons extends StatelessWidget {
  const TestShiftIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Shift Icons'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Test Ca sáng
            _buildTestShiftCard(
              title: 'Ca sáng',
              iconPath: 'images/casang.png',
              color: const Color(0xFFFEFBE8),
              borderColor: const Color(0xFFEAA907),
              duration: '04:00',
            ),
            const SizedBox(height: 16),
            
            // Test Ca trưa
            _buildTestShiftCard(
              title: 'Ca trưa',
              iconPath: 'images/catrua.png',
              color: const Color(0xFFFEE7E7),
              borderColor: const Color(0xFFF53D68),
              duration: '05:00',
            ),
            const SizedBox(height: 16),
            
            // Test Ca tối
            _buildTestShiftCard(
              title: 'Ca tối',
              iconPath: 'images/catoi.png',
              color: const Color(0xFFEEE8FE),
              borderColor: const Color(0xFF7959F8),
              duration: '04:00',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestShiftCard({
    required String title,
    required String iconPath,
    required Color color,
    required Color borderColor,
    required String duration,
  }) {
    return Container(
      width: double.infinity,
      height: 210,
      padding: const EdgeInsets.all(4),
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            color: borderColor,
          ),
          borderRadius: BorderRadius.zero, // No border radius - square corners like Figma
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon at the top
          Container(
            width: 20,
            height: 20,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(),
            child: Image.asset(
              iconPath,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: borderColor.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.work,
                    size: 12,
                    color: borderColor,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          // Title
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF111826),
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              height: 1.50,
            ),
          ),
          // Duration
          Text(
            duration,
            style: const TextStyle(
              color: Color(0xFF8C9BB0),
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
        ],
      ),
    );
  }
}