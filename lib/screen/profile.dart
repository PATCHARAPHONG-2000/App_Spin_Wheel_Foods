import 'package:flutter/material.dart';
import 'package:app_spinning_wheel/themes/colors.dart';

import '../models/profile/show_avatar.dart';
import '../models/profile/show_email.dart';
import '../models/profile/show_setting.dart';

class Profile extends StatefulWidget {
  final String title;

  const Profile({Key? key, required this.title}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String selectedAvatar = 'assets/images/avatar_0.png'; // Default avatar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: icons)),
        backgroundColor: primary,
        iconTheme: IconThemeData(color: icons),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return ShowSetting();
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: primaryLight,
                    radius: 55,
                    backgroundImage: AssetImage(selectedAvatar),
                  ),
                  Positioned(
                    top: 5,
                    right: 9,
                    child: GestureDetector(
                      onTap: () async {
                        final result = await showModalBottomSheet<String>(
                          context: context,
                          builder: (BuildContext context) {
                            return Showavatarselection();
                          },
                        );

                        if (result != null) {
                          setState(() {
                            selectedAvatar = result;
                          });
                        }
                      },
                      child: Icon(
                        Icons.edit,
                        size: 20,
                        color: primaryText,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 22),
              Text(
                'ควยปิยวัชร์ สุขสวัสดิ์',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: Divider(
                  height: 1,
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.email, color: primaryText),
                    title: Text('อีเมล', style: TextStyle(color: primaryText)),
                    subtitle: Text('8KQYU@example.com',
                        style: TextStyle(color: primaryText)),
                    trailing: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return ShowEmail();
                          },
                        );
                      },
                      child: Icon(
                        Icons.edit,
                        color: primaryText,
                        size: 20,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.restaurant_menu, color: primaryText),
                    title: Text('อาหารที่ชอบ',
                        style: TextStyle(color: primaryText)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ข้าวผัด', style: TextStyle(color: primaryText)),
                          Text('ส้มตำ', style: TextStyle(color: primaryText)),
                          Text('ไก่ทอด', style: TextStyle(color: primaryText)),
                        ],
                      ),
                    ),
                    trailing: Icon(Icons.edit, color: primaryText, size: 20),
                  ),
                  ListTile(
                    leading: Icon(Icons.cake, color: primaryText),
                    title: Text('ของหวานที่ชอบ',
                        style: TextStyle(color: primaryText)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('เค้ก', style: TextStyle(color: primaryText)),
                          Text('น้ำหวาน', style: TextStyle(color: primaryText)),
                          Text('ชานมไข่มุก',
                              style: TextStyle(color: primaryText)),
                        ],
                      ),
                    ),
                    trailing: InkWell(
                      child: Icon(
                        Icons.edit,
                        color: primaryText,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
