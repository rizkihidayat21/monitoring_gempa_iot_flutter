import 'package:flutter/material.dart';

class TemplateAppBar extends StatelessWidget {
  const TemplateAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red,
      title: const Text(
        "Monitoring Gempa Bumi",
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }
}
