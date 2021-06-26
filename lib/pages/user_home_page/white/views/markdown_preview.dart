import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// 预览markdown
class MarkDownPreview extends StatelessWidget {
  final String data;
  const MarkDownPreview({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('预览'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MarkdownBody(data: data)
          ],
        ),
      ),
    );
  }
}
