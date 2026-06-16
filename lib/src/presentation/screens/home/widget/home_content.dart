import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:crud_app/src/presentation/widgets/images/app_asset_image.dart';
import '../home_cubit.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            // Custom AppBar with Logout action on the top right
            AppBar(
              title: Text(
                context.s.appName,
                style: context.textThemes.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  icon: Icon(Icons.logout, color: context.colors.errorText),
                  tooltip: context.s.logout,
                  onPressed: () => context.read<HomeCubit>().logout(context),
                ),
              ],
            ),
            
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Card(
                    elevation: 4,
                    shadowColor: context.colors.outline.withValues(alpha: 0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    color: context.colors.surfaceContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Round Profile Avatar Wrapper
                          ClipRRect(
                            borderRadius: BorderRadius.circular(48.0),
                            child: const AppAssetImage(
                              'assets/images/profile_avatar.png',
                              width: 96.0,
                              height: 96.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          
                          const SizedBox(height: 24.0),
                          
                          // User Full Name Display
                          Text(
                            state.fullName.isNotEmpty ? state.fullName : 'Guest User',
                            style: context.textThemes.headlineSmall.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.colors.onSurface,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          
                          const SizedBox(height: 8.0),
                          
                          // Username Display
                          Text(
                            '@${state.username}',
                            style: context.textThemes.bodyMedium.copyWith(
                              color: context.colors.onSurface.withValues(alpha: 0.6),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
