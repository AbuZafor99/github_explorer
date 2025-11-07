import 'github_user.dart';

class Repository {
  final int id;
  final String name;
  final String fullName;
  final String? description;
  final String htmlUrl;
  final bool private;
  final String? language;
  final int stargazersCount;
  final int forksCount;
  final int watchersCount;
  final int size;
  final int openIssuesCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? pushedAt;
  final String? defaultBranch;
  final bool archived;
  final bool disabled;
  final GitHubUser owner;

  Repository({
    required this.id,
    required this.name,
    required this.fullName,
    this.description,
    required this.htmlUrl,
    required this.private,
    this.language,
    required this.stargazersCount,
    required this.forksCount,
    required this.watchersCount,
    required this.size,
    required this.openIssuesCount,
    this.createdAt,
    this.updatedAt,
    this.pushedAt,
    this.defaultBranch,
    required this.archived,
    required this.disabled,
    required this.owner,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Repository && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Repository(id: $id, name: $name)';
}
