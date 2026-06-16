import 'package:crud_app/src/core/assets/app_vectors.dart';
import 'package:crud_app/src/core/utils/app_validators.dart';
import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/presentation/global/auth/auth_cubit.dart';
import 'package:crud_app/src/presentation/global/user/user_cubit.dart';
import 'package:crud_app/src/presentation/widgets/feedback/app_loading_overlay.dart';
import 'package:crud_app/src/presentation/widgets/images/app_svg_image.dart';
import 'package:crud_app/src/presentation/widgets/inputs/buttons/app_filled_button.dart';
import 'package:crud_app/src/presentation/widgets/inputs/buttons/app_outlined_button.dart';
import 'package:crud_app/src/presentation/widgets/inputs/text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud_app/src/domain/repositories/auth_repository.dart';
import 'login_cubit.dart';
import 'login_navigator.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) {
        final navigator = LoginNavigator(context);
        return LoginCubit(
          authCubit: context.read<AuthCubit>(),
          userCubit: context.read<UserCubit>(),
          authRepository: context.read<AuthRepository>(),
          navigator: navigator,
        );
      },
      child: const LoginChildPage(),
    );
  }
}

class LoginChildPage extends StatefulWidget {
  const LoginChildPage({super.key});

  @override
  State<LoginChildPage> createState() => _LoginChildPageState();
}

class _LoginChildPageState extends State<LoginChildPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _taxIdOrIdController;
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  late final FocusNode _taxIdOrIdFocusNode;
  late final FocusNode _usernameFocusNode;
  late final FocusNode _passwordFocusNode;

  late final LoginCubit _cubit;

  @override
  void initState() {
    super.initState();
    _taxIdOrIdController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    _taxIdOrIdFocusNode = FocusNode();
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    _cubit = context.read<LoginCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: BlocListener<LoginCubit, LoginState>(
          listenWhen: (prev, current) => prev.status != current.status,
          listener: (context, state) {
            if (state.status.isLoading) {
              AppLoadingOverlay.show(context);
            } else {
              AppLoadingOverlay.hide();
            }
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 12, 0),
            child: _buildBodyPage(context),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
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
          const SizedBox(height: 24,),
          _buildFormLogin(),
          const SizedBox(height: 20,),
          AppFilledButton(
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
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _cubit.submitLogin();
              } else {
                _cubit.changeIsFirstSubmit(true);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFormLogin() {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (prev, current) => prev.isFirstSubmit != current.isFirstSubmit,
      builder: (context, state) {
        return Form(
          key: _formKey,
          autovalidateMode: state.isFirstSubmit
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: Column(
            spacing: 4,
            children: [
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
                onChanged: (val) => _cubit.onTaxIdOrIdChanged(val),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_usernameFocusNode),
                validator: (val) =>
                    AppValidators.validateTaxIdOrId(context, val),
              ),

              AppTextField(
                controller: _usernameController,
                focusNode: _usernameFocusNode,
                labelText: context.s.usernameLabel,
                hintText: context.s.usernameHint,
                maxLines: 1,
                showClearButton: true,
                onChanged: (val) => _cubit.onUsernameChanged(val),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_passwordFocusNode),
                validator: (val) =>
                    AppValidators.validateUsername(context, val),
              ),

              AppTextField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                labelText: context.s.passwordHint,
                hintText: context.s.passwordHint,
                isSecure: true,
                showClearButton: true,
                onChanged: (val) => _cubit.onPasswordChanged(val),
                onFieldSubmitted: (_) {
                  if (_formKey.currentState!.validate()) {
                    _cubit.submitLogin();
                  } else {
                    _cubit.changeIsFirstSubmit(true);
                  }
                },
                validator: (val) =>
                    AppValidators.validateLoginPassword(context, val),
              ),
            ],
          ),
        );
      },
    );
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
