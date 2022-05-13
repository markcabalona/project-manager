class Task {
  String id;
  String title;
  String content;
  bool isPriority;
  DateTime dateCreated;
  DateTime lastUpdated;
  bool isFinished;
  Task({
    required this.id,
    required this.title,
    required this.content,
    required this.isPriority,
    required this.dateCreated,
    required this.lastUpdated,
    required this.isFinished,
  });
}
