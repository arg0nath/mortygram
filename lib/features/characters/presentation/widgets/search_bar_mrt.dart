import 'package:flutter/material.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';

/// A search bar widget that allows users to input a search query
///
/// Mrt stads for Morty, to avoid confusion with the more common "SearchBar"
class SearchBarMrt extends StatefulWidget {
  const SearchBarMrt({required this.onSearch, super.key});

  final void Function(String? value) onSearch;

  @override
  State<SearchBarMrt> createState() => _SearchBarMrtState();
}

class _SearchBarMrtState extends State<SearchBarMrt> {
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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      style: context.theme.inputDecorationTheme.labelStyle,
      decoration: const InputDecoration().copyWith(
        hintText: 'Search...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: IconButton(
          icon: const Icon(Icons.search_rounded),
          onPressed: () {
            if (textEditingController.value.text.isNotEmpty) {
              FocusScope.of(context).unfocus();
              return widget.onSearch(textEditingController.value.text);
            }
          },
        ),
        prefixIcon: textEditingController.value.text.isEmpty
            ? null
            : GestureDetector(
                onTap: () {
                  textEditingController.clear();
                  return widget.onSearch(AppConst.emptyString);
                },
                child: const Icon(Icons.clear_rounded),
              ),
      ),
      onChanged: (String value) {
        if (value.isEmpty) {
          return widget.onSearch(AppConst.emptyString);
        }
      },
      onSaved: (String? newValue) => widget.onSearch(newValue),
      onTapOutside: (PointerDownEvent val) => FocusScope.of(context).unfocus(),
      onFieldSubmitted: (String val) {
        if (val.isNotEmpty) {
          return widget.onSearch(val);
        } else {
          null;
        }
      },
    );
  }
}
