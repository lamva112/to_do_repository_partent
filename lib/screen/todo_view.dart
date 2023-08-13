import 'package:flutter/material.dart';
import 'package:to_do/animations/fade_route.dart';
import 'package:to_do/models/todo.dart';
import 'package:to_do/widgets/todo_card.dart';
import 'package:to_do/widgets/todos_form_screen.dart';

class TodoView extends StatefulWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Todos",
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: 28,
              fontFamily: 'Cera'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (_) => ChangeNotifierProvider.value(
          //       value: context.read<TodosProvider>(),
          //       child: const TodosFormScreen(),
          //     ),
          //   ),
          // );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpeg'),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                // provider.todos.isEmpty
                //     ? const Center(
                //         child: Text('No todos added yet.'),
                //       )
                //     :
                RefreshIndicator(
              onRefresh: () async {
                //context.read<TodosProvider>().init();
              },
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    final todo = Todo(
                        id: "1",
                        title: "todo title",
                        description: "todo desciption",
                        completed: false);
                    return TodoCard(
                        todo: todo,
                        onTap: (todo) {
                          // todo.completed = !todo.completed;
                          // context
                          //     .read<TodosProvider>()
                          //     .update(todo);
                        },
                        onDelete: (todo) {
                          // context
                          //     .read<TodosProvider>()
                          //     .removeTodo(todo);
                        },
                        onEdit: (todo) {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         fullscreenDialog: true,
                          //         builder: (_) {
                          //           return ChangeNotifierProvider<
                          //               TodosProvider>.value(
                          //             value: context
                          //                 .read<TodosProvider>(),
                          //             child: TodosFormScreen(
                          //               todo: todo,
                          //             ),
                          //           );
                          //         }));
                          Navigator.pushReplacement(
                            context,
                            CustomPageRoute(
                              TodosFormScreen(
                                        todo: todo,
                                      ),
                            ),
                          );
                        });
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
