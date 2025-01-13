import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class appbar2 extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color color;
  final Color titleColor;
  final Color iconColor;
  final bool isIconMore;

  const appbar2({
    Key? key,
    required this.title,
    required this.color,
    this.titleColor = Colors.black,
    this.isIconMore = false,
    this.iconColor = Colors.black,
  }) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(60);
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: iconColor,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        title,
        style: TextStyle(color: titleColor),
      ),
      actions: [
        isIconMore
            ? Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // Tambahkan logika untuk ikon titik tiga di sini
                    showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(100, 60, 20, 0),
                      items: [
                        PopupMenuItem(
                          value: 'option1',
                          child: Text('Option 1'),
                        ),
                        PopupMenuItem(
                          value: 'option2',
                          child: Text('Option 2'),
                        ),
                      ],
                    );
                  },
                ),
              )
            : Gap(0),
      ],

      // elevation: 4, // Adds shadow
      // shadowColor: Colors.black.withOpacity(0.3), // Custom shadow color
      backgroundColor: color, // White background
      // foregroundColor: Colors.black,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}