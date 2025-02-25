/// Function to generate keywords from text.
/// It splits the text into words and normalizes them (e.g., lowercase).
List<String> generateKeywords(String text) {
  final words = text
      .toLowerCase() // Normalize to lowercase
      .replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '') // Remove non-alphanumeric characters
      .split(RegExp(r'\s+')); // Split by whitespace (space, tabs, newlines)
  return words.where((word) => word.isNotEmpty).toList(); // Filter out empty words
}

/// Generates substrings for Firestore keyword search.
/// Helps optimize partial matches without fetching all users etc.
List<String> generateSubstrings(String query) {
  List<String> substrings = [];

  for (int i = 0; i < query.length; i++) {
    substrings.add(query.substring(0, i + 1)); // e.g., "c", "co", "cool"
  }

  return substrings;
}