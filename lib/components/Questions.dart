class Question {
  final int index;
  final String text;
  final int type;
  final List<String> answers;
  final bool isLinked;

  Question({
    required this.index,
    required this.text,
    required this.type,
    required this.answers,
    this.isLinked = false,
  });
}