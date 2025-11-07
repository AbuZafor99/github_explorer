import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/utils/string_utils.dart';
import '../../domain/get_user_usecase.dart';
import '../../domain/github_user.dart';

class UserController extends GetxController {
  final GetUserUseCase getUserUseCase;

  UserController({required this.getUserUseCase});

  final _isLoading = false.obs;
  final _user = Rxn<GitHubUser>();
  final _errorMessage = ''.obs;
  final usernameController = TextEditingController();

  bool get isLoading => _isLoading.value;
  GitHubUser? get user => _user.value;
  String get errorMessage => _errorMessage.value;

  @override
  void onInit() {
    super.onInit();
    _loadLastUser();
  }

  @override
  void onClose() {
    usernameController.dispose();
    super.onClose();
  }

  Future<void> _loadLastUser() async {
    final prefs = await SharedPreferences.getInstance();
    final lastUser = prefs.getString(AppConstants.lastUserKey);
    if (lastUser != null && lastUser.isNotEmpty) {
      usernameController.text = lastUser;
    }
  }

  Future<void> _saveLastUser(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.lastUserKey, username);
  }

  String? validateUsername(String? value) {
    if (StringUtils.isNullOrEmpty(value)) {
      return AppStrings.usernameRequired;
    }
    if (!StringUtils.isValidUsername(value!)) {
      return AppStrings.invalidUsername;
    }
    return null;
  }

  Future<void> searchUser() async {
    final username = usernameController.text.trim();
    
    if (validateUsername(username) != null) {
      _errorMessage.value = validateUsername(username)!;
      return;
    }

    _isLoading.value = true;
    _errorMessage.value = '';

    try {
      final result = await getUserUseCase(username);
      
      if (result.success && result.data != null) {
        _user.value = result.data;
        await _saveLastUser(username);
        Get.toNamed('/home');
      } else {
        _errorMessage.value = result.message ?? AppStrings.userNotFound;
      }
    } catch (e) {
      _errorMessage.value = AppStrings.unknownError;
    } finally {
      _isLoading.value = false;
    }
  }

  void clearError() {
    _errorMessage.value = '';
  }
}
