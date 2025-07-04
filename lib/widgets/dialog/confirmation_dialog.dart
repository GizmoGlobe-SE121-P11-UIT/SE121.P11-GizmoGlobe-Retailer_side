import 'package:flutter/material.dart';
import '../general/app_text_style.dart';
import '../general/standard_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const ConfirmationDialog({
    super.key,
    this.title = '',
    this.content = '',
    this.confirmText = 'OK',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppTextStyle.smallTitle.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),

              Text(
                content,
                style: AppTextStyle.regularText.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StandardButton(
                    onPress: () {
                      Navigator.of(context).pop();
                      onConfirm?.call();
                    },
                    text: confirmText,
                    height: 40,
                    width: 120,
                  ),
                  const SizedBox(width: 8),

                  StandardButton(
                    color: Theme.of(context).colorScheme.secondary,
                    onPress: () {
                      Navigator.of(context).pop();
                      onCancel?.call();
                    },
                    text: cancelText,
                    height: 40,
                    width: 120,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}