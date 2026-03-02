import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';

/// A search bar widget that allows users to input a search query
///
/// Mrt stads for Morty, to avoid confusion with the more common "SearchBar"
class MainSearchBar extends StatefulWidget {
  const MainSearchBar({required this.onSearch, super.key});

  final void Function(String? value) onSearch;

  @override
  State<MainSearchBar> createState() => _MainSearchBarState();
}

class _MainSearchBarState extends State<MainSearchBar> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  void _onSearchChanged(String query) {
    final trimmed = query.trim();
    widget.onSearch(trimmed.isNotEmpty ? trimmed : null);
  }

  void _onSearchCleared() {
    final hadValidText = textEditingController.text.trim().isNotEmpty;
    textEditingController.clear();
    if (hadValidText) {
      widget.onSearch(null);
    }
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      style: context.theme.inputDecorationTheme.labelStyle,
      decoration: const InputDecoration().copyWith(
        hintText: 'characters.search'.tr(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: IconButton(
          visualDensity: .compact,
          icon: const Icon(Icons.search_rounded),
          onPressed: () {
            FocusScope.of(context).unfocus();
            textEditingController.text.trim().isNotEmpty ? _onSearchChanged(textEditingController.text) : null;
          },
        ),
        prefixIcon: textEditingController.value.text.isEmpty
            ? null
            : GestureDetector(
                onTap: _onSearchCleared,
                child: const Icon(Icons.clear_rounded),
              ),
      ),

      onChanged: _onSearchChanged,
      onSaved: (String? newValue) => widget.onSearch(newValue),
      onTapOutside: (PointerDownEvent val) => FocusScope.of(context).unfocus(),
      onFieldSubmitted: _onSearchChanged,
    );
  }
}
