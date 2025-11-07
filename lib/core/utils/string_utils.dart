class StringUtils {
  static bool isNullOrEmpty(String? str) {
    return str == null || str.isEmpty;
  }

  static bool isNotNullOrEmpty(String? str) {
    return !isNullOrEmpty(str);
  }

  static String capitalize(String str) {
    if (str.isEmpty) return str;
    return str[0].toUpperCase() + str.substring(1);
  }

  static String formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }

  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }

  static bool isValidUsername(String username) {
    // GitHub username validation
    // Username can have alphanumeric characters and hyphens
    // Cannot start or end with hyphen
    // Cannot have consecutive hyphens
    // Must be 1-39 characters long
    if (username.isEmpty || username.length > 39) {
      return false;
    }
    
    final regex = RegExp(r'^[a-zA-Z0-9]([a-zA-Z0-9]|-(?=[a-zA-Z0-9])){0,38}$');
    return regex.hasMatch(username);
  }

  static String? validateGitHubUsername(String? username) {
    if (isNullOrEmpty(username)) {
      return 'Username is required';
    }
    
    final cleanUsername = username!.trim();
    
    if (cleanUsername.length < 1) {
      return 'Username must be at least 1 character';
    }
    
    if (cleanUsername.length > 39) {
      return 'Username must be less than 40 characters';
    }
    
    if (cleanUsername.startsWith('-') || cleanUsername.endsWith('-')) {
      return 'Username cannot start or end with a hyphen';
    }
    
    if (cleanUsername.contains('--')) {
      return 'Username cannot contain consecutive hyphens';
    }
    
    if (!RegExp(r'^[a-zA-Z0-9-]+$').hasMatch(cleanUsername)) {
      return 'Username can only contain letters, numbers, and hyphens';
    }
    
    return null;
  }
}
