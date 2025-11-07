import '../../../../../core/network/api_response.dart';
import '../../domain/github_repository.dart';
import '../../domain/github_user.dart';
import '../../domain/repository.dart';
import 'github_remote_datasource.dart';

class GitHubRepositoryImpl implements GitHubRepository {
  final GitHubRemoteDataSource remoteDataSource;

  GitHubRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResponse<GitHubUser>> getUser(String username) async {
    final result = await remoteDataSource.getUser(username);
    if (result.success && result.data != null) {
      return ApiResponse.success(result.data!);
    } else {
      return ApiResponse.error(
        result.message ?? 'Failed to get user',
        statusCode: result.statusCode,
      );
    }
  }

  @override
  Future<ApiResponse<List<Repository>>> getUserRepositories(String username) async {
    final result = await remoteDataSource.getUserRepositories(username);
    if (result.success && result.data != null) {
      return ApiResponse.success(result.data!.cast<Repository>());
    } else {
      return ApiResponse.error(
        result.message ?? 'Failed to get repositories',
        statusCode: result.statusCode,
      );
    }
  }

  @override
  Future<ApiResponse<Repository>> getRepository(String owner, String repo) async {
    final result = await remoteDataSource.getRepository(owner, repo);
    if (result.success && result.data != null) {
      return ApiResponse.success(result.data!);
    } else {
      return ApiResponse.error(
        result.message ?? 'Failed to get repository',
        statusCode: result.statusCode,
      );
    }
  }
}
