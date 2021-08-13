// Flutter imports:
import 'package:flutter/material.dart';

/// 价钱布局
class PriceLayout extends StatelessWidget {
  final String original; // 原价
  final String discounts; // 优惠价
  const PriceLayout({Key? key, required this.original, required this.discounts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Row(
        children: [
          Text('¥ $original', style: TextStyle(fontSize: 12, color: Colors.red)),
          SizedBox(width: 12),
          if (discounts.isNotEmpty)
            Expanded(
              child: Text('¥$discounts', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.grey, decoration: TextDecoration.lineThrough)),
            )
        ],
      ),
    );
  }
}
