import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomCard extends StatelessWidget {
  final IconData iconData;
  final String text;
  final bool completed;

  const CustomCard({super.key, 
    required this.iconData,
    required this.text,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 42.0,
            color: const Color(0xFF032174),
          ),
          const Spacer(),
          const SizedBox(width: 10.0),
          Text(
            text,
            style: GoogleFonts.lexend(
              fontSize: 22.0,
            ),
          ),
          const Spacer(),
          if (completed)
            const Icon(
              Icons.check_circle_outline,
              color: Color(0xFF032174),
              size: 30.0,
            )
          else
            const Icon(
              Icons.more_horiz,
              color: Color(0xFF032174),
              size: 30.0,
            ),
        ],
      ),
    );
  }
}

