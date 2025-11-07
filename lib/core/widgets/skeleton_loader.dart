import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Reusable skeleton loader widget for professional loading states
class SkeletonLoader extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsets padding;

  const SkeletonLoader({
    super.key,
    this.width = double.infinity,
    this.height = 16,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[800]!
          : Colors.grey[300]!,
      highlightColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[700]!
          : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[800]
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// Skeleton loader for user profile card
class UserProfileSkeletonLoader extends StatelessWidget {
  const UserProfileSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar skeleton
              SkeletonLoader(
                width: 60,
                height: 60,
                borderRadius: 30,
              ),
              const SizedBox(width: 16),
              // User info skeleton
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonLoader(
                      width: 150,
                      height: 20,
                      borderRadius: 4,
                    ),
                    const SizedBox(height: 8),
                    SkeletonLoader(
                      width: double.infinity,
                      height: 14,
                      borderRadius: 4,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: SkeletonLoader(
                            width: double.infinity,
                            height: 12,
                            borderRadius: 4,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SkeletonLoader(
                            width: double.infinity,
                            height: 12,
                            borderRadius: 4,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SkeletonLoader(
                            width: double.infinity,
                            height: 12,
                            borderRadius: 4,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Skeleton loader for repository list items
class RepositoryItemSkeletonLoader extends StatelessWidget {
  final bool isGrid;

  const RepositoryItemSkeletonLoader({
    super.key,
    this.isGrid = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isGrid) {
      return _buildGridSkeleton(context);
    }
    return _buildListSkeleton(context);
  }

  Widget _buildListSkeleton(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title skeleton
            SkeletonLoader(
              width: 200,
              height: 18,
              borderRadius: 4,
            ),
            const SizedBox(height: 12),
            // Description skeleton
            SkeletonLoader(
              width: double.infinity,
              height: 12,
              borderRadius: 4,
            ),
            const SizedBox(height: 8),
            SkeletonLoader(
              width: double.infinity,
              height: 12,
              borderRadius: 4,
            ),
            const SizedBox(height: 12),
            // Stats skeleton
            Row(
              children: [
                SkeletonLoader(
                  width: 80,
                  height: 10,
                  borderRadius: 4,
                ),
                const SizedBox(width: 16),
                SkeletonLoader(
                  width: 80,
                  height: 10,
                  borderRadius: 4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridSkeleton(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title skeleton
            SkeletonLoader(
              width: 150,
              height: 16,
              borderRadius: 4,
            ),
            const SizedBox(height: 12),
            // Description skeleton
            SkeletonLoader(
              width: double.infinity,
              height: 10,
              borderRadius: 4,
            ),
            const SizedBox(height: 6),
            SkeletonLoader(
              width: double.infinity,
              height: 10,
              borderRadius: 4,
            ),
            const Spacer(),
            // Language skeleton
            SkeletonLoader(
              width: 100,
              height: 10,
              borderRadius: 4,
            ),
            const SizedBox(height: 8),
            // Stats skeleton
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SkeletonLoader(
                  width: 60,
                  height: 10,
                  borderRadius: 4,
                ),
                SkeletonLoader(
                  width: 60,
                  height: 10,
                  borderRadius: 4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// List of skeleton loaders for repositories
class RepositoriesSkeletonList extends StatelessWidget {
  final int itemCount;
  final bool isGrid;

  const RepositoriesSkeletonList({
    super.key,
    this.itemCount = 6,
    this.isGrid = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isGrid) {
      return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => RepositoryItemSkeletonLoader(isGrid: true),
          childCount: itemCount,
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => RepositoryItemSkeletonLoader(isGrid: false),
        childCount: itemCount,
      ),
    );
  }
}

/// Skeleton loader for repository detail page
class RepositoryDetailSkeletonLoader extends StatelessWidget {
  const RepositoryDetailSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header skeleton
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonLoader(
                    width: 250,
                    height: 24,
                    borderRadius: 4,
                  ),
                  const SizedBox(height: 12),
                  SkeletonLoader(
                    width: double.infinity,
                    height: 14,
                    borderRadius: 4,
                  ),
                  const SizedBox(height: 8),
                  SkeletonLoader(
                    width: double.infinity,
                    height: 14,
                    borderRadius: 4,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: SkeletonLoader(
                          width: double.infinity,
                          height: 12,
                          borderRadius: 4,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SkeletonLoader(
                          width: double.infinity,
                          height: 12,
                          borderRadius: 4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Details skeleton
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonLoader(
                    width: 120,
                    height: 16,
                    borderRadius: 4,
                  ),
                  const SizedBox(height: 12),
                  SkeletonLoader(
                    width: double.infinity,
                    height: 12,
                    borderRadius: 4,
                  ),
                  const SizedBox(height: 8),
                  SkeletonLoader(
                    width: double.infinity,
                    height: 12,
                    borderRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
