import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:feature_oriented/core/network/connection/internet_info_impl.dart';
import 'package:feature_oriented/core/network/interceptor/error_interceptor.dart';
import 'package:feature_oriented/core/network/interceptor/request_interceptor.dart';
import 'package:feature_oriented/core/network/repositories/base_repo.dart';
import 'package:feature_oriented/core/network/repositories/base_repo_impl.dart';
import 'package:feature_oriented/core/usecases/fetch_token.dart';
import 'package:feature_oriented/core/usecases/validate_token.dart';
import 'package:feature_oriented/feature/login/data/repositories/login_remote_impl.dart';
import 'package:feature_oriented/feature/login/data/repositories/login_storage_impl.dart';
import 'package:feature_oriented/feature/login/domain/business/login_business_impl.dart';
import 'package:feature_oriented/feature/login/domain/usecases/login_user.dart';
import 'package:feature_oriented/feature/login/presentation/cubit/login_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/localization/localization_manager.dart';

final serviceLocator = GetIt.instance; //sl is referred to as Service Locator

//Dependency injection
Future<void> configureInjection() async {
  //Blocs
  serviceLocator.registerFactory(
    () => LoginCubit(
      loginUser: serviceLocator(),
      fetchToken: serviceLocator(),
      checkTokenValidation: serviceLocator(),
    ),
  );

  //Use cases
  serviceLocator
      .registerLazySingleton(() => LoginUser(loginBusiness: serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => FetchToken(loginBusiness: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => ValidateToken(loginBusiness: serviceLocator()));

  //Repositories
  serviceLocator.registerLazySingleton<LoginBusiness>(
    () => LoginBusinessImpl(
      networkInfo: serviceLocator(),
      localLoginRepo: serviceLocator(),
      remoteLoginRepo: serviceLocator(),
    ),
  );

  //Data sources
  serviceLocator.registerLazySingleton<LoginRemoteRepo>(
    () => LoginRemoteRepoImpl(),
  );
  serviceLocator.registerLazySingleton<BaseRepository>(
    () => BaseRepoImpl(),
  );
  serviceLocator.registerLazySingleton<LocalStorageLoginRepo>(
    () => LocalStorageLoginRepoImpl(),
  );
  serviceLocator.registerLazySingleton(() => RequestInterceptor());
  serviceLocator.registerLazySingleton(() => ErrorInterceptor());

  //Core
  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(dataConnectionChecker: serviceLocator()),
  );

  //configurations
  serviceLocator.registerLazySingleton(() => LocalizationManager());

  //External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator
      .registerLazySingleton(() => Connectivity().checkConnectivity());
}
