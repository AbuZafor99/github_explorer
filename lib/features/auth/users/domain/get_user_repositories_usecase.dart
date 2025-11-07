import '../../../../core/network/api_response.dart';
import 'github_repository.dart';
import 'repository.dart';

class GetUserRepositoriesUseCase {
  final GitHubRepository repository;

  GetUserRepositoriesUseCase(this.repository);

  Future<ApiResponse<List<Repository>>> call(String username) {
    return repository.getUserRepositories(username);
  }
}
