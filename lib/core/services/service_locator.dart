part of 'di_imports.dart';

//Feature
//bloc first!
//then usecases
//repo
//data source
//service

// registerFactory creates a new instance every time its requested,
// while registerLazySingleton creates a single instance that is reused.

// * Dependecy Injection / Service Locator

final GetIt sl = GetIt.instance;

Future<void> injectionInit() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppEnvs.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  dio.interceptors.addAll([
    ErrorInterceptor(),
    LoggingInterceptor(),
    RetryInterceptor(dio),
  ]);
  sl
    ..registerLazySingleton<AppDatabase>(() => AppDatabase())
    ..registerLazySingleton<Dio>(() => dio)
    // * Translations
    ..registerFactory(() => TranslationsCubit(cacheSelectedLanguage: sl(), getCachedSelectedLanguage: sl()))
    ..registerLazySingleton(() => CacheSelectedLanguage(sl()))
    ..registerLazySingleton(() => GetCachedSelectedLanguage(sl()))
    ..registerLazySingleton<TranslationsRepo>(() => TranslationsRepoImpl(sl()))
    ..registerLazySingleton<TranslationsLocalDataSource>(() => TranslationsLocalDataSourceImpl(sl()))
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
    ..registerFactory(() => CharactersBloc(getCharacters: sl()))
    ..registerLazySingleton(() => GetCharacters(sl()))
    ..registerLazySingleton<CharactersRepo>(() => CharactersRepoImpl(sl(), sl()))
    ..registerLazySingleton<CharactersLocalDataSource>(() => CharactersLocalDataSourceImpl(sl<AppDatabase>()))
    ..registerLazySingleton<CharactersRemoteDataSource>(() => CharactersRemoteDataSourceImpl(sl<Dio>(), sl<EpisodesRemoteDataSource>()))
    // * Character Details
    ..registerFactory(() => CharacterDetailsBloc(getCharacterDetails: sl()))
    ..registerLazySingleton(() => GetCharacterDetails(sl()))
    ..registerLazySingleton<CharacterDetailsRepo>(() => CharacterDetailsRepoImpl(sl(), sl()))
    ..registerLazySingleton<CharacterDetailsLocalDataSource>(() => CharacterDetailsLocalDataSourceImpl(sl<AppDatabase>()))
    ..registerLazySingleton<CharacterDetailsRemoteDataSource>(() => CharacterDetailsRemoteDataSourceImpl(sl<Dio>(), sl<EpisodesRemoteDataSource>()))
    // * Episodes
    ..registerLazySingleton<EpisodesRemoteDataSource>(() => EpisodesRemoteDataSourceImpl(sl<Dio>()))
    // * General Services
    ..registerLazySingleton(() => prefs);

  // ..registerLazySingleton(()=>SharedPreferences.getInstance()) // ! Cant do this becsue it ns not initialized so check the init
}
