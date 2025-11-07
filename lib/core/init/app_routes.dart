import 'package:get/get.dart';

import '../../features/auth/users/presentation/screens/home_page.dart';
import '../../features/auth/users/presentation/screens/login_page.dart';
import '../../features/auth/users/presentation/screens/repository_detail_page.dart';
import '../di/app_binding.dart';

class AppRoutes {
  static const String initial = '/';
  static const String home = '/home';
  static const String repository = '/repository';
}

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.initial,
      page: () => const LoginPage(),
      binding: AppBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: AppBinding(),
    ),
    GetPage(
      name: AppRoutes.repository,
      page: () => const RepositoryDetailPage(),
    ),
  ];
}
