import 'package:finance/src/core/assets/app_vectors.dart';
import 'package:finance/src/core/theme/app_theme.dart';
import 'package:finance/src/core/utils/extensions/context_extensions.dart';
import 'package:finance/src/presentation/widgets/images/app_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final List<String>? autofillHints;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final EdgeInsets? padding;
  final TextStyle? errorStyle;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool enable;
  final int? maxLines;
  final bool? alignLabelWithHint;
  final TextAlign? textAlign;
  final bool? readOnly;
  final int? maxLength;
  final double? borderRadius;
  final Color? backgroundColor;
  final bool isSecure;
  final bool isFilled;

  const AppTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.autofillHints = const [],
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.hintStyle,
    this.style,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.padding,
    this.errorStyle,
    this.validator,
    this.keyboardType,
    this.inputFormatters = const [],
    this.enable = true,
    this.maxLines,
    this.alignLabelWithHint,
    this.textAlign,
    this.readOnly,
    this.maxLength,
    this.borderRadius,
    this.backgroundColor,
    this.isSecure = false,
    this.isFilled = true,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  late bool _isInternalFocusNode;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _isInternalFocusNode = widget.focusNode == null;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_onFocusChange);
      if (_isInternalFocusNode) {
        _focusNode.dispose();
      }

      _isInternalFocusNode = widget.focusNode == null;
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChange);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (_isInternalFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        if (widget.labelText != null && widget.labelText!.isNotEmpty) ...{
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              widget.labelText!,
              style:
                  widget.labelStyle ??
                  AppTheme.of(context).appTextTheme.bodyLarge.copyWith(
                    color: _focusNode.hasFocus
                        ? (widget.focusedBorderColor ??
                              AppTheme.of(context).appColorScheme.primary)
                        : null,
                  ),
            ),
          ),
        },
        TextSelectionTheme(
          data: TextSelectionThemeData(
            selectionColor: AppTheme.of(
              context,
            ).appColorScheme.primaryContainer.withValues(alpha: 0.5),
            selectionHandleColor: AppTheme.of(
              context,
            ).appColorScheme.primaryContainer,
            cursorColor: AppTheme.of(context).appColorScheme.primaryContainer,
          ),
          child: TextFormField(
            controller: widget.controller,
            autofillHints: widget.autofillHints,
            maxLength: widget.maxLength,
            focusNode: _focusNode,
            style:
                widget.style ??
                context.textThemes.bodyLarge.copyWith(
                  color: context.colors.textField,
                ),
            inputFormatters: [
              ...(widget.inputFormatters ??
                  [LengthLimitingTextInputFormatter(255)]),
            ],
            decoration: InputDecoration(
              isDense: true,
              filled: widget.isFilled,
              fillColor:
                  widget.backgroundColor ??
                  AppTheme.of(context).appColorScheme.onPrimary,
              alignLabelWithHint: widget.alignLabelWithHint,
              contentPadding:
                  widget.padding ??
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              hintText: widget.hintText,
              hintStyle:
                  widget.hintStyle ??
                  context.textThemes.bodyLarge.copyWith(
                    color: context.colors.textField.withValues(alpha: 0.5),
                  ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 20),
                ),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 20),
                ),
                borderSide: BorderSide.none,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 20),
                ),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 20),
                ),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 20),
                ),
                borderSide: BorderSide.none,
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon:
                  widget.suffixIcon ??
                  (widget.isSecure ? _buildSuffixIcon() : null),
            ),
            keyboardType: widget.keyboardType,
            onFieldSubmitted: widget.onFieldSubmitted,
            obscureText: widget.isSecure ? _obscureText : false,
            validator: widget.validator,
            onChanged: widget.onChanged,
            enabled: widget.enable,
            maxLines: widget.isSecure ? 1 : widget.maxLines,
            readOnly: widget.readOnly ?? false,
            textAlign: widget.textAlign ?? TextAlign.start,
            cursorColor: AppTheme.of(context).appColorScheme.primaryContainer,
          ),
        ),
      ],
    );
  }

  Widget _buildSuffixIcon() {
    return IconButton(
      splashRadius: 24,
      onPressed: _toggleObscure,
      icon: _obscureText
          ? AppSvgImage(
              AppVectors.icVisibilityOff,
              height: 10,
              width: 10,
              colorFilter: ColorFilter.mode(
                AppTheme.of(context).appColorScheme.textField,
                BlendMode.srcIn,
              ),
            )
          : AppSvgImage(
              AppVectors.icVisibility,
              height: 10,
              width: 10,
              colorFilter: ColorFilter.mode(
                AppTheme.of(context).appColorScheme.textField,
                BlendMode.srcIn,
              ),
            ),
    );
  }
}
