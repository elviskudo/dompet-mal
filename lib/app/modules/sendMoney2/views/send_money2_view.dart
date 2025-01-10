import 'package:dompet_mal/app/modules/sendMoney2/controllers/send_money2_controller.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/color/color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SendMoney2View extends GetView<SendMoney2Controller> {
  const SendMoney2View({super.key});

  // Function to show loading dialog
  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: Color(0xffC5D6FF)),
                  child: Image.asset(
                    'icons/dompet.png',
                    width: 22,
                    height: 18,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Sedang mengirim bukti transfer...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to show success dialog
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: basecolor,
                ),
                SizedBox(height: 20),
                Text(
                  'Bukti transfer terkirim',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to handle upload process
  void _handleUpload(BuildContext context) async {
    // Show loading dialog
    _showLoadingDialog(context);

    // Simulate upload process
    await Future.delayed(Duration(seconds: 2));

    // Close loading dialog
    Navigator.pop(context);

    // Show success dialog
    _showSuccessDialog(context);

    // Automatically close success dialog after 2 seconds
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);

    // Navigate to home or next screen
    Get.toNamed(Routes.HOME);
  }

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;
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
            Container(
              width: double.infinity,
              height: tinggi * 0.7,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: lebar,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: basecolor,
                  padding: EdgeInsets.all(24),
                ),
                onPressed: () => _handleUpload(context),
                child: const Text(
                  "UNGGAH BUKTI TRANSFER",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Gap(16),
            Container(
              width: lebar,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.all(24),
                  side: const BorderSide(color: Color.fromARGB(48, 49, 48, 54)),
                ),
                onPressed: () => Get.toNamed(Routes.HOME),
                child: const Text(
                  "KEMBALI KE BERANDA",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(160, 49, 48, 54),
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