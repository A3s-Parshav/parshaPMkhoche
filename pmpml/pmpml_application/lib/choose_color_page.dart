import 'package:flutter/material.dart';

class ChooseColorPage extends StatelessWidget {
  final Function(Color) onColorSelected;

  const ChooseColorPage({Key? key, required this.onColorSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> colors = [
      {'name': 'Faint Yellow', 'color': const Color(0xFFFFF9C4)},
      {'name': 'Faint Blue', 'color': const Color(0xFFEAF6FF)},
      {'name': 'Faint Red', 'color': const Color(0xFFFFEBEE)},
      {'name': 'Faint Green', 'color': const Color(0xFFE8F5E8)},
      {'name': 'Faint Purple', 'color': const Color(0xFFF3E5F5)},
      {'name': 'Faint Orange', 'color': const Color(0xFFFFF3E0)},
      {'name': 'Faint Pink', 'color': const Color(0xFFFCE4EC)},
      {'name': 'Faint Grey', 'color': const Color(0xFFF5F5F5)},
      {'name': 'Faint Cyan', 'color': const Color(0xFFE0F7FA)},
      {'name': 'Faint Lime', 'color': const Color(0xFFF9FBE7)},
      {'name': 'Faint Indigo', 'color': const Color(0xFFE8EAF6)},
      {'name': 'Faint Teal', 'color': const Color(0xFFE0F2F1)},
      {'name': 'Faint Brown', 'color': const Color(0xFFEFEBE9)},
      {'name': 'Faint Amber', 'color': const Color(0xFFFFF8E1)},
      {'name': 'Faint Deep Orange', 'color': const Color(0xFFFBE9E7)},
      {'name': 'Faint Light Blue', 'color': const Color(0xFFE1F5FE)},
      {'name': 'Faint Light Green', 'color': const Color(0xFFF1F8E9)},
      {'name': 'Faint Blue Grey', 'color': const Color(0xFFECEFF1)},
      {'name': 'Faint Deep Purple', 'color': const Color(0xFFEDE7F6)},
      {'name': 'Faint Light Pink', 'color': const Color(0xFFFCE4EC)},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Background Color'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          itemCount: colors.length,
          itemBuilder: (context, index) {
            final colorData = colors[index];
            return GestureDetector(
              onTap: () {
                onColorSelected(colorData['color']);
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: colorData['color'],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Center(
                  child: Text(
                    colorData['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}