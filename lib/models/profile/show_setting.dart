import 'package:flutter/material.dart';

import '../../themes/colors.dart';

class ShowSetting extends StatelessWidget {
  const ShowSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.5, // 50% ของหน้าจอ
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('ตั้งค่า',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ListTile(
            leading: Icon(Icons.language, color: primaryText),
            title: Text('ภาษา', style: TextStyle(color: primaryText)),
            subtitle: Text('ไทย', style: TextStyle(color: primaryText)),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
              activeColor: primary,
              inactiveThumbColor: primaryLight,
            ),
          ),
          ListTile(
            leading: Icon(Icons.dark_mode, color: primaryText),
            title: Text('ธีม', style: TextStyle(color: primaryText)),
            subtitle: Text('เปิด', style: TextStyle(color: primaryText)),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
              activeColor: primary,
              inactiveThumbColor: primaryLight,
            ),
          ),
          ListTile(
            leading: Icon(Icons.notifications, color: primaryText),
            title: Text('การแจ้งเตือน', style: TextStyle(color: primaryText)),
            subtitle: Text('เปิด', style: TextStyle(color: primaryText)),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
              activeColor: primary,
              inactiveThumbColor: primaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
