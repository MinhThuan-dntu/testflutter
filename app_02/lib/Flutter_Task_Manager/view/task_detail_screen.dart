import 'package:flutter/material.dart';
import '../Models/task.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  TaskDetailScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(task.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mô tả: ${task.description}'),
            SizedBox(height: 10),
            Text('Ngày đến hạn: ${task.dueDate?.toLocal().toString().split(' ')[0] ?? 'N/A'}'),
            SizedBox(height: 10),
            Text('Trạng thái: ${task.status}'),
            SizedBox(height: 10),
            Text('Độ ưu tiên: ${task.priority}'),
            SizedBox(height: 10),
            if (task.attachments != null && task.attachments!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tệp đính kèm:'),
                  ...task.attachments!.map((attachment) => Text(attachment)).toList(),
                ],
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to update task status
              },
              child: Text('Cập nhật trạng thái'),
            ),
          ],
        ),
      ),
    );
  }
}