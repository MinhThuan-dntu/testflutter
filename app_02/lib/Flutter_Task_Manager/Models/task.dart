class Task {
  final String id;
  final String title;
  final String description;
  final String status; // Công việc, Đang tiến hành, Hoàn thành, Bị hủy
  final int priority; // 1: Thấp, 2: Trung bình, 3: Cao
  final DateTime? dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? assignedTo; // ID người được giao
  final String createdBy; // ID người tạo
  final String? category; // Phân loại công việc
  final List<String>? attachments; // Danh sách link tài liệu đính kèm
  final bool completed; // Trạng thái hoàn thành

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    this.dueDate,
    required this.createdAt,
    required this.updatedAt,
    this.assignedTo,
    required this.createdBy,
    this.category,
    this.attachments,
    required this.completed,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'priority': priority,
      'dueDate': dueDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'assignedTo': assignedTo,
      'createdBy': createdBy,
      'category': category,
      'attachments': attachments?.join(','), // Chuyển danh sách thành chuỗi
      'completed': completed ? 1 : 0, // Chuyển đổi boolean thành số
    };
  }
}