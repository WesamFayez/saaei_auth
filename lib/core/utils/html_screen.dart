import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlScreen extends StatelessWidget {
  final String htmlContent;
  const HtmlScreen({required this.htmlContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Message")),
      body: SingleChildScrollView(child: Html(data: htmlContent)),
    );
  }
}
