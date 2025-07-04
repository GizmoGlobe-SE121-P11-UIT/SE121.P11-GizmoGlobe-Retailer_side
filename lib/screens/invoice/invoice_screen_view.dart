import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gizmoglobe_client/generated/l10n.dart';
import 'package:gizmoglobe_client/screens/invoice/incoming/incoming_screen_view.dart';
import 'package:gizmoglobe_client/screens/invoice/invoice_screen_cubit.dart';
import 'package:gizmoglobe_client/screens/invoice/invoice_screen_state.dart';
import 'package:gizmoglobe_client/screens/invoice/sales/sales_screen_view.dart';
import 'package:gizmoglobe_client/screens/invoice/warranty/warranty_screen_view.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  static Widget newInstance() => BlocProvider(
        create: (context) => InvoiceScreenCubit(),
        child: const InvoiceScreen(),
      );

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceScreenCubit, InvoiceScreenState>(
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
                backgroundColor: Colors.transparent,
                elevation: 0,
                bottom: TabBar(
                  onTap: (index) {
                    context.read<InvoiceScreenCubit>().changeTab(index);
                  },
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor:
                      Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(text: S.of(context).sales),
                    Tab(text: S.of(context).incoming),
                    Tab(text: S.of(context).warranty),
                  ],
                ),
              ),
              body: SafeArea(
                child: IndexedStack(
                  index: state.selectedTabIndex,
                  children: [
                    SalesScreen.newInstance(),
                    IncomingScreen.newInstance(),
                    WarrantyScreen.newInstance(),
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
