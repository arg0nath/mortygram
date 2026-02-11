import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/core/common/widgets/bottom_bar.dart';
import 'package:mortygram/core/routes/route_helper.dart';
import 'package:mortygram/core/routes/route_names.dart';
import 'package:mortygram/core/services/di_imports.dart';
import 'package:mortygram/features/character_details/presentation/pages/character_details_page.dart';
import 'package:mortygram/features/characters/presentation/pages/characters_page.dart';
import 'package:mortygram/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:mortygram/features/on_boarding/presentation/pages/on_boarding_page.dart';
import 'package:mortygram/features/settings/presentation/pages/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RoutePath.charactersPage,
  redirect: (BuildContext context, GoRouterState state) {
    final SharedPreferences prefs = sl<SharedPreferences>();
    final bool isFirstTimer = prefs.getBool(AppConst.kFirstTimerKey) ?? true;
    // redirect to onboarding if first timer and not already there
    if (isFirstTimer && state.matchedLocation != RoutePath.onBoardingPage) {
      return RoutePath.onBoardingPage;
    }
    // redirect root to characters page
    if (state.matchedLocation == RoutePath.rootPage) {
      return RoutePath.charactersPage;
    }
    return null;
  },
  routes: <RouteBase>[
    customGoRoute(
      path: RoutePath.onBoardingPage,
      name: RouteName.onBoardingPageName,
      builder: (BuildContext context, GoRouterState state) => BlocProvider<OnBoardingCubit>(create: (BuildContext context) => sl<OnBoardingCubit>(), child: const OnBoardingPage()),
    ),

    StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navShell) => Scaffold(
        body: navShell,
        bottomNavigationBar: MainAppBottomBar(navigationShell: navShell),
      ),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
            // * ---------- Characters List (Home Page) ----------
            customGoRoute(
              path: RoutePath.charactersPage,
              name: RouteName.charactersPageName,
              builder: (BuildContext context, GoRouterState state) => const CharactersPage(),
              routes: <GoRoute>[
                // * ---------- Character Details Page ----------
                customGoRoute(
                  path: '${RoutePath.characterDetailsPage}/:characterId',
                  name: RouteName.characterDetailsPageName,
                  builder: (BuildContext context, GoRouterState state) => CharacterDetailsPage(characterId: state.pathParameters['characterId']!),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            // * ---------- Characters List (Home Page) ----------
            customGoRoute(path: RoutePath.settingsPage, name: RouteName.settingsPageName, builder: (BuildContext context, GoRouterState state) => const SettingsPage()),
          ],
        ),
      ],
    ),
  ],
);
