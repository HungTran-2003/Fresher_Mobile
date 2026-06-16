import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:crud_app/src/core/assets/app_vectors.dart';
import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/core/utils/app_validators.dart';
import 'package:crud_app/src/presentation/widgets/images/app_svg_image.dart';
import 'package:crud_app/src/presentation/widgets/inputs/text_field/app_text_field.dart';
import 'package:crud_app/src/presentation/widgets/inputs/buttons/app_filled_button.dart';
import 'package:crud_app/src/presentation/widgets/inputs/buttons/app_outlined_button.dart';
import '../login_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _taxIdOrIdController;
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  late final FocusNode _taxIdOrIdFocusNode;
  late final FocusNode _usernameFocusNode;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _taxIdOrIdController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    _taxIdOrIdFocusNode = FocusNode();
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _taxIdOrIdController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();

    _taxIdOrIdFocusNode.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _onSubmit() {
    // Triggers manual validation checks on the Form
    final isValid = _formKey.currentState?.validate() ?? false;
    
    // Call cubit submitLogin logic
    context.read<LoginCubit>().submitLogin(
          context,
          taxIdOrId: _taxIdOrIdController.text,
          username: _usernameController.text,
          password: _passwordController.text,
        );
        
    // Re-check state validation after first submit to trigger onUserInteraction
    if (!isValid) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (prev, current) => prev.isFirstSubmit != current.isFirstSubmit,
      builder: (context, state) {
        return Form(
          key: _formKey,
          // Real-time error messages update after the first Login click
          autovalidateMode: state.isFirstSubmit
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24.0),
              
              // 1. App Logo EasyInvoice
              Center(
                child: AppSvgImage(
                  AppVectors.logoApp,
                  height: 64.0,
                  fit: BoxFit.contain,
                ),
              ),
              
              const SizedBox(height: 48.0),

              // 2. Tax ID / Citizen ID TextField
              AppTextField(
                controller: _taxIdOrIdController,
                focusNode: _taxIdOrIdFocusNode,
                labelText: context.s.taxIdOrIdLabel,
                hintText: context.s.taxIdOrIdHint,
                keyboardType: TextInputType.number,
                showClearButton: true,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\-]')),
                ],
                onChanged: (val) =>
                    context.read<LoginCubit>().onTaxIdOrIdChanged(context, val),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_usernameFocusNode),
                validator: (val) => AppValidators.validateTaxIdOrId(context, val),
              ),

              const SizedBox(height: 20.0),

              // 3. Username TextField
              AppTextField(
                controller: _usernameController,
                focusNode: _usernameFocusNode,
                labelText: context.s.usernameLabel,
                hintText: context.s.usernameHint,
                showClearButton: true,
                onChanged: (val) =>
                    context.read<LoginCubit>().onUsernameChanged(context, val),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_passwordFocusNode),
                validator: (val) => AppValidators.validateUsername(context, val),
              ),

              const SizedBox(height: 20.0),

              // 4. Password TextField
              AppTextField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                labelText: context.s.passwordHint,
                hintText: context.s.passwordHint,
                isSecure: true,
                showClearButton: true,
                onChanged: (val) =>
                    context.read<LoginCubit>().onPasswordChanged(context, val),
                onFieldSubmitted: (_) => _onSubmit(),
                validator: (val) =>
                    AppValidators.validateLoginPassword(context, val),
              ),

              const SizedBox(height: 32.0),

              // 5. Submit Login Button
              AppFilledButton(
                title: context.s.logIn,
                color: context.colors.orange,
                borderRadius: 12.0,
                titleStyle: context.textThemes.bodyLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                onPressed: _onSubmit,
              ),

              const SizedBox(height: 48.0),

              // 6. Bottom outlined utility row
              _buildBottomUtilities(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomUtilities(BuildContext context) {
    final outlineColor = context.colors.outline.withValues(alpha: 0.15);
    final textStyle = context.textThemes.bodySmall.copyWith(
      color: context.colors.onSurface,
      fontWeight: FontWeight.w500,
    );

    return Row(
      children: [
        Expanded(
          child: AppOutlinedButton(
            borderColor: outlineColor,
            borderRadius: 12.0,
            onPressed: () {}, // Placeholder action
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.headset_mic_outlined,
                  color: context.colors.orange,
                  size: 18.0,
                ),
                const SizedBox(width: 6.0),
                Text(context.s.support, style: textStyle),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: AppOutlinedButton(
            borderColor: outlineColor,
            borderRadius: 12.0,
            onPressed: () {}, // Placeholder action
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.facebook_outlined,
                  color: context.colors.orange,
                  size: 18.0,
                ),
                const SizedBox(width: 6.0),
                Text(context.s.group, style: textStyle),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: AppOutlinedButton(
            borderColor: outlineColor,
            borderRadius: 12.0,
            onPressed: () {}, // Placeholder action
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_outlined,
                  color: context.colors.orange,
                  size: 18.0,
                ),
                const SizedBox(width: 6.0),
                Text(context.s.lookup, style: textStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
