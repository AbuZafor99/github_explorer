import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/utils/date_utils.dart' as utils;
import '../../../../../core/utils/string_utils.dart';
import '../../domain/repository.dart';

class RepositoryDetailPage extends StatelessWidget {
  const RepositoryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Repository repository = Get.arguments as Repository;

    return Scaffold(
      appBar: AppBar(
        title: Text(repository.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_browser),
            onPressed: () {
              // TODO: Implement URL launcher to open repository in browser
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          repository.private ? Icons.lock : Icons.folder,
                          color: repository.private 
                              ? Colors.orange 
                              : Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            repository.fullName,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    if (repository.description != null) ...[
                      Text(
                        repository.description!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                    ],
                    
                    // Repository stats
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: [
                        _buildStatChip(
                          context,
                          Icons.star,
                          repository.stargazersCount.toString(),
                          AppStrings.stars,
                          Colors.amber,
                        ),
                        _buildStatChip(
                          context,
                          Icons.fork_right,
                          repository.forksCount.toString(),
                          AppStrings.forks,
                          Colors.blue,
                        ),
                        _buildStatChip(
                          context,
                          Icons.bug_report,
                          repository.openIssuesCount.toString(),
                          AppStrings.issues,
                          Colors.red,
                        ),
                        _buildStatChip(
                          context,
                          Icons.visibility,
                          repository.watchersCount.toString(),
                          'Watchers',
                          Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Repository Information
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Repository Information',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    _buildInfoRow(
                      context,
                      Icons.code,
                      AppStrings.language,
                      repository.language ?? 'Not specified',
                    ),
                    
                    _buildInfoRow(
                      context,
                      Icons.storage,
                      AppStrings.size,
                      StringUtils.formatFileSize(repository.size * 1024),
                    ),
                    
                    _buildInfoRow(
                      context,
                      Icons.source,
                      'Default Branch',
                      repository.defaultBranch ?? 'main',
                    ),
                    
                    if (repository.createdAt != null)
                      _buildInfoRow(
                        context,
                        Icons.calendar_today,
                        AppStrings.createdAt,
                        utils.DateUtils.formatDate(repository.createdAt!),
                      ),
                    
                    if (repository.updatedAt != null)
                      _buildInfoRow(
                        context,
                        Icons.update,
                        AppStrings.updatedAt,
                        utils.DateUtils.timeAgo(repository.updatedAt!),
                      ),
                    
                    if (repository.pushedAt != null)
                      _buildInfoRow(
                        context,
                        Icons.push_pin,
                        'Last Push',
                        utils.DateUtils.timeAgo(repository.pushedAt!),
                      ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Owner Information
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Owner',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(repository.owner.avatarUrl),
                          backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                          child: repository.owner.avatarUrl.isEmpty 
                              ? Icon(Icons.person, size: 25, color: Theme.of(context).primaryColor)
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                repository.owner.name ?? repository.owner.login,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '@${repository.owner.login}',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).textTheme.bodySmall?.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.open_in_new),
                          onPressed: () {
                            // Open user profile
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Status badges
            if (repository.archived || repository.disabled)
              Card(
                color: Theme.of(context).colorScheme.errorContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (repository.archived) ...[
                        Row(
                          children: [
                            Icon(
                              Icons.archive,
                              color: Theme.of(context).colorScheme.onErrorContainer,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'This repository is archived',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onErrorContainer,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'It is read-only and no longer accepting contributions.',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onErrorContainer,
                          ),
                        ),
                      ],
                      
                      if (repository.disabled) ...[
                        if (repository.archived) const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.block,
                              color: Theme.of(context).colorScheme.onErrorContainer,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'This repository is disabled',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onErrorContainer,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(BuildContext context, IconData icon, String value, 
                       String label, Color color) {
    return Chip(
      avatar: Icon(icon, size: 16, color: color),
      label: Text('$value $label'),
      backgroundColor: color.withValues(alpha: 0.1),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).primaryColor),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
