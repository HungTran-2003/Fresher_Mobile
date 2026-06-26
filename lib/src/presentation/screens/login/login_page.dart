import 'package:crud_app/src/core/assets/app_vectors.dart';
import 'package:crud_app/src/core/utils/app_validators.dart';
import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_loading_overlay.dart';
import 'package:crud_app/src/presentation/widgets/images/app_svg_image.dart';
import 'package:crud_app/src/presentation/widgets/inputs/buttons/app_button_wrapper.dart';
import 'package:crud_app/src/presentation/widgets/inputs/buttons/app_filled_button.dart';
import 'package:crud_app/src/presentation/widgets/inputs/buttons/app_outlined_button.dart';
import 'package:crud_app/src/presentation/widgets/inputs/text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginChildPage();
  }
}

class LoginChildPage extends StatefulWidget {
  const LoginChildPage({super.key});

  @override
  State<LoginChildPage> createState() => _LoginChildPageState();
}

class _LoginChildPageState extends State<LoginChildPage> {
  final _formKey = GlobalKey<FormState>();

  late final FocusNode _taxIdOrIdFocusNode;
  late final FocusNode _usernameFocusNode;
  late final FocusNode _passwordFocusNode;

  late final LoginController _controller;

  late final Worker _eventShowLoadingOverPlay;

  @override
  void initState() {
    super.initState();

    _taxIdOrIdFocusNode = FocusNode();
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    _controller = Get.find<LoginController>();
    _triggerLoadingOverlay();
  }

  @override
  void dispose() {
    _taxIdOrIdFocusNode.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _eventShowLoadingOverPlay.dispose();
    super.dispose();
  }

  void _triggerLoadingOverlay() {
    _eventShowLoadingOverPlay = ever(_controller.state.status, (status) {
      if (status == LoadStatus.loading) {
        AppLoadingOverlay.show(context);
      } else {
        AppLoadingOverlay.hide();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 12, 0),
          child: _buildBodyPage(context),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _buildBottomUtilities(context),
        ),
      ),
    );
  }

  Widget _buildBodyPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSvgImage(AppVectors.logoApp, height: 37, width: 158),
          const SizedBox(height: 24),

          _buildFormLogin(),
          const SizedBox(height: 20),

          _buildLoginButton(context),
        ],
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Obx(() {
      return Row(
        spacing: 12,
        children: [
          Expanded(
            child: AppFilledButton(
              title: context.s.logIn,
              color: context.colors.primaryLight,
              borderRadius: 12.0,
              titleStyle: context.textThemes.body16Semi.copyWith(
                color: Colors.white,
              ),
              boxShadow: [
                BoxShadow(
                  color: context.colors.btnShadow.withValues(alpha: 0.4),
                  offset: const Offset(1, 1),
                  blurRadius: 23.3,
                  spreadRadius: 0,
                ),
              ],
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await _controller.submitLogin();
                } else {
                  _controller.changeIsFirstSubmit(true);
                }
              },
            ),
          ),
          if (_controller.state.useBiometrics.value)
            AppButtonWrapper(
              onPressed: () async {
                await _controller.loginWithBiometrics();
              },
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: context.colors.grayLight7),
                  borderRadius: BorderRadius.circular(12),
                  color: context.colors.surfaceContainer,
                ),
                child: Icon(
                  Icons.fingerprint,
                  color: context.colors.primaryLight,
                  size: 28,
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget _buildFormLogin() {
    return Obx(() {
      return AutofillGroup(
        child: Form(
          key: _formKey,
          autovalidateMode: _controller.state.isFirstSubmit.value
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: Column(
            spacing: 4,
            children: [
              AppTextField(
                controller: _controller.taxIdOrIdController,
                focusNode: _taxIdOrIdFocusNode,
                labelText: context.s.taxIdOrIdLabel,
                hintText: context.s.taxIdOrIdHint,
                keyboardType: TextInputType.number,
                showClearButton: true,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\-]')),
                ],
                onChanged: (val) => _controller.onTaxIdOrIdChanged(val),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_usernameFocusNode),
                validator: (val) =>
                    AppValidators.validateTaxIdOrId(context, val),
              ),

              AppTextField(
                controller: _controller.usernameController,
                focusNode: _usernameFocusNode,
                labelText: context.s.usernameLabel,
                hintText: context.s.usernameHint,
                maxLines: 1,
                showClearButton: true,
                autofillHints: const [AutofillHints.username],
                onChanged: (val) => _controller.onUsernameChanged(val),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_passwordFocusNode),
                validator: (val) =>
                    AppValidators.validateUsername(context, val),
              ),

              AppTextField(
                controller: _controller.passwordController,
                focusNode: _passwordFocusNode,
                labelText: context.s.passwordHint,
                hintText: context.s.passwordHint,
                isSecure: true,
                showClearButton: true,
                autofillHints: const [AutofillHints.password],
                onChanged: (val) => _controller.onPasswordChanged(val),
                onFieldSubmitted: (_) async {
                  if (_formKey.currentState!.validate()) {
                    await _controller.submitLogin();
                  } else {
                    _controller.changeIsFirstSubmit(true);
                  }
                },
                validator: (val) =>
                    AppValidators.validateLoginPassword(context, val),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBottomUtilities(BuildContext context) {
    final outlineColor = context.colors.grayLight7;
    final textStyle = context.textThemes.des12Semi;

    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: AppOutlinedButton(
            borderColor: outlineColor,
            borderRadius: 6,
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                AppSvgImage(
                  AppVectors.icHeadPhone,
                  height: 24.0,
                  width: 24.0,
                  colorFilter: ColorFilter.mode(
                    context.colors.primaryLight,
                    BlendMode.srcIn,
                  ),
                ),
                Text(context.s.support, style: textStyle),
              ],
            ),
          ),
        ),
        Expanded(
          child: AppOutlinedButton(
            borderColor: outlineColor,
            borderRadius: 6,
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                AppSvgImage(
                  AppVectors.icFacebook,
                  height: 24.0,
                  width: 24.0,
                  colorFilter: ColorFilter.mode(
                    context.colors.primaryLight,
                    BlendMode.srcIn,
                  ),
                ),
                Text(context.s.group, style: textStyle),
              ],
            ),
          ),
        ),
        Expanded(
          child: AppOutlinedButton(
            borderColor: outlineColor,
            borderRadius: 6,
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                AppSvgImage(
                  AppVectors.icSearch,
                  height: 24.0,
                  width: 24.0,
                  colorFilter: ColorFilter.mode(
                    context.colors.primaryLight,
                    BlendMode.srcIn,
                  ),
                ),
                Text(context.s.lookup, style: textStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
