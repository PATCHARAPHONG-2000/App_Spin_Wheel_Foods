import 'package:flutter/material.dart';

class RoundeBotton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const RoundeBotton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
            constraints: BoxConstraints(minWidth: 88.0, minHeight: 36.0),
            alignment: Alignment.center,
            child: Container(
              height: 40.0,
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            )),
      ),
    );
  }
}
