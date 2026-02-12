part of 'di_imports.dart';

final GetIt sl = GetIt.instance;

//Feature
//bloc first!
//then usecases
//repo
//data source
//service

Future<void> injectionInit() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final Dio dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 20), receiveTimeout: const Duration(seconds: 20)));

  dio.interceptors.addAll([ErrorInterceptor(), RetryInterceptor(dio)]);
  sl
    ..registerLazySingleton<AppDatabase>(() => AppDatabase())
    ..registerLazySingleton<Dio>(() => dio)
    // * Theme
    ..registerFactory(() => ThemeBloc(getThemeUseCase: sl(), setThemeUseCase: sl()))
    ..registerLazySingleton(() => GetThemeUseCase(sl()))
    ..registerLazySingleton(() => SetThemeUseCase(sl()))
    ..registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl(themeLocalDatasource: sl()))
    ..registerLazySingleton<ThemeLocalDataSource>(() => ThemeLocalDatasourceImpl(sl()))
    // * On boarding
    ..registerFactory(() => OnBoardingCubit(cacheFirstTimer: sl(), checkFirstTimer: sl()))
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckFirstTimer(sl()))
    ..registerLazySingleton<OnBoardingRepository>(() => OnBoardingRepoImpl(sl()))
    ..registerLazySingleton<OnBoardingLocalDataSource>(() => OnBoardingLocalDataSourceImpl(sl()))
    // * Characters
    ..registerFactory(() => CharactersBloc(watchCharacters: sl()))
    ..registerLazySingleton(() => WatchCharacters(sl()))
    ..registerLazySingleton<CharactersRepo>(() => CharactersRepoImpl(sl(), sl()))
    ..registerLazySingleton<CharactersLocalDataSource>(() => CharactersLocalDataSourceImpl(sl<AppDatabase>()))
    ..registerLazySingleton<CharactersRemoteDataSource>(() => CharactersRemoteDataSourceImpl(sl<Dio>()))
    // * General Services
    ..registerLazySingleton(() => prefs);

  // ..registerLazySingleton(()=>SharedPreferences.getInstance()) // ! Cant do this becsue it ns not initialized so check the init
}
