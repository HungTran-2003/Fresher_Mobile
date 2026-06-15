import 'package:crud_app/src/core/utils/date_picker_utils.dart';
import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'app_text_field.dart';

class AppDateField extends StatefulWidget {
  final TextEditingController controller;
  final String? labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;

  const AppDateField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onTap,
    this.labelText,
    this.validator,
  });

  @override
  State<AppDateField> createState() => _AppDateFieldState();
}

class _AppDateFieldState extends State<AppDateField> {
  Future<void> _selectDate() async {
    final picked = await DatePickerUtils.showAppDatePicker(context);
    if (picked != null) {
      setState(() {
        widget.controller.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
      widget.onTap?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: _selectDate,
      child: AppTextField(
        controller: widget.controller,
        labelText: widget.labelText,
        hintText: widget.hintText,
        enable: false,
        readOnly: true,
        suffixIcon: Icon(
          LucideIcons.calendar,
          color: colors.onSurface.withValues(alpha: 0.6),
          size: 20,
        ),
        validator: widget.validator,
      ),
    );
  }
}
