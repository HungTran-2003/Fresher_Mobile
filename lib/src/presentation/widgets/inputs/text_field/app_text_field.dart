import 'package:crud_app/src/core/assets/app_vectors.dart';
import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/presentation/widgets/images/app_svg_image.dart';
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
  final bool showClearButton;

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
    this.isFilled = false,
    this.showClearButton = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  late bool _isInternalFocusNode;
  bool _obscureText = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _isInternalFocusNode = widget.focusNode == null;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_onTextChanged);
      widget.controller.addListener(_onTextChanged);
    }
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
    widget.controller.removeListener(_onTextChanged);
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
      children: [
        if (widget.labelText != null && widget.labelText!.isNotEmpty) ...{
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              widget.labelText!,
              style:
                  widget.labelStyle ??
                  context.textThemes.body16Bo,
            ),
          ),
        },
        TextSelectionTheme(
          data: TextSelectionThemeData(
            selectionColor: context.colors.primaryLight.withValues(alpha: 0.5),
            selectionHandleColor: context.colors.primaryLight,
            cursorColor: context.colors.primaryLight,
          ),
          child: TextFormField(
            controller: widget.controller,
            autofillHints: widget.autofillHints,
            maxLength: widget.maxLength,
            focusNode: _focusNode,
            style:
                widget.style ??
                context.textThemes.body16Semi,
            inputFormatters: [
              ...(widget.inputFormatters ??
                  [LengthLimitingTextInputFormatter(255)]),
            ],
            decoration: InputDecoration(
              isDense: true,
              filled: widget.isFilled,
              fillColor: widget.backgroundColor,
              alignLabelWithHint: widget.alignLabelWithHint,
              contentPadding:
                  widget.padding ??
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              hintText: widget.hintText,
              hintStyle:
                  widget.hintStyle ??
                  context.textThemes.body16Semi.copyWith(
                    color: context.colors.grayLight3,
                  ),
              errorStyle: const TextStyle(fontSize: 0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 6),
                ),
                borderSide: BorderSide(
                  color: context.colors.black0,
                  width: 1
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 6),
                ),
                borderSide: BorderSide(
                    color: context.colors.grayLight7,
                    width: 1
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 6),
                ),
                borderSide:  BorderSide(
                    color: context.colors.grayLight7,
                    width: 1
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 6),
                ),
                borderSide:  BorderSide(
                    color: context.colors.grayLight7,
                    width: 1
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 6),
                ),
                borderSide:  BorderSide(
                    color: context.colors.primaryLight,
                    width: 1
                ),
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon:
                  widget.suffixIcon ??
                  _buildSuffixIcon(),
            ),
            keyboardType: widget.keyboardType,
            onFieldSubmitted: widget.onFieldSubmitted,
            obscureText: widget.isSecure ? _obscureText : false,
            validator: (value) {
              final result = widget.validator?.call(value);
              if (result != _errorMessage) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _errorMessage = result;
                    });
                  }
                });
              }
              return result;
            },
            onChanged: widget.onChanged,
            enabled: widget.enable,
            maxLines: widget.isSecure ? 1 : widget.maxLines,
            readOnly: widget.readOnly ?? false,
            textAlign: widget.textAlign ?? TextAlign.start,
            cursorColor: context.colors.primaryLight,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            _errorMessage ?? ' ',
            textAlign: TextAlign.right,
            style: widget.errorStyle ??
                context.textThemes.des12Re.copyWith(
                  color: context.colors.errorContainer,
                ),
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    final showClear = widget.showClearButton && widget.controller.text.isNotEmpty;
    final showSecure = widget.isSecure && widget.controller.text.isNotEmpty;

    if (!showClear && !showSecure) {
      return null;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (showClear)
          IconButton(
            onPressed: (){
              widget.controller.clear();
              if (widget.onChanged != null) {
                widget.onChanged!('');
              }
            },
            icon: AppSvgImage(
              AppVectors.icClear,
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(
                context.colors.grayLight6,
                BlendMode.srcIn,
              ),
            ),
          ),
        if (showSecure)
          IconButton(
            onPressed: _toggleObscure,
            icon: _obscureText
                ? AppSvgImage(
                    AppVectors.icVisibilityOff,
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode(
                      context.colors.grayLight6,
                      BlendMode.srcIn,
                    ),
                  )
                : AppSvgImage(
                    AppVectors.icVisibility,
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode(
                      context.colors.grayLight6,
                      BlendMode.srcIn,
                    ),
                  ),
          ),
      ],
    );
  }
}
