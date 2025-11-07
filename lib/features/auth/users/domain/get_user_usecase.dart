import '../../../../core/network/api_response.dart';
import 'github_repository.dart';
import 'github_user.dart';

class GetUserUseCase {
  final GitHubRepository repository;

  GetUserUseCase(this.repository);

  Future<ApiResponse<GitHubUser>> call(String username) {
    return repository.getUser(username);
  }
}
