import 'package:dompet_mal/app/modules/(admin)/transactions/controllers/transactions_controller.dart';
import 'package:dompet_mal/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget laporanCard(BuildContext context, bankName, harga, tanggal) {
  final num formattedHarga =
      harga is num ? harga : num.tryParse(harga.toString()) ?? 0;

  final NumberFormat currencyFormat = NumberFormat('#,##0', 'id_ID');

  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.only(bottom: 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.0),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            color: Colors.white,
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/icons/dompet.png'),
                          Gap(8),
                          Text(
                            'Dompet Mal',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        DateFormat('dd MMMM yyyy').format(tanggal),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Pecairan Dana Rp ${currencyFormat.format(formattedHarga)}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Ke rekening ${bankName} **** **** ****\n0060 a/n PEDULI SAHABAT',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
