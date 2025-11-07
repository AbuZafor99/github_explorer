import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/widgets/skeleton_loader.dart';
import '../controller/repository_controller.dart';
import '../controller/theme_controller.dart';
import '../controller/user_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final userController = Get.find<UserController>();
    final repositoryController = Get.find<RepositoryController>();
    
    if (userController.user != null) {
      repositoryController.loadRepositories(userController.user!.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final repositoryController = Get.find<RepositoryController>();
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(userController.user?.login ?? AppStrings.appName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          // View mode toggle
          Obx(() => IconButton(
            icon: Icon(
              repositoryController.viewMode == ViewMode.list
                  ? Icons.grid_view
                  : Icons.view_list,
            ),
            onPressed: () {
              repositoryController.setViewMode(
                repositoryController.viewMode == ViewMode.list
                    ? ViewMode.grid
                    : ViewMode.list,
              );
            },
          )),
          
          // Theme toggle
          Obx(() => IconButton(
            icon: Icon(
              themeController.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: themeController.toggleTheme,
          )),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (userController.user != null) {
            repositoryController.refreshRepositories(userController.user!.login);
          }
        },
        child: CustomScrollView(
          slivers: [
            // User info section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(userController.user!.avatarUrl),
                          backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                          child: userController.user!.avatarUrl.isEmpty 
                              ? Icon(Icons.person, size: 30, color: Theme.of(context).primaryColor)
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userController.user!.name ?? userController.user!.login,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              if (userController.user!.bio != null)
                                Text(
                                  userController.user!.bio!,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              const SizedBox(height: 8),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    _buildStatItem(
                                      context,
                                      Icons.book,
                                      userController.user!.publicRepos.toString(),
                                      'Repos',
                                    ),
                                    const SizedBox(width: 16),
                                    _buildStatItem(
                                      context,
                                      Icons.people,
                                      userController.user!.followers.toString(),
                                      'Followers',
                                    ),
                                    const SizedBox(width: 16),
                                    _buildStatItem(
                                      context,
                                      Icons.person_add,
                                      userController.user!.following.toString(),
                                      'Following',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            // Search and filters
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Column(
                  children: [
                    // Search bar
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search repositories...',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: repositoryController.setSearchQuery,
                    ),
                    const SizedBox(height: 16),
                    // Sort options
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            'Sort by:',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(width: 16),
                          Obx(() => DropdownButton<SortOption>(
                            value: repositoryController.sortOption,
                            onChanged: (option) {
                              if (option != null) {
                                repositoryController.setSortOption(option);
                              }
                            },
                            items: const [
                              DropdownMenuItem(
                                value: SortOption.name,
                                child: Text('Name'),
                              ),
                              DropdownMenuItem(
                                value: SortOption.date,
                                child: Text('Date'),
                              ),
                              DropdownMenuItem(
                                value: SortOption.stars,
                                child: Text('Stars'),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Repositories section
            Obx(() {
              if (repositoryController.isLoading) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => RepositoryItemSkeletonLoader(
                      isGrid: repositoryController.viewMode == ViewMode.grid,
                    ),
                    childCount: 8,
                  ),
                );
              }
              
              if (repositoryController.errorMessage.isNotEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            repositoryController.errorMessage,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              repositoryController.clearError();
                              if (userController.user != null) {
                                repositoryController.refreshRepositories(
                                  userController.user!.login,
                                );
                              }
                            },
                            child: const Text(AppStrings.retry),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              
              if (repositoryController.repositories.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Column(
                        children: [
                          Icon(
                            Icons.folder_open,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            AppStrings.noRepositories,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              
              // Repository list or grid
              if (repositoryController.viewMode == ViewMode.list) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final repo = repositoryController.repositories[index];
                      return _buildRepositoryListItem(context, repo);
                    },
                    childCount: repositoryController.repositories.length,
                  ),
                );
              } else {
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final repo = repositoryController.repositories[index];
                      return _buildRepositoryGridItem(context, repo);
                    },
                    childCount: repositoryController.repositories.length,
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, IconData icon, String value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Theme.of(context).primaryColor),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRepositoryListItem(BuildContext context, repo) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: 4,
      ),
      child: ListTile(
        leading: Icon(
          repo.private ? Icons.lock : Icons.folder,
          color: repo.private ? Colors.orange : Theme.of(context).primaryColor,
        ),
        title: Text(
          repo.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (repo.description != null)
              Text(
                repo.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 4),
            Row(
              children: [
                if (repo.language != null) ...[
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _getLanguageColor(repo.language!),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    repo.language!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 16),
                ],
                Icon(Icons.star, size: 14, color: Colors.amber),
                const SizedBox(width: 2),
                Text(
                  repo.stargazersCount.toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(width: 16),
                Icon(Icons.fork_right, size: 14, color: Colors.grey),
                const SizedBox(width: 2),
                Text(
                  repo.forksCount.toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          // Navigate to repository details
          Get.toNamed('/repository', arguments: repo);
        },
      ),
    );
  }

  Widget _buildRepositoryGridItem(BuildContext context, repo) {
    return GestureDetector(
      onTap: () {
        // Navigate to repository details
        Get.toNamed('/repository', arguments: repo);
      },
      child: Card(
        margin: const EdgeInsets.all(4),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    repo.private ? Icons.lock : Icons.folder,
                    color: repo.private ? Colors.orange : Theme.of(context).primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      repo.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (repo.description != null)
                Text(
                  repo.description!,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              const Spacer(),
              if (repo.language != null) ...[
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _getLanguageColor(repo.language!),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        repo.language!,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, size: 12, color: Colors.amber),
                      const SizedBox(width: 2),
                      Text(
                        repo.stargazersCount.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.fork_right, size: 12, color: Colors.grey),
                      const SizedBox(width: 2),
                      Text(
                        repo.forksCount.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getLanguageColor(String language) {
    // Simple color mapping for popular languages
    switch (language.toLowerCase()) {
      case 'dart':
        return const Color(0xFF0175C2);
      case 'javascript':
        return const Color(0xFFF7DF1E);
      case 'typescript':
        return const Color(0xFF3178C6);
      case 'python':
        return const Color(0xFF3776AB);
      case 'java':
        return const Color(0xFFED8B00);
      case 'kotlin':
        return const Color(0xFF7F52FF);
      case 'swift':
        return const Color(0xFFFA7343);
      case 'go':
        return const Color(0xFF00ADD8);
      case 'rust':
        return const Color(0xFFDEA584);
      case 'c++':
        return const Color(0xFF00599C);
      case 'c#':
        return const Color(0xFF239120);
      case 'php':
        return const Color(0xFF777BB4);
      case 'ruby':
        return const Color(0xFFCC342D);
      default:
        return Colors.grey;
    }
  }
}
