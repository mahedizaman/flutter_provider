import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:providers/provider/notes_provider.dart';

class NotePage extends ConsumerWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: notes.when(
        data: (notes) {
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              final note = notes[index];
              return ListTile(
                title: Text(notes[index].title),
                leading: IconButton(
                  onPressed: () {
                    ref
                        .read(notesProvider.notifier)
                        .deleteNotes(notes[index].id);
                  },
                  icon: Icon(Icons.delete),
                ),
              );
            },
          );
        },
        error: (error, stackTrace) {
          print('Error : $error');
        },
        loading: () {
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
