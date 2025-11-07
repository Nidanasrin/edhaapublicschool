import 'package:flutter/material.dart';
import 'package:raynottschool/screens/categories/todo_list/add_new.dart';
import 'package:raynottschool/screens/categories/todo_list/todoList_details.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
final List<Map<String,dynamic>> todoList = [];


void todoListDetail()async{
  final result = await Navigator.push(context, MaterialPageRoute(builder: (context)=> AddNew()));
  if(result != null && result is Map<String,dynamic>){
    setState(() {
      todoList.add(result);
    });
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 20,),
            Expanded(child: todoList.isEmpty ? Center(
              child: Text("No ToDo List Added Yet",style: TextStyle(color: Colors.white),),
            ): ListView.separated(itemBuilder: (context,index){
    final task = todoList[index];
    return ListTile(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TodoDetails(task: task),
          ),
        );

        // Handle action results
        if (result == 'delete') {
          setState(() => todoList.removeAt(index));
        } else if (result == 'complete') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Task marked as completed!')),
          );
        } else if (result == 'reschedule') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('You can reschedule this task later.')),
          );
        }
      },
      title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(task['Task Title'],style: TextStyle(color: Colors.white,fontSize: 16),),
      SizedBox(height: 5,),
        Text(task['Comments'],style: TextStyle(color: Colors.white,fontSize: 15),),
        SizedBox(height: 3,),
        Text("${task['Date']}  ${task['Time']}",style: TextStyle(color: Colors.white,fontSize: 15),)
      ],
      )
    );
    }, separatorBuilder: (context,index)=> Divider(height: 20,thickness: 1,color: Colors.white,), itemCount: todoList.length)),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade900,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                              width: 2, color: Colors.white)),
                      foregroundColor: Colors.white),
                  onPressed: () {
                    todoListDetail();
                  }, child: Text("ADD NEW")),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
