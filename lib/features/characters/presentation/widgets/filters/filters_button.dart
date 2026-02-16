import 'package:flutter/material.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/features/characters/presentation/widgets/filters/filter_dialog_row.dart';

class FiltersDialogButton extends StatefulWidget {
  const FiltersDialogButton({
    required this.onGenderFilterSelected,
    required this.onStatusFilterSelected,
    required this.onClearFilters,
    super.key,
  });

  final void Function(String? genderFilter) onGenderFilterSelected;
  final void Function(String? statusFilter) onStatusFilterSelected;
  final VoidCallback onClearFilters;

  @override
  State<FiltersDialogButton> createState() => _FiltersDialogButtonState();
}

class _FiltersDialogButtonState extends State<FiltersDialogButton> {
  String? _selectedStatus;
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Badge(
      backgroundColor: context.colorScheme.secondary,
      largeSize: 10,
      smallSize: 10,
      isLabelVisible: _selectedStatus != null || _selectedGender != null,
      child: IconButton(
        icon: _selectedStatus != null || _selectedGender != null ? const Icon(Icons.filter_alt_rounded) : const Icon(Icons.filter_alt_outlined),
        onPressed: () => _showFiltersDialog(context),
      ),
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
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FilterRow(
                    label: 'Status:',
                    hintText: 'Status',
                    initialSelection: _selectedStatus,
                    dropdownMenuEntries: AppConst.statusDropdownEntries,
                    keyPrefix: 'status',
                    onSelected: (String? value) => setDialogState(() {
                      _selectedStatus = value;
                    }),
                  ),
                  FilterRow(
                    label: 'Gender:',
                    hintText: 'Gender',
                    initialSelection: _selectedGender,
                    dropdownMenuEntries: AppConst.genderDropdownEntries,
                    keyPrefix: 'gender',
                    onSelected: (String? value) => setDialogState(() {
                      _selectedGender = value;
                    }),
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
                  },
                  child: Text('Clear Filters', style: context.textTheme.labelLarge?.copyWith(color: context.colorScheme.error)),
                ),
                FilledButton(
                  onPressed: () {
                    // Update the widget's state to show badge and filled icon
                    setState(() {});
                    widget.onGenderFilterSelected(_selectedGender);
                    widget.onStatusFilterSelected(_selectedStatus);
                    Navigator.pop(context);
                  },
                  child: const Text('Apply', style: TextStyle(fontWeight: .w800)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
