import '../../../../../core/utils/date_utils.dart' as utils;
import '../../domain/repository.dart';
import 'github_user_model.dart';

class RepositoryModel extends Repository {
  RepositoryModel({
    required super.id,
    required super.name,
    required super.fullName,
    super.description,
    required super.htmlUrl,
    required super.private,
    super.language,
    required super.stargazersCount,
    required super.forksCount,
    required super.watchersCount,
    required super.size,
    required super.openIssuesCount,
    super.createdAt,
    super.updatedAt,
    super.pushedAt,
    super.defaultBranch,
    required super.archived,
    required super.disabled,
    required super.owner,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      fullName: json['full_name'] ?? '',
      description: json['description'],
      htmlUrl: json['html_url'] ?? '',
      private: json['private'] ?? false,
      language: json['language'],
      stargazersCount: json['stargazers_count'] ?? 0,
      forksCount: json['forks_count'] ?? 0,
      watchersCount: json['watchers_count'] ?? 0,
      size: json['size'] ?? 0,
      openIssuesCount: json['open_issues_count'] ?? 0,
      createdAt: utils.DateUtils.parseDateTime(json['created_at']),
      updatedAt: utils.DateUtils.parseDateTime(json['updated_at']),
      pushedAt: utils.DateUtils.parseDateTime(json['pushed_at']),
      defaultBranch: json['default_branch'],
      archived: json['archived'] ?? false,
      disabled: json['disabled'] ?? false,
      owner: GitHubUserModel.fromJson(json['owner'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'full_name': fullName,
      'description': description,
      'html_url': htmlUrl,
      'private': private,
      'language': language,
      'stargazers_count': stargazersCount,
      'forks_count': forksCount,
      'watchers_count': watchersCount,
      'size': size,
      'open_issues_count': openIssuesCount,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'pushed_at': pushedAt?.toIso8601String(),
      'default_branch': defaultBranch,
      'archived': archived,
      'disabled': disabled,
      'owner': (owner as GitHubUserModel).toJson(),
    };
  }
}
