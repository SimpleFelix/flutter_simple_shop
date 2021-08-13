// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:badges/badges.dart';

class CouponDiscountShow extends StatelessWidget {
  final String value;

  const CouponDiscountShow({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value == '0') return Container();
    return Badge(
      borderRadius: BorderRadius.circular(2),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      badgeColor: Colors.red.withOpacity(.16),
      elevation: 0,
      badgeContent: Text(
        '$value元隐藏券',
        style: TextStyle(
          color: Colors.red,
          fontSize: 12,
        ),
      ),
      shape: BadgeShape.square,
      animationType: BadgeAnimationType.fade,
    );
  }
}
