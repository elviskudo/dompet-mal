import 'package:dompet_mal/color/color.dart';
import 'package:dompet_mal/component/AppBar.dart';
import 'package:dompet_mal/component/reportList.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});
  @override
  Widget build(BuildContext context) {
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
            child: ListView.builder(
              itemCount: donations.length,
              itemBuilder: (context, index) {
                final donation = donations[index];
                final date = DateTime.parse(donation['created_at']);
                final formattedDate =
                    DateFormat('d MMMM yyyy', 'id_ID').format(date);
                final formattedTotalDonasi = NumberFormat.currency(
                        locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
                    .format(donation['total_donasi']);

                return Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'icons/dompet.png',
                                  width: 32,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Dompet Mal',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            Text(
                              formattedDate,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        Gap(10),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.black26,
                        ),
                        Gap(14),
                        Text(
                          'Pencairan Dana $formattedTotalDonasi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Ke rekening Mandiri *** **** **** ****\n 0060 a/n PEDULI SAHABAT',
                          style: TextStyle(color: Colors.black87, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
