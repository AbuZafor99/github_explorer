import '../../../../core/network/api_response.dart';
import 'github_user.dart';
import 'repository.dart';

abstract class GitHubRepository {
  Future<ApiResponse<GitHubUser>> getUser(String username);
  Future<ApiResponse<List<Repository>>> getUserRepositories(String username);
  Future<ApiResponse<Repository>> getRepository(String owner, String repo);
}
