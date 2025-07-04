import 'package:flutter/material.dart';
import 'package:gizmoglobe_client/generated/l10n.dart';
import 'package:gizmoglobe_client/objects/manufacturer.dart';
import 'package:gizmoglobe_client/widgets/general/gradient_text.dart';

import '../../../../enums/stakeholders/manufacturer_status.dart';
import '../../../../widgets/general/gradient_icon_button.dart';

class VendorEditScreen extends StatefulWidget {
  final Manufacturer manufacturer;

  const VendorEditScreen({super.key, required this.manufacturer});

  @override
  State<VendorEditScreen> createState() => _VendorEditScreenState();
}

class _VendorEditScreenState extends State<VendorEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String manufacturerName;
  late ManufacturerStatus status;

  @override
  void initState() {
    super.initState();
    manufacturerName = widget.manufacturer.manufacturerName;
    status = widget.manufacturer.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText(text: S.of(context).editManufacturer), // Localized
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GradientIconButton(
          icon: Icons.chevron_left,
          onPressed: () => Navigator.pop(context),
          fillColor: Colors.transparent,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GradientIconButton(
              icon: Icons.check,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final updatedManufacturer = Manufacturer(
                    manufacturerID: widget.manufacturer.manufacturerID,
                    manufacturerName: manufacturerName,
                    status: status,
                  );
                  Navigator.pop(context, updatedManufacturer);
                }
              },
              fillColor: Colors.transparent,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).manufacturerInformation, // Localized
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          initialValue: manufacturerName,
                          decoration: InputDecoration(
                            labelText:
                                S.of(context).manufacturerName, // Localized
                            labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface),
                            floatingLabelStyle:
                                WidgetStateTextStyle.resolveWith(
                              (states) => TextStyle(
                                color: states.contains(WidgetState.focused)
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            prefixIcon: Icon(Icons.business,
                                color: Theme.of(context).colorScheme.onSurface),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                          onChanged: (value) => manufacturerName = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).pleaseEnterName; // Localized
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<ManufacturerStatus>(
                          value: status,
                          decoration: InputDecoration(
                            labelText: S.of(context).status, // Localized
                            labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface),
                            floatingLabelStyle:
                                WidgetStateTextStyle.resolveWith(
                              (states) => TextStyle(
                                color: states.contains(WidgetState.focused)
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            prefixIcon: Icon(Icons.info_outline,
                                color: Theme.of(context).colorScheme.onSurface),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                          dropdownColor: Theme.of(context).cardColor,
                          items: ManufacturerStatus.values.map((status) {
                            return DropdownMenuItem(
                              value: status,
                              child: Text(
                                status == ManufacturerStatus.active
                                    ? S.of(context).active
                                    : S.of(context).inactive,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            if (newValue != null) {
                              setState(() {
                                status = newValue;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
