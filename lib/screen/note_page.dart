import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:providers/provider/notes_provider.dart';

class NotePage extends ConsumerWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);
    TextEditingController textController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: notes.when(
        data: (notes) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: textController,

                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber, width: 2),
                        ),
                        hintText: 'Add Notes',
                        suffixIcon: IconButton(
                          onPressed: () {
                            ref
                                .read(notesProvider.notifier)
                                .addNotes(textController.text);
                          },
                          icon: Icon(Icons.check),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: TextButton(
                        onPressed: () {
                          final controller = TextEditingController(
                            text: notes[index].title,
                          );

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Edit Note'),
                                content: TextField(
                                  controller: controller,
                                  autofocus: true,
                                  onSubmitted: (newTitle) {
                                    ref
                                        .read(notesProvider.notifier)
                                        .editNotes(notes[index].id, newTitle);

                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: Text(notes[index].title),
                      ),
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
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          return Text('Error : $error');
        },
        loading: () {
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
