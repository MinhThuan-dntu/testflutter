import 'package:flutter/material.dart';
import '../Models/task.dart';
import '../db/database_helper.dart';

class TaskForm extends StatelessWidget {
  final Task? task;
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  TaskForm({this.task});

  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  DateTime? dueDate;
  int priority = 1; // Mặc định là 1
  String status = 'Công việc'; // Mặc định là 'Công việc'
  String? assignedTo; // Trường mới cho người được giao
  List<String> attachments = []; // Trường mới cho tệp đính kèm

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(task == null ? 'Thêm Công Việc' : 'Chỉnh Sửa Công Việc')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: task?.title,
                decoration: InputDecoration(labelText: 'Tiêu đề'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tiêu đề';
                  }
                  return null;
                },
                onChanged: (value) {
                  title = value;
                },
              ),
              TextFormField(
                initialValue: task?.description,
                decoration: InputDecoration(labelText: 'Mô tả'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mô tả';
                  }
                  return null;
                },
                onChanged: (value) {
                  description = value;
                },
              ),
              DropdownButton<String>(
                value: status,
                items: ['Công việc', 'Đang tiến hành', 'Hoàn thành', 'Bị hủy'].map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  status = newValue!;
                },
              ),
              TextButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: dueDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != dueDate) {
                    dueDate = picked;
                  }
                },
                child: Text('Chọn ngày đến hạn: ${dueDate?.toLocal().toString().split(' ')[0] ?? 'Chưa chọn'}'),
              ),
              // Thêm chức năng gán công việc và tải lên tệp đính kèm ở đây
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Task newTask = Task(
                      id: DateTime.now().toString(),
                      title: title,
                      description: description,
                      status: status,
                      priority: priority,
                      dueDate: dueDate,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                      assignedTo: assignedTo,
                      createdBy: 'user_id', // Thay thế bằng ID người tạo
                      category: null,
                      attachments: attachments,
                      completed: false,
                    );
                    await _databaseHelper.insertTask(newTask);
                    Navigator.pop(context); // Quay lại màn hình danh sách công việc
                  }
                },
                child: Text('Lưu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}