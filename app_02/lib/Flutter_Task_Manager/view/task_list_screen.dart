import 'package:flutter/material.dart';
import 'task_detail_screen.dart';
import 'task_form.dart';
import '../Models/task.dart';
import '../db/database_helper.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];
  String searchQuery = '';
  String selectedStatus = 'Tất cả';
  String selectedCategory = 'Tất cả'; // Bộ lọc danh mục mới
  String displayMode = 'list'; // Thêm biến để lưu chế độ hiển thị
  List<String> statuses = ['Tất cả', 'Công việc', 'Đang tiến hành', 'Hoàn thành', 'Bị hủy'];
  List<String> categories = ['Tất cả', 'Cá nhân', 'Nhóm']; // Ví dụ về danh mục
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    tasks = await _databaseHelper.getTasks();
    tasks = tasks.where((task) {
      return (selectedStatus == 'Tất cả' || task.status == selectedStatus) &&
          (selectedCategory == 'Tất cả' || task.category == selectedCategory) &&
          task.title.contains(searchQuery);
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Công Việc'),
        actions: [
          DropdownButton<String>(
            value: selectedStatus,
            items: statuses.map((String status) {
              return DropdownMenuItem<String>(
                value: status,
                child: Text(status),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedStatus = newValue!;
                _loadTasks();
              });
            },
          ),
          DropdownButton<String>(
            value: selectedCategory,
            items: categories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue!;
                _loadTasks();
              });
            },
          ),
          DropdownButton<String>(
            value: displayMode,
            items: ['list', 'kanban'].map((String mode) {
              return DropdownMenuItem<String>(
                value: mode,
                child: Text(mode == 'list' ? 'Danh sách' : 'Kanban'),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                displayMode = newValue!;
                _loadTasks();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Tìm kiếm công việc',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
                _loadTasks();
              });
            },
          ),
          Expanded(
            child: displayMode == 'list' ? _buildListView() : _buildKanbanView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskForm()),
          ).then((_) => _loadTasks());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskItem(task: tasks[index], onDelete: () {
          setState(() {
            tasks.removeAt(index);
          });
        });
      },
    );
  }

  Widget _buildKanbanView() {
    // Tạo một widget đơn giản cho chế độ Kanban
    return Center(
      child: Text('Chế độ Kanban chưa được triển khai.'),
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;

  TaskItem({required this.task, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.check, color: task.completed ? Colors.green : Colors.grey),
              onPressed: () {
                // Logic to mark task as complete
              },
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskForm(task: task)),
                ).then((_) => onDelete());
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}