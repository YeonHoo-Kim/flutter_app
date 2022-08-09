import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TaskCheck extends StatelessWidget {
  final String? text;
  final bool? isDone;
  const TaskCheck({Key? key, this.text, this.isDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 8,
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: (isDone ?? false)
                  ? const Color(0xFF7349FE)
                  : Colors.transparent,
              border: (isDone ?? false)
                  ? null
                  : Border.all(color: Color(0xFF868290), width: 1.5),
            ),
            child: Image(
              image: AssetImage('assets/images/check_icon.png'),
            ),
          ),
          Flexible(
            child: Text(
              text ?? "(Unnamed Todo)",
              style: TextStyle(
                color:
                    (isDone ?? false) ? Color(0xFF211551) : Color(0xFF868290),
                fontSize: 16,
                fontWeight:
                    (isDone ?? false) ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
