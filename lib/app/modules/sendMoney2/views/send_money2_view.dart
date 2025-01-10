import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/send_money2_controller.dart';

class SendMoney2View extends GetView<SendMoney2Controller> {
  const SendMoney2View({super.key});
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Color(0xFF4285F4),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Kirim Uang',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Grey placeholder container
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(height: 16),
            // Upload button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add image upload logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4285F4),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'UNGGAH GAMBAR INI',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            // Change image button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Add change image logic here
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'UBAH GAMBAR',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
