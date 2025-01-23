import 'package:dompet_mal/app/modules/(admin)/transactions/controllers/transactions_controller.dart';
import 'package:dompet_mal/color/color.dart';
import 'package:dompet_mal/component/AppBar.dart';
import 'package:dompet_mal/component/laporanCard.dart';
import 'package:dompet_mal/component/reportList.dart';
import 'package:dompet_mal/models/TransactionModel.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});
  @override
  Widget build(BuildContext context) {
    final TransactionsController transactionsController =
        Get.put(TransactionsController());
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color(0xfff7f7f7),
        appBar: appbar2(
          title: 'Laporan Dompet Mal',
          color: Colors.white,
          isIconMore: true,
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(top: 16, bottom: 0, left: 16, right: 16),
              width: lebar,
              height: tinggi * 0.8,
              child: Obx(
                () {
                  if (transactionsController.transactions.value.isNotEmpty) {
                    return ListView.builder(
                      itemCount:
                          transactionsController.transactions.value.length,
                      itemBuilder: (context, index) {
                        final Transaction transaksi =
                            transactionsController.transactions.value[index];
                        final tanggal = transaksi.createdAt!;
                        final bank = transactionsController.banks
                            .firstWhere((bank) => bank.id == transaksi.bankId)
                            .name;
                        final harga =
                            transaksi.donationPrice!.toStringAsFixed(0);

                        return laporanCard(context, bank, harga, tanggal);
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )),
        ));
  }
}
