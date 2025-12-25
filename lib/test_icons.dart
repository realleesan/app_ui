import 'package:flutter/material.dart';

class TestIconsScreen extends StatelessWidget {
  const TestIconsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Icons')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Testing PNG Assets:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            
            // Test each icon
            _buildTestIcon('images/logo-timeso.png', 'Logo Timeso'),
            _buildTestIcon('images/Frame.png', 'Frame (Lịch ca)'),
            _buildTestIcon('images/Frame-1.png', 'Frame-1 (Cộng đồng)'),
            _buildTestIcon('images/Frame-2.png', 'Frame-2 (Trò chuyện)'),
            _buildTestIcon('images/Frame-3.png', 'Frame-3 (Tài khoản)'),
            
            const SizedBox(height: 20),
            const Text('New Icons:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            
            _buildTestIcon('images/back.png', 'Back (Quay lại)'),
            _buildTestIcon('images/dangkyca.png', 'Đăng ký ca làm'),
            _buildTestIcon('images/bosungcong.png', 'Bổ sung công'),
            _buildTestIcon('images/xinnghiphep.png', 'Xin nghỉ phép'),
            
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Main'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestIcon(String path, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              path,
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, color: Colors.red);
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(path, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}