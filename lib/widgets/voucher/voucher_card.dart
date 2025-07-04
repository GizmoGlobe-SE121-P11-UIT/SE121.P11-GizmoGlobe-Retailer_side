import 'package:flutter/material.dart';
import 'package:gizmoglobe_client/objects/voucher_related/voucher.dart';

class VoucherCard extends StatelessWidget {
  final Voucher voucher;
  final bool isSelected;

  const VoucherCard({
    super.key,
    required this.voucher,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: isSelected
          ? colorScheme.primary.withValues(alpha: 0.1) 
          : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: colorScheme.primary, width: 2.0)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Row(
          children: [
            Icon(
              Icons.card_giftcard,
              color: colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: voucher.detailsWidget(context),
            ),
          ],
        ),
      ),
    );
  }
}
