import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/constants/app_strings.dart';
import 'core/init/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/users/presentation/controller/theme_controller.dart';

void main() {
  runApp(const GitHubExplorerApp());
}

class GitHubExplorerApp extends StatelessWidget {
  const GitHubExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.initial,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(ThemeController());
      }),
    );
  }
}
