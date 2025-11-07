import 'package:dio/dio.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/network/api_response.dart';
import '../../../../../core/network/network_client.dart';
import '../model/github_user_model.dart';
import '../model/repository_model.dart';
import 'github_remote_datasource.dart';

class GitHubRemoteDataSourceImpl implements GitHubRemoteDataSource {
  final Dio _dio = NetworkClient.dio;

  @override
  Future<ApiResponse<GitHubUserModel>> getUser(String username) async {
    try {
      final response = await _dio.get('${ApiConstants.userEndpoint}/$username');
      
      if (response.statusCode == 200) {
        final user = GitHubUserModel.fromJson(response.data);
        return ApiResponse.success(user);
      } else {
        return ApiResponse.error(
          _getErrorMessage(response.statusCode!),
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        _handleDioError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return ApiResponse.error(AppStrings.unknownError);
    }
  }

  @override
  Future<ApiResponse<List<RepositoryModel>>> getUserRepositories(String username) async {
    try {
      final response = await _dio.get('${ApiConstants.userEndpoint}/$username${ApiConstants.reposEndpoint}');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final repositories = data.map((json) => RepositoryModel.fromJson(json)).toList();
        return ApiResponse.success(repositories);
      } else {
        return ApiResponse.error(
          _getErrorMessage(response.statusCode!),
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        _handleDioError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return ApiResponse.error(AppStrings.unknownError);
    }
  }

  @override
  Future<ApiResponse<RepositoryModel>> getRepository(String owner, String repo) async {
    try {
      final response = await _dio.get('${ApiConstants.reposEndpoint}/$owner/$repo');
      
      if (response.statusCode == 200) {
        final repository = RepositoryModel.fromJson(response.data);
        return ApiResponse.success(repository);
      } else {
        return ApiResponse.error(
          _getErrorMessage(response.statusCode!),
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        _handleDioError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return ApiResponse.error(AppStrings.unknownError);
    }
  }

  String _getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 404:
        return AppStrings.userNotFound;
      case 403:
        return 'Rate limit exceeded. Please try again later.';
      case 500:
      case 502:
      case 503:
        return AppStrings.serverError;
      default:
        return AppStrings.unknownError;
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please try again.';
      case DioExceptionType.connectionError:
        return AppStrings.networkError;
      case DioExceptionType.badResponse:
        return _getErrorMessage(error.response?.statusCode ?? 0);
      default:
        return AppStrings.networkError;
    }
  }
}
