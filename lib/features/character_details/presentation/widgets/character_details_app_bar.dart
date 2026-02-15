import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/features/character_details/domain/entities/character_details.dart';
import 'package:mortygram/features/character_details/presentation/bloc/character_details_bloc.dart';

/// AppBar widget for the character details page that displays the character's name in the title
class CharacterDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CharacterDetailsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleTextStyle: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
      backgroundColor: Colors.transparent,
      title: BlocBuilder<CharacterDetailsBloc, CharacterDetailsState>(
        builder: (BuildContext context, CharacterDetailsState state) {
          return state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            loaded: (CharacterDetails details) => Text(details.name),
          );
        },
      ),
    );
  }
}
