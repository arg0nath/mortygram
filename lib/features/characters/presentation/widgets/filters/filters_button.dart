import 'package:flutter/material.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';

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
        icon: _selectedStatus != null || _selectedGender != null ? const Icon(Icons.filter_alt_rounded, color: Colors.white) : const Icon(Icons.filter_alt_outlined),
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
                    setState(() {
                      _selectedGender = null;
                      _selectedStatus = null;
                    });
                    widget.onClearFilters();
                    Navigator.pop(context);
                  },
                  child: Text('Clear', style: context.textTheme.labelLarge?.copyWith(color: context.colorScheme.error)),
                ),
                FilledButton(
                  onPressed: () {
                    // Update the widget's state to show badge and filled icon
                    setState(() {});
                    widget.onGenderFilterSelected(_selectedGender);
                    widget.onStatusFilterSelected(_selectedStatus);
                    Navigator.pop(context);
                  },
                  child: const Text('Apply'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
