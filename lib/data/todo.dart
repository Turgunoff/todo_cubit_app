//
// @Author: "Eldor Turgunov"
// @Date: 11.10.2023
//
class Todo {
  final String id;
  final String title;
  bool isDone;

  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
  });
}
