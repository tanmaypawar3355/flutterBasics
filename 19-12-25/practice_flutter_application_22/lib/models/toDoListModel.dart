class TodoListModel {
  final int id;
  String title;
  String description;
  String date;

  TodoListModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory TodoListModel.fromMap(Map<String, dynamic> map) {
    return TodoListModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
    );
  }

}
