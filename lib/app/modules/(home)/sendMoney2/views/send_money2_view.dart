import 'dart:io';
import 'package:dompet_mal/app/modules/(admin)/transactions/controllers/transactions_controller.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/app/modules/(home)/sendMoney2/controllers/send_money2_controller.dart';
import 'package:dompet_mal/color/color.dart';
import 'package:dompet_mal/models/TransactionModel.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SendMoney2View extends GetView<SendMoney2Controller> {
  SendMoney2View({super.key});

  // Function to show image source picker
  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Pilih Sumber Gambar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Camera option
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xffC5D6FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              size: 32,
                              color: basecolor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('Kamera'),
                        ],
                      ),
                    ),
                    // Gallery option
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xffC5D6FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.photo_library,
                              size: 32,
                              color: basecolor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('Galeri'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to pick image
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        controller.setSelectedImage(File(image.path));
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

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
                    color: Color(0xffC5D6FF),
                  ),
                  child: Image.asset(
                    'assets/icons/dompet.png',
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
  void _showSuccessDialog(BuildContext context, String transactionId) {
    final TransactionsController controller = Get.put(TransactionsController());
    controller.updateTransaction(Transaction(status: 3), transactionId);
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
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 50,
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

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;
    final args = Get.arguments as Map<String, dynamic>;
    final transactionId = args['transactionId'] as String;
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
            Obx(() => Container(
                  width: double.infinity,
                  height: tinggi * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: controller.selectedImage.value != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            controller.selectedImage.value!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Center(
                          child: Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey[600],
                          ),
                        ),
                )),
            SizedBox(height: 16),
            Container(
              width: lebar,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: basecolor,
                  padding: EdgeInsets.all(24),
                ),
                onPressed: () => controller.selectedImage.value == null
                    ? _showImageSourceDialog(context)
                    : _handleUpload(context, transactionId),
                child: Text(
                  controller.selectedImage.value == null
                      ? "UNGGAH BUKTI TRANSFER"
                      : "KIRIM BUKTI TRANSFER",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Gap(16),
            if (controller.selectedImage.value != null)
              Container(
                width: lebar,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.all(24),
                    side: BorderSide(color: Color.fromARGB(48, 49, 48, 54)),
                  ),
                  onPressed: () => _showImageSourceDialog(context),
                  child: Text(
                    "UBAH GAMBAR",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(160, 49, 48, 54),
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
                  side: BorderSide(color: Color.fromARGB(48, 49, 48, 54)),
                ),
                onPressed: () => Get.toNamed(Routes.HOME),
                child: Text(
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

  void _handleUpload(BuildContext context, String transactionId) async {
    if (controller.selectedImage.value == null) {
      Get.snackbar(
        'Error',
        'Silahkan pilih gambar terlebih dahulu',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    _showLoadingDialog(context);
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
    _showSuccessDialog(context, transactionId);
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);

    // Navigate to home or next screen
    Get.toNamed(Routes.PAYMENT_SUCCESS);
    Get.toNamed(Routes.HOME);
  }
}
