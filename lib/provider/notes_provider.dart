import 'package:flutter_riverpod/flutter_riverpod.dart';

class Note {
  final String id;
  final String title;
  Note({required this.id, required this.title});
}

Future<List<Note>> fetchNotes() async {
  await Future.delayed(Duration(seconds: 2));

  return [
    Note(id: '1', title: 'note1'),
    Note(id: '2', title: 'note2'),
    Note(id: '3', title: 'note3'),
    Note(id: '4', title: 'note4'),
    Note(id: '5', title: 'note5'),
  ];
}

class NotesNotifier extends AsyncNotifier<List<Note>> {
  @override
  Future<List<Note>> build() async {
    return fetchNotes();
  }

  Future<void> addNotes(String title) async {
    final currentNotes = state.value ?? [];
    final newNotes = Note(id: DateTime.now().toString(), title: title);
    state = AsyncData([...currentNotes, newNotes]);
  }

  Future<void> deleteNotes(String id) async {
    final currentNotes = state.value ?? [];
    state = AsyncData(currentNotes.where((note) => note.id != id).toList());
  }

  Future<void> editNotes(String id, String newTitle) async {
    final currentNotes = state.value ?? [];
    final updatedNotes = currentNotes.map((note) {
      if (note.id == id) {
        return Note(id: note.id, title: newTitle);
      }
      return note;
    }).toList();
    state = AsyncData(updatedNotes);
  }
}

final notesProvider = AsyncNotifierProvider<NotesNotifier, List<Note>>(
  NotesNotifier.new,
);
