// lib/screens/main/main_screen/main_screen_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gizmoglobe_client/generated/l10n.dart';
import 'package:gizmoglobe_client/screens/stakeholder/customers/customers_screen_view.dart';
import 'package:gizmoglobe_client/screens/stakeholder/employees/employees_screen_view.dart';
import 'package:gizmoglobe_client/screens/stakeholder/stakeholder_screen_cubit.dart';
import 'package:gizmoglobe_client/screens/stakeholder/stakeholder_screen_state.dart';
import 'package:gizmoglobe_client/screens/stakeholder/vendors/vendors_screen_view.dart';

class StakeholderScreen extends StatefulWidget {
  const StakeholderScreen({super.key});

  static Widget newInstance() => BlocProvider(
        create: (context) => StakeholderScreenCubit(),
        child: const StakeholderScreen(),
      );

  @override
  State<StakeholderScreen> createState() => _StakeholderScreenState();
}

class _StakeholderScreenState extends State<StakeholderScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StakeholderScreenCubit, StakeholderScreenState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 0,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(48),
                  child: TabBar(
                    onTap: (index) {
                      context.read<StakeholderScreenCubit>().changeTab(index);
                    },
                    labelColor: Theme.of(context).colorScheme.primary,
                    unselectedLabelColor: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7), 
                    indicatorColor: Theme.of(context).colorScheme.primary,
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(text: S.of(context).customers),
                      Tab(text: S.of(context).employees),
                      Tab(text: S.of(context).vendors),
                    ],
                  ),
                ),
              ),
              body: SafeArea(
                child: IndexedStack(
                  index: state.selectedTabIndex,
                  children: [
                    CustomersScreen.newInstance(),
                    EmployeesScreen.newInstance(),
                    VendorsScreen.newInstance(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
