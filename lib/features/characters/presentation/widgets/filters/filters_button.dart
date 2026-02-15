import 'package:flutter/material.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';

class FiltersDialogButton extends StatefulWidget {
  const FiltersDialogButton({
    required this.onGenderFilterSelected,
    required this.onStatusFilterSelected,
    super.key,
  });

  final void Function(String? genderFilter) onGenderFilterSelected;
  final void Function(String? statusFilter) onStatusFilterSelected;

  @override
  State<FiltersDialogButton> createState() => _FiltersDialogButtonState();
}

class _FiltersDialogButtonState extends State<FiltersDialogButton> {
  String? _selectedStatus;
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.filter_alt),
      onPressed: () => _showFiltersDialog(context),
    );
  }

  void _showFiltersDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setDialogState) {
            return AlertDialog(
              title: const Text('Filters'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Status:'),
                      DropdownMenu<String>(
                        key: ValueKey('status_$_selectedStatus'),
                        hintText: 'Status',
                        initialSelection: _selectedStatus,
                        dropdownMenuEntries: AppConst.statusDropdownEntries,
                        onSelected: (String? value) {
                          setDialogState(() {
                            _selectedStatus = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Gender:'),
                      DropdownMenu<String>(
                        key: ValueKey('gender_$_selectedGender'),
                        hintText: 'Gender',
                        initialSelection: _selectedGender,
                        dropdownMenuEntries: AppConst.genderDropdownEntries,
                        onSelected: (String? value) {
                          setDialogState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),

              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    setDialogState(() {
                      _selectedGender = null;
                      _selectedStatus = null;
                    });
                    widget.onStatusFilterSelected(null);
                    widget.onGenderFilterSelected(null);
                  },
                  child: Text('Clear', style: context.textTheme.labelLarge?.copyWith(color: context.colorScheme.error)),
                ),
                TextButton.icon(
                  onPressed: () {
                    widget.onStatusFilterSelected(_selectedStatus);
                    widget.onGenderFilterSelected(_selectedGender);
                    Navigator.of(context).pop();
                  },
                  iconAlignment: .end,
                  icon: Icon(Icons.check_rounded),
                  label: Text(
                    'Apply',
                    style: context.textTheme.labelLarge?.copyWith(fontWeight: .bold, color: context.colorScheme.primary),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
