import 'package:flutter/material.dart';

import '../../themes/colors.dart';

class ShowEmail extends StatelessWidget {
  const ShowEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // กำหนดความสูง
      padding: EdgeInsets.all(24), // เพิ่ม padding ให้มากขึ้น
      decoration: BoxDecoration(
        color: Colors.white, // สีพื้นหลัง
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(20)), // ปรับมุมโค้งด้านบน
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // เงาเพื่อให้ดูมีมิติ
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // จัดเนื้อหาให้ชิดซ้าย
        children: [
          // หัวข้อ
          Text(
            'แก้ไขอีเมล',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryText,
            ),
          ),
          SizedBox(height: 25), // ระยะห่าง

          // ช่องกรอกอีเมล
          TextField(
            decoration: InputDecoration(
              labelText: 'อีเมลใหม่',
              labelStyle: TextStyle(color: primaryText),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryText.withOpacity(0.5)),
                borderRadius:
                    BorderRadius.circular(10), // ปรับมุมโค้งของช่องกรอก
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryText),
                borderRadius:
                    BorderRadius.circular(10), // ปรับมุมโค้งของช่องกรอก
              ),
            ),
          ),
          SizedBox(height: 20), // ระยะห่าง

          // ปุ่มบันทึก
          Center(
            child: ElevatedButton(
              onPressed: () {
                // ทำการบันทึกอีเมลใหม่
                Navigator.pop(context); // ปิด ModalBottomSheet
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary, // สีพื้นหลังปุ่ม
                padding: EdgeInsets.symmetric(
                    horizontal: 40, vertical: 12), // ขนาดปุ่ม
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // ปรับมุมโค้งของปุ่ม
                ),
              ),
              child: Text(
                'บันทึก',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white, // สีข้อความปุ่ม
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
