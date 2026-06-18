import 'package:flutter/material.dart';

class ToDoListPage extends StatefulWidget {
  final DateTime selectedDate;

  const ToDoListPage({super.key, required this.selectedDate});

  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Tarefas"), centerTitle: true),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          children: [
            const SizedBox(height: 20),

            const Icon(Icons.task_alt, size: 70, color: Colors.white),

            const SizedBox(height: 10),

            Text(
              "${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 6,
                    ),

                    elevation: 6,

                    color: tasks[index].isCompleted
                        ? Colors.green.shade100
                        : Colors.orange.shade100,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: ListTile(
                      leading: Icon(
                        tasks[index].isCompleted
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: tasks[index].isCompleted
                            ? Colors.green
                            : Colors.orange,
                      ),

                      title: Text(
                        tasks[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          decoration: tasks[index].isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check),
                            color: Colors.green,
                            onPressed: () {
                              _toggleTaskCompletion(index);
                            },
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              _removeTask(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton.extended(
                    backgroundColor: Colors.green,
                    onPressed: () {
                      _showAddTaskDialog(context);
                      sortTasks();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Adicionar"),
                  ),

                  FloatingActionButton.extended(
                    backgroundColor: Colors.red,
                    onPressed: () {
                      _showRemoveAllTasksDialog(context);
                    },
                    icon: const Icon(Icons.delete_forever),
                    label: const Text("Limpar"),
                  ),
                ],
              ),
            ),
          ],
        ),
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
      sortTasks();
    });
  }

  //Função para remover uma tarefa
  void _removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  //Funçào para ordenar as tarefas
  void sortTasks() {
    tasks.sort((a, b) {
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }

      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
  }
}

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}
