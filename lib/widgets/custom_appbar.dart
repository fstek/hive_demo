import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.appTitle,
  }) : super(key: key);
  final String appTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        appTitle,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55.0);
}
