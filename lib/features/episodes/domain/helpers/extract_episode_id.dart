int? extractEpisodeId(String episodeUrl) {
  final Uri uri = Uri.parse(episodeUrl);
  final List<String> segments = uri.pathSegments;
  if (segments.isNotEmpty) {
    final String lastSegment = segments.last;
    return int.tryParse(lastSegment);
  }
  return null; // Return null if the URL is invalid or doesn't contain an ID
}
