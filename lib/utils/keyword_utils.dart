/// Function to generate keywords from text.
/// It splits the text into words and normalizes them (e.g., lowercase).
List<String> generateKeywords(String text) {
  final words = text
      .toLowerCase() // Normalize to lowercase
      .replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '') // Remove non-alphanumeric characters
      .split(RegExp(r'\s+')); // Split by whitespace (space, tabs, newlines)
  return words.where((word) => word.isNotEmpty).toList(); // Filter out empty words
}