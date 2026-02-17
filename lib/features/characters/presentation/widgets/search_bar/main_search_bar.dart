import 'dart:async';

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

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Cancel previous timer
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Start new timer (800ms delay to reduce API calls)
    _debounce = Timer(const Duration(milliseconds: 800), () {
      widget.onSearch(query.isEmpty ? null : query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      style: context.theme.inputDecorationTheme.labelStyle,
      decoration: const InputDecoration().copyWith(
        hintText: 'Search Character...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: IconButton(
          visualDensity: .compact,
          icon: const Icon(Icons.search_rounded),
          onPressed: () {
            FocusScope.of(context).unfocus();
            textEditingController.text.isNotEmpty ? _onSearchChanged(textEditingController.text) : null;
          },
        ),
        prefixIcon: textEditingController.value.text.isEmpty
            ? null
            : GestureDetector(
                onTap: () {
                  textEditingController.clear();
                  widget.onSearch(null);
                },
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
