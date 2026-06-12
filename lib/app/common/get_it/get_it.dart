import 'package:interior_ai/app/features/data/datasources/local/test_local_datasource.dart';
import 'package:interior_ai/app/features/data/datasources/remote/test_remote_datasource.dart';
import 'package:interior_ai/app/features/data/repositories/test_repository.dart';
import 'package:interior_ai/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:interior_ai/app/features/presentation/exterior_design/cubit/exterior_design_cubit.dart';
import 'package:interior_ai/app/features/presentation/floor_restyle/cubit/floor_restyle_cubit.dart';
import 'package:interior_ai/app/features/presentation/garden_design/cubit/garden_design_cubit.dart';
import 'package:interior_ai/app/features/presentation/home/cubit/home_cubit.dart';
import 'package:interior_ai/app/features/presentation/interior_design/cubit/interior_design_cubit.dart';
import 'package:interior_ai/app/features/presentation/main/cubit/main_cubit.dart';
import 'package:interior_ai/app/features/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:interior_ai/app/features/presentation/settings/cubit/settings_cubit.dart';
import 'package:interior_ai/app/features/presentation/replace_objects/cubit/replace_objects_cubit.dart';
import 'package:interior_ai/app/features/presentation/style_reference/cubit/style_reference_cubit.dart';
import 'package:interior_ai/app/features/presentation/test/cubit/test_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

/// **Service provider class managing all dependencies**
final class ServiceLocator {
  /// **Main method to call to set up dependencies**
  void setup() {
    _setupRouter();
    _setupDataSource();
    _setupRepository();
    _setupCubit();
  }

  /// **Router Dependency**
  void _setupRouter() {
    // getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  }

  /// **DataSource Dependency**
  void _setupDataSource() {
    getIt
      ..registerLazySingleton<TestRemoteDatasource>(
        () => TestRemoteDatasourceImpl(),
      )
      ..registerLazySingleton<TestLocalDatasource>(
        () => TestLocalDatasourceImpl(),
      );
  }

  /// **Repository Dependency**
  void _setupRepository() {
    getIt.registerLazySingleton<TestRepository>(
      () => TestRepositoryImpl(
        remoteDatasource: getIt<TestRemoteDatasource>(),
        localDatasource: getIt<TestLocalDatasource>(),
      ),
    );
  }

  /// **BLoC, Cubit and ViewModel Dependency**
  void _setupCubit() {
    getIt
      ..registerLazySingleton<MainCubit>(() => MainCubit())
      ..registerLazySingleton<OnboardingCubit>(() => OnboardingCubit())
      ..registerLazySingleton<SettingsCubit>(() => SettingsCubit())
      ..registerLazySingleton<InteriorDesignCubit>(() => InteriorDesignCubit())
      ..registerLazySingleton<CollectionCubit>(() => CollectionCubit())
      ..registerLazySingleton<StyleReferenceCubit>(() => StyleReferenceCubit())
      ..registerLazySingleton<ReplaceObjectsCubit>(() => ReplaceObjectsCubit())
      ..registerLazySingleton<GardenDesignCubit>(() => GardenDesignCubit())
      ..registerLazySingleton<ExteriorDesignCubit>(() => ExteriorDesignCubit())
      ..registerLazySingleton<FloorRestyleCubit>(() => FloorRestyleCubit())
      ..registerLazySingleton<HomeCubit>(
        () => HomeCubit(testRepository: getIt<TestRepository>()),
      )
      ..registerLazySingleton<TestCubit>(
        () => TestCubit(testRepository: getIt<TestRepository>()),
      );
  }

  /// **Resets dependencies for Test and Debug**
  Future<void> reset() async {
    await getIt.reset();
    setup();
  }
}
