// ignore_for_file: always_specify_types

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/core/common/envs/app_envs.dart';
import 'package:mortygram/core/common/res/app_assets.dart';
import 'package:mortygram/core/common/utils/bloc_observer.dart';
import 'package:mortygram/core/services/di_imports.dart';
import 'package:mortygram/features/app/app.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await AppEnvs.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // Initialize HydratedBloc storage
  final storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory((await getApplicationDocumentsDirectory()).path),
  );
  HydratedBloc.storage = storage;

  Bloc.observer = AppBlocObserver();
  await injectionInit();
  runApp(
    EasyLocalization(
      supportedLocales: AppConst.supportedLocales,
      path: AppAssets.translationsPath,
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}
