class NotesScreen extends StatelessWidget {
  final TextEditingController noteCtrl = TextEditingController();

  void showDialogToAddNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('New Note'),
        content: TextField(controller: noteCtrl),
        actions: [
          TextButton(
            onPressed: () {
              context.read<NotesCubit>().addNote(noteCtrl.text);
              noteCtrl.clear();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Note added!")));
            },
            child: Text('Save'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<NotesCubit>();
    return Scaffold(
      appBar: AppBar(title: Text('My Notes')),
      body: cubit.state.isEmpty
          ? Center(child: Text('Nothing here yet—tap ➕ to add a note.'))
          : ListView.builder(
              itemCount: cubit.state.length,
              itemBuilder: (context, i) {
                final note = cubit.state[i];
                return ListTile(
                  title: Text(note.text),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => context.read<NotesCubit>().updateNote(note.id, "Updated")),
                      IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            context.read<NotesCubit>().deleteNote(note.id);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Note deleted!")));
                          }),
                    ],
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialogToAddNote(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
