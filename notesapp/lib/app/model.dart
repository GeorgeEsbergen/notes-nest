// ignore_for_file: unnecessary_this

class NoteModel {
  String? noteId;
  String? notesTitle;
  String? notesContent;
  String? notesImages;
  String? userId;

  NoteModel(
      {this.noteId,
        this.notesTitle,
        this.notesContent,
        this.notesImages,
        this.userId});

  NoteModel.fromJson(Map<String, dynamic> json) {
    noteId = json['note_id'];
    notesTitle = json['notes_title'];
    notesContent = json['notes_content'];
    notesImages = json['notes_images'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['note_id'] = this.noteId;
    data['notes_title'] = this.notesTitle;
    data['notes_content'] = this.notesContent;
    data['notes_images'] = this.notesImages;
    data['user_id'] = this.userId;
    return data;
  }
}