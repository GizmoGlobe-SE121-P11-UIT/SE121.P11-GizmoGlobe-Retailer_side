import 'package:flutter/material.dart';
import 'package:gizmoglobe_client/objects/manufacturer.dart';
import 'package:gizmoglobe_client/widgets/general/app_text_style.dart';
import 'package:gizmoglobe_client/widgets/general/checkbox_button.dart';
import 'package:gizmoglobe_client/generated/l10n.dart';

class ManufacturerFilter extends StatelessWidget {
  final List<Manufacturer> selectedManufacturers;
  final List<Manufacturer> manufacturerList;
  final void Function(Manufacturer manufacturer) onToggleSelection;

  const ManufacturerFilter({
    super.key,
    required this.selectedManufacturers,
    required this.manufacturerList,
    required this.onToggleSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).manufacturer,
          style: AppTextStyle.bigText.copyWith(
            color: Theme.of(context).primaryColor,
          ),
        ),
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: manufacturerList.map((manufacturer) {
            return SizedBox(
              width: (MediaQuery.of(context).size.width - 48) / 2,
              child: CheckboxButton(
                text: manufacturer.manufacturerName,
                isSelected: selectedManufacturers.contains(manufacturer),
                onSelected: () {
                  onToggleSelection(manufacturer);
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
