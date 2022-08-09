import 'package:flutter/material.dart';

class Taskcard extends StatelessWidget {
  final String? title;
  final String? description;
  const Taskcard({Key? key, this.title, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '(Unnamed Task)',
            style: const TextStyle(
              color: Color(0xFF211551),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              description ?? 'No description added',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF868290),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
