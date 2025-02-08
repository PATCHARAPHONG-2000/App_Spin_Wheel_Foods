import 'package:flutter/material.dart';
import 'package:app_spinning_wheel/themes/colors.dart';

class Showavatarselection extends StatefulWidget {
  const Showavatarselection({super.key});

  @override
  State<Showavatarselection> createState() => _ShowavatarselectionState();
}

class _ShowavatarselectionState extends State<Showavatarselection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('เลือก Avatar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                String avatarPath = 'assets/images/avatar_$index.png';
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context, avatarPath);
                  },
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: primaryLight,
                      backgroundImage: AssetImage(avatarPath),
                      radius: 40,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
