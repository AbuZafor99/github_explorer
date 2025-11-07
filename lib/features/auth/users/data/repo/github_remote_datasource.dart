import '../../../../../core/network/api_response.dart';
import '../model/github_user_model.dart';
import '../model/repository_model.dart';

abstract class GitHubRemoteDataSource {
  Future<ApiResponse<GitHubUserModel>> getUser(String username);
  Future<ApiResponse<List<RepositoryModel>>> getUserRepositories(String username);
  Future<ApiResponse<RepositoryModel>> getRepository(String owner, String repo);
}
