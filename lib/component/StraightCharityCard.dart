import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });
}

class StraightCharity {
  final int id;
  final String uuid;
  final String title;
  final int categoryId;
  final Category category;
  final int totalCharities;
  final DateTime dateOfSubmission;
  final String imageUrl;

  StraightCharity({
    required this.id,
    required this.uuid,
    required this.title,
    required this.categoryId,
    required this.category,
    required this.totalCharities,
    required this.dateOfSubmission,
    required this.imageUrl,
  });
}

class StraightCharityComponent extends StatelessWidget {
  final StraightCharity charity;
  final VoidCallback onSeeMorePressed;

  const StraightCharityComponent({
    Key? key,
    required this.charity,
    required this.onSeeMorePressed,
  }) : super(key: key);

  String formatCurrency(int amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  String formatDate(DateTime date) {
    final formatter = DateFormat('d MMMM yyyy', 'id_ID');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 304,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Image.asset(
              charity.imageUrl,
              width: 180,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  charity.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  charity.category.name,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Dana yang disetorkan',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  formatCurrency(charity.totalCharities),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Waktu Penyerahan',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  formatDate(charity.dateOfSubmission),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Section extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;

  const Section({
    Key? key,
    required this.child,
    this.padding,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

class HorizontalScrollRow extends StatelessWidget {
  final List<Widget> items;
  final double spacing;

  const HorizontalScrollRow({
    Key? key,
    required this.items,
    this.spacing = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .asMap()
            .entries
            .map(
              (entry) => Padding(
                padding: EdgeInsets.only(
                    right: entry.key == items.length - 1 ? 0 : spacing),
                child: entry.value,
              ),
            )
            .toList(),
      ),
    );
  }
}
