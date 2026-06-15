import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AppBackButton extends StatelessWidget {
  final String? fallbackRoute;
  final bool Function()? isShowValidateDialog;
  final Future<void> Function()? beforeBackAction;
  final VoidCallback? onTap;
  final Color? color;

  const AppBackButton({
    super.key,
    this.fallbackRoute,
    this.isShowValidateDialog,
    this.beforeBackAction,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
          return;
        }
        _safePop(context);
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: Center(child: SvgPicture.asset('', width: 7, height: 16)),
      ),
    );
  }

  void _safePop(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      log('cannot pop');
    }
  }
}
