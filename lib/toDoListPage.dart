import 'package:flutter/material.dart';

class ToDoListPage extends StatefulWidget {
  final DateTime selectedDate;

  ToDoListPage({Key? key, required this.selectedDate}) : super(key: key);

  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To-Do List - ${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    tasks[index].name,
                    style: TextStyle(
                      decoration: tasks[index].isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Icon(
                    tasks[index].isCompleted
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: tasks[index].isCompleted
                        ? const Color.fromARGB(255, 50, 18, 139)
                        : Colors.red,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          _toggleTaskCompletion(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _removeTask(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showAddTaskDialog(context);
                  },
                  child: Text('Adicionar Tarefa'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showRemoveAllTasksDialog(context);
                  },
                  child: Text('Remover Todas'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Função para mostrar um dialogo para adicionar uma tarefa
  void _showAddTaskDialog(BuildContext context) {
    String newTaskName = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar tarefa'),
          content: TextField(
            onChanged: (value) {
              newTaskName = value;
            },
            decoration: InputDecoration(hintText: 'Nome da tarefa'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tasks.add(Task(name: newTaskName));
                });
                Navigator.pop(context);
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  //Função para mostrar um dialogo para remover todas as tarefas
  void _showRemoveAllTasksDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remover todas as tarefas'),
          content: Text('Tem certeza de que deseja remover todas as tarefas?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tasks.clear();
                });
                Navigator.pop(context);
              },
              child: Text('Remover todas'),
            ),
          ],
        );
      },
    );
  }

  //Função para alternar o estado de conclusão de uma tarefa
  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  //Função para remover uma tarefa
  void _removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }
}

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}
