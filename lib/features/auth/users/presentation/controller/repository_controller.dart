import 'package:get/get.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../domain/get_repository_usecase.dart';
import '../../domain/get_user_repositories_usecase.dart';
import '../../domain/repository.dart';

enum SortOption { name, date, stars }
enum SortOrder { ascending, descending }
enum ViewMode { list, grid }

class RepositoryController extends GetxController {
  final GetUserRepositoriesUseCase getUserRepositoriesUseCase;
  final GetRepositoryUseCase getRepositoryUseCase;

  RepositoryController({
    required this.getUserRepositoriesUseCase,
    required this.getRepositoryUseCase,
  });

  final _isLoading = false.obs;
  final _repositories = <Repository>[].obs;
  final _filteredRepositories = <Repository>[].obs;
  final _errorMessage = ''.obs;
  final _sortOption = SortOption.name.obs;
  final _sortOrder = SortOrder.ascending.obs;
  final _viewMode = ViewMode.list.obs;
  final _searchQuery = ''.obs;

  bool get isLoading => _isLoading.value;
  List<Repository> get repositories => _filteredRepositories;
  String get errorMessage => _errorMessage.value;
  SortOption get sortOption => _sortOption.value;
  SortOrder get sortOrder => _sortOrder.value;
  ViewMode get viewMode => _viewMode.value;
  String get searchQuery => _searchQuery.value;

  @override
  void onInit() {
    super.onInit();
    // Listen to search query changes and filter repositories
    debounce(_searchQuery, (_) => _filterRepositories(), time: const Duration(milliseconds: 300));
  }

  Future<void> loadRepositories(String username) async {
    _isLoading.value = true;
    _errorMessage.value = '';

    try {
      final result = await getUserRepositoriesUseCase(username);
      
      if (result.success && result.data != null) {
        _repositories.assignAll(result.data!);
        _sortRepositories();
      } else {
        _errorMessage.value = result.message ?? 'Failed to load repositories';
      }
    } catch (e) {
      _errorMessage.value = AppStrings.unknownError;
    } finally {
      _isLoading.value = false;
    }
  }

  void setSortOption(SortOption option) {
    if (_sortOption.value == option) {
      // Toggle sort order if same option is selected
      _sortOrder.value = _sortOrder.value == SortOrder.ascending 
          ? SortOrder.descending 
          : SortOrder.ascending;
    } else {
      _sortOption.value = option;
      _sortOrder.value = SortOrder.ascending;
    }
    _sortRepositories();
  }

  void setViewMode(ViewMode mode) {
    _viewMode.value = mode;
  }

  void setSearchQuery(String query) {
    _searchQuery.value = query;
  }

  void _sortRepositories() {
    final repos = List<Repository>.from(_repositories);
    
    repos.sort((a, b) {
      int comparison;
      
      switch (_sortOption.value) {
        case SortOption.name:
          comparison = a.name.toLowerCase().compareTo(b.name.toLowerCase());
          break;
        case SortOption.date:
          final aDate = a.updatedAt ?? a.createdAt ?? DateTime.now();
          final bDate = b.updatedAt ?? b.createdAt ?? DateTime.now();
          comparison = aDate.compareTo(bDate);
          break;
        case SortOption.stars:
          comparison = a.stargazersCount.compareTo(b.stargazersCount);
          break;
      }
      
      return _sortOrder.value == SortOrder.ascending ? comparison : -comparison;
    });
    
    _repositories.assignAll(repos);
    _filterRepositories();
  }

  void _filterRepositories() {
    if (_searchQuery.value.isEmpty) {
      _filteredRepositories.assignAll(_repositories);
    } else {
      final query = _searchQuery.value.toLowerCase();
      final filtered = _repositories.where((repo) {
        return repo.name.toLowerCase().contains(query) ||
               (repo.description?.toLowerCase().contains(query) ?? false) ||
               (repo.language?.toLowerCase().contains(query) ?? false);
      }).toList();
      _filteredRepositories.assignAll(filtered);
    }
  }

  Future<Repository?> getRepositoryDetails(String owner, String repo) async {
    try {
      final result = await getRepositoryUseCase(owner, repo);
      if (result.success && result.data != null) {
        return result.data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  void clearError() {
    _errorMessage.value = '';
  }

  void refreshRepositories(String username) {
    loadRepositories(username);
  }
}
