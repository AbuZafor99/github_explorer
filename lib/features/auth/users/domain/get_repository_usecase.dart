import '../../../../core/network/api_response.dart';
import 'github_repository.dart';
import 'repository.dart';

class GetRepositoryUseCase {
  final GitHubRepository repository;

  GetRepositoryUseCase(this.repository);

  Future<ApiResponse<Repository>> call(String owner, String repo) {
    return repository.getRepository(owner, repo);
  }
}
