import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dompet_mal/app/modules/(admin)/charityAdmin/controllers/charity_admin_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/contributorAdmin/controllers/contributor_admin_controller.dart';
import 'package:dompet_mal/app/modules/(admin)/transactions/controllers/transactions_controller.dart';
import 'package:dompet_mal/app/modules/(home)/notification/controllers/notification_controller.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:dompet_mal/app/modules/(home)/sendMoney2/controllers/send_money2_controller.dart';
import 'package:dompet_mal/color/color.dart';
import 'package:dompet_mal/models/CharityModel.dart';
import 'package:dompet_mal/models/TransactionModel.dart';
import 'package:dompet_mal/models/notification.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

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
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
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
                  style: GoogleFonts.poppins(
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

  Future<void> _createNotification(
      String userId, String charityTitle, int donationAmount) async {
    try {
      String formatRupiah(num value) {
        final formatter = NumberFormat.currency(
          locale: 'id_ID',
          symbol: 'Rp ',
          decimalDigits: 0,
        );
        return formatter.format(value);
      }

      final notification = NotificationModels(
        title: 'Donasi Berhasil',
        body:
            'Terima kasih! Donasi Anda sebesar ${formatRupiah(donationAmount)} untuk $charityTitle telah berhasil.',
        userId: userId,
        uniqueId: const Uuid().v4(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isDeleted: false,
      );
      final supabase = Supabase.instance.client;

      await supabase.from('notifications').insert(notification.toJson());

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
          channelKey: 'transaction_service',
          title: 'Donasi Berhasil',
          body:
              'Terima kasih! Donasi Anda sebesar ${formatRupiah(donationAmount)} untuk $charityTitle telah berhasil.',
          notificationLayout: NotificationLayout.Default,
        ),
      );
    } catch (e) {
      print('Error creating notification: $e');
    }
  }

  // Function to show success dialog
  Future<void> _showSuccessDialog(BuildContext context) async {
    final TransactionsController controller = Get.put(TransactionsController());
    final NotificationController notifController =
        Get.put(NotificationController());
    final CharityAdminController charityController =
        Get.put(CharityAdminController());

    final ContributorAdminController contributorController =
        Get.put(ContributorAdminController());
    final args = Get.arguments as Map<String, dynamic>;
    final transactionId = args?['idTransaksi'] as String? ?? '';
    final transactionNumber = args?['transactionNumber'] as String? ?? '';
    final charityId = args?['charityId'] as String? ?? '';
    final bankId = args?['bankId'] as String? ?? '';
    final int donationPrice = args?['donationPrice'] as int? ?? 0;
    final userId = args?['userId'] as String? ?? '';

    final updatedTransaction = Transaction(
      bankId: bankId,
      charityId: charityId,
      donationPrice: donationPrice,
      transactionNumber: transactionNumber,
      userId: userId,
      status: 3, // Update status to 3
      updatedAt: DateTime.now(),
    );
    try {
      // Update the transaction
      await controller.updateTransaction(updatedTransaction, transactionId);

      final charity =
          charityController.charities.firstWhere((c) => c.id == charityId);
      final currentTotal = charity.total ?? 0;
      final newTotal = currentTotal + donationPrice;

      // Calculate new progress percentage
      final targetTotal = charity.targetTotal ?? 1; // Prevent division by zero
      final newProgress = ((newTotal / targetTotal) * 100).toInt();

      // Update charity with new total and progress
      final updatedCharity = Charity(
        id: charityId,
        categoryId: charity.categoryId,
        companyId: charity.companyId,
        title: charity.title,
        description: charity.description,
        progress: newProgress,
        total: newTotal,
        // targetTotal: charity.targetTotal,
        targetDate: charity.targetDate,
        status: charity.status,
        updated_at: DateTime.now(),
      );

      // Update charity in database
      await charityController.updateCharityTotal(
          charityId, newTotal, newProgress);

      final existingContributor = await contributorController
          .checkExistingContributor(userId, charityId);
      if (existingContributor == null) {
        contributorController.selectedUserId.value = userId;
        contributorController.selectedCharityId.value = charityId;
        await contributorController.addContributor();
      }

      await _createNotification(
          userId, charity.title ?? 'Program Amal', donationPrice);

      await contributorController.fetchContributors();
      await contributorController.fetchCharity();
      await charityController.fetchCharitiesWithContributors();
      await charityController.calculateCharitySummary();
      await charityController.calculateCharitySummary();
      await notifController.loadNotifications();

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
                    style: GoogleFonts.poppins(
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
    } catch (e) {
      // Handle any errors that might occur during the update
      Get.snackbar(
        'Error',
        'Gagal mengupdate transaksi: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Function to handle upload process

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
          style: GoogleFonts.poppins(
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
                    : _handleUpload(context),
                child: Text(
                  controller.selectedImage.value == null
                      ? "UNGGAH BUKTI TRANSFER"
                      : "KIRIM BUKTI TRANSFER",
                  style: GoogleFonts.poppins(
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
                    style: GoogleFonts.poppins(
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
                onPressed: () => Get.toNamed(Routes.NAVIGATION),
                child: Text(
                  "KEMBALI KE BERANDA",
                  style: GoogleFonts.poppins(
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

  void _handleUpload(BuildContext context) async {
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
    await _showSuccessDialog(context);
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
    final args = Get.arguments as Map<String, dynamic>;
    final int donationPrice = args['donationPrice'] as int? ?? 0;
    Get.offNamed(
      Routes.PAYMENT_SUCCESS,
      arguments: {
        'donationPrice': donationPrice,
      },
    );
  }
}
