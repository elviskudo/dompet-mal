import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

final List<Map<String, dynamic>> donations = [
  {
    "id": 1,
    "created_at": "2021-11-12",
    "total_donasi": 53588950,
  },
  {
    "id": 2,
    "created_at": "2021-11-05",
    "total_donasi": 40588950,
  },
  {
    "id": 2,
    "created_at": "2022-11-05",
    "total_donasi": 12090044,
  },
  {
    "id": 2,
    "created_at": "2024-11-13",
    "total_donasi": 2323211,
  },
];

class ReportList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: donations.length,
        itemBuilder: (context, index) {
          final donation = donations[index];
          final date = DateTime.parse(donation['created_at']);
          final formattedDate = DateFormat('d MMMM yyyy', 'id_ID').format(date);
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
                                fontWeight: FontWeight.bold, fontSize: 16),
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
    );
  }
}
