import 'package:get/get.dart';

import '../../features/auth/users/data/repo/github_remote_datasource.dart';
import '../../features/auth/users/data/repo/github_remote_datasource_impl.dart';
import '../../features/auth/users/data/repo/github_repository_impl.dart';
import '../../features/auth/users/domain/get_repository_usecase.dart';
import '../../features/auth/users/domain/get_user_repositories_usecase.dart';
import '../../features/auth/users/domain/get_user_usecase.dart';
import '../../features/auth/users/domain/github_repository.dart';
import '../../features/auth/users/presentation/controller/repository_controller.dart';
import '../../features/auth/users/presentation/controller/theme_controller.dart';
import '../../features/auth/users/presentation/controller/user_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Data sources
    Get.lazyPut<GitHubRemoteDataSource>(
      () => GitHubRemoteDataSourceImpl(),
    );

    // Repositories
    Get.lazyPut<GitHubRepository>(
      () => GitHubRepositoryImpl(
        remoteDataSource: Get.find<GitHubRemoteDataSource>(),
      ),
    );

    // Use cases
    Get.lazyPut(() => GetUserUseCase(Get.find<GitHubRepository>()));
    Get.lazyPut(() => GetUserRepositoriesUseCase(Get.find<GitHubRepository>()));
    Get.lazyPut(() => GetRepositoryUseCase(Get.find<GitHubRepository>()));

    // Controllers
    Get.put(ThemeController());
    Get.lazyPut(() => UserController(getUserUseCase: Get.find<GetUserUseCase>()));
    Get.lazyPut(() => RepositoryController(
      getUserRepositoriesUseCase: Get.find<GetUserRepositoriesUseCase>(),
      getRepositoryUseCase: Get.find<GetRepositoryUseCase>(),
    ));
  }
}
