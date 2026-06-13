import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  final DateTime selectedDate;

  const TodoListPage({super.key, required this.selectedDate});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Tarefas')),
      body: Center(
        child: Text(
          'Data selecionada: ${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}',
        ),
      ),
    );
  }
}
