import 'package:earthquake_detection_app/widgets/template_app_bar.dart';
import 'package:flutter/material.dart';

class PanduanScreen extends StatelessWidget {
  const PanduanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: TemplateAppBar(),
        ),
        body: Image.asset(
          "assets/images/img_panduan.jpeg",
          height: double.infinity,
        ),
      ),
    );
  }
}
