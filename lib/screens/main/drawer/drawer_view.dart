import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gizmoglobe_client/generated/l10n.dart';
import 'package:gizmoglobe_client/widgets/general/app_logo.dart';

import '../../../widgets/general/invisible_gradient_button.dart';
import '../main_screen/main_screen_cubit.dart';
import 'drawer_cubit.dart';
import 'drawer_state.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DrawerCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<DrawerCubit, DrawerState>(
      builder: (context, state) {
        if (state.isOpen) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Material(
              child: Container(
                width: 240,
                color: colorScheme.primaryContainer,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        const SizedBox(width: 24),
                        const AppLogo(height: 32),
                        const SizedBox(width: 16),
                        Expanded(
                          child: BlocBuilder<MainScreenCubit, MainScreenState>(
                            builder: (context, state) {
                              return Text(
                                '${S.of(context).hello} ${state.username}',
                                style: TextStyle(
                                  color: colorScheme.onSurface,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: state.categories.map((category) {
                          return ListTile(
                            title: Text(
                              category.getName(),
                              style: TextStyle(
                                color: colorScheme.onSurface,
                                fontSize: 16,
                              ),
                            ),
                            onTap: () {
                              // Handle category tap
                            },
                            visualDensity: VisualDensity.compact,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                          );
                        }).toList(),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).contactUs,
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'gizmoglobe@gg.com', // Email
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '0XXX-XXX-XXX', // Phone number
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    InvisibleGradientButton(
                      onPress: () {
                        cubit.logOut(context);
                      },
                      suffixIcon: Icons.logout,
                      text: S.of(context).logOut,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
