String formatRelativeTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  DateTime now = DateTime.now();

  Duration difference = now.difference(dateTime);

  if (difference.inDays > 0) {
    return '${difference.inDays} days ${difference.inHours % 24} hours ${difference.inMinutes % 60} minutes ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} hours ${difference.inMinutes % 60} minutes ago';
  } else {
    return '${difference.inMinutes} minutes ago';
  }
}
