import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class DanaDonasiLangsung {
  final dynamic totalBudgets;
  final dynamic totalDonaturs;

  DanaDonasiLangsung({
    required this.totalBudgets,
    required this.totalDonaturs,
  });
}

class TotalDanaDonasi extends StatelessWidget {
  final DanaDonasiLangsung danaDonasiLangsung;
  final VoidCallback onAddPressed;

  const TotalDanaDonasi({
    Key? key,
    required this.danaDonasiLangsung,
    required this.onAddPressed,
  }) : super(key: key);

  String formatCurrency(int amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total dana donasi langsung',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Gap(4),
                Text(
                  formatCurrency(danaDonasiLangsung.totalBudgets),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Gap(4),
                Row(
                  children: [
                    Text(
                      '${NumberFormat.decimalPattern('id_ID').format(danaDonasiLangsung.totalDonaturs)} ',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'penyumbang',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // IconButton(
            //   onPressed: onAddPressed,
            //   icon: Container(
            //     padding: const EdgeInsets.all(8),
            //     decoration: BoxDecoration(
            //       color: Color(0xff4B76D9),
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     child: const Icon(
            //       Icons.add,
            //       color: Colors.white,
            //       size: 45,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
