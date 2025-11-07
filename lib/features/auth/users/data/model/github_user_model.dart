import '../../../../../core/utils/date_utils.dart' as utils;
import '../../domain/github_user.dart';

class GitHubUserModel extends GitHubUser {
  GitHubUserModel({
    required super.id,
    required super.login,
    super.name,
    super.email,
    super.bio,
    super.company,
    super.location,
    super.blog,
    required super.avatarUrl,
    super.htmlUrl,
    required super.publicRepos,
    required super.followers,
    required super.following,
    super.createdAt,
    super.updatedAt,
  });

  factory GitHubUserModel.fromJson(Map<String, dynamic> json) {
    return GitHubUserModel(
      id: json['id'] ?? 0,
      login: json['login'] ?? '',
      name: json['name'],
      email: json['email'],
      bio: json['bio'],
      company: json['company'],
      location: json['location'],
      blog: json['blog'],
      avatarUrl: json['avatar_url'] ?? '',
      htmlUrl: json['html_url'],
      publicRepos: json['public_repos'] ?? 0,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      createdAt: utils.DateUtils.parseDateTime(json['created_at']),
      updatedAt: utils.DateUtils.parseDateTime(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'name': name,
      'email': email,
      'bio': bio,
      'company': company,
      'location': location,
      'blog': blog,
      'avatar_url': avatarUrl,
      'html_url': htmlUrl,
      'public_repos': publicRepos,
      'followers': followers,
      'following': following,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
