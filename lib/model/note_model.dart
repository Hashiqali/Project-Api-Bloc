class Note {
  String note;
  String id;
  bool iscompleted;
  Note({required this.id, required this.iscompleted, required this.note});

  factory Note.fromjson(json) => (Note(
      id: json['id'].toString(),
      iscompleted: json['completed'],
      note: json['title']));
}
