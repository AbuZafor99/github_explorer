class GitHubUser {
  final int id;
  final String login;
  final String? name;
  final String? email;
  final String? bio;
  final String? company;
  final String? location;
  final String? blog;
  final String avatarUrl;
  final String? htmlUrl;
  final int publicRepos;
  final int followers;
  final int following;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GitHubUser({
    required this.id,
    required this.login,
    this.name,
    this.email,
    this.bio,
    this.company,
    this.location,
    this.blog,
    required this.avatarUrl,
    this.htmlUrl,
    required this.publicRepos,
    required this.followers,
    required this.following,
    this.createdAt,
    this.updatedAt,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GitHubUser && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'GitHubUser(id: $id, login: $login)';
}
