import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/core/common/extensions/string_ext.dart';
import 'package:mortygram/features/characters/domain/entities/character_search_filters.dart';
import 'package:mortygram/features/characters/presentation/widgets/filters/filter_dialog_row.dart';

class FiltersDialogButton extends StatefulWidget {
  const FiltersDialogButton({
    required this.currentFilters,
    required this.onFiltersChanged,
    super.key,
  });

  final CharacterSearchFilters currentFilters;
  final void Function(CharacterSearchFilters filters) onFiltersChanged;

  @override
  State<FiltersDialogButton> createState() => _FiltersDialogButtonState();
}

class _FiltersDialogButtonState extends State<FiltersDialogButton> {
  String? _selectedStatus;
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.currentFilters.status;
    _selectedGender = widget.currentFilters.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
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
              title: Text('filters.filters'.tr()),
              content: Column(
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FilterRow(
                    label: 'filters.status'.tr() + ':',
                    hintText: 'filters.status'.tr().toUpperFirst(),
                    initialSelection: _selectedStatus,
                    dropdownMenuEntries: AppConst.statusDropdownEntries,
                    keyPrefix: 'status',
                    onSelected: (String? value) => setDialogState(() {
                      _selectedStatus = value;
                    }),
                  ),
                  FilterRow(
                    label: 'filters.gender'.tr() + ':',
                    hintText: 'filters.gender'.tr().toUpperFirst(),
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
                  child: Text('filters.clearFilters'.tr(), style: context.textTheme.labelLarge?.copyWith(color: context.colorScheme.error)),
                ),
                FilledButton(
                  onPressed: () {
                    setState(() {});
                    widget.onFiltersChanged(
                      widget.currentFilters.copyWith(
                        gender: _selectedGender,
                        status: _selectedStatus,
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Text('filters.applyFilters'.tr(), style: TextStyle(fontWeight: .w800)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
