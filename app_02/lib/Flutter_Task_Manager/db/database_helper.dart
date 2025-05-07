import 'package:sqflite/sqflite.dart';
import '../Models/user.dart';
import '../Models/task.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    return await openDatabase(
      'task_manager.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE users (
          id TEXT PRIMARY KEY,
          username TEXT NOT NULL,
          password TEXT NOT NULL,
          email TEXT NOT NULL,
          avatar TEXT,
          createdAt TEXT NOT NULL,
          lastActive TEXT NOT NULL
        )''');
        await db.execute('''CREATE TABLE tasks (
          id TEXT PRIMARY KEY,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          status TEXT NOT NULL,
          priority INTEGER NOT NULL,
          dueDate TEXT,
          createdAt TEXT NOT NULL,
          updatedAt TEXT NOT NULL,
          assignedTo TEXT,
          createdBy TEXT NOT NULL,
          category TEXT,
          attachments TEXT,
          completed INTEGER NOT NULL
        )''');
      },
    );
  }

  // Phương thức CRUD cho Người dùng
  Future<void> insertUser (User user) async {
    final db = await database;
    await db.insert('users', user.toMap());
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        username: maps[i]['username'],
        password: maps[i]['password'],
        email: maps[i]['email'],
        avatar: maps[i]['avatar'],
        createdAt: DateTime.parse(maps[i]['createdAt']),
        lastActive: DateTime.parse(maps[i]['lastActive']),
      );
    });
  }

  // Phương thức CRUD cho Công việc
  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        status: maps[i]['status'],
        priority: maps[i]['priority'],
        dueDate: DateTime.tryParse(maps[i]['dueDate']),
        createdAt: DateTime.parse(maps[i]['createdAt']),
        updatedAt: DateTime.parse(maps[i]['updatedAt']),
        assignedTo: maps[i]['assignedTo'],
        createdBy: maps[i]['createdBy'],
        category: maps[i]['category'],
        attachments: maps[i]['attachments']?.split(','),
        completed: maps[i]['completed'] == 1,
      );
    });
  }

  // Phương thức tìm kiếm và lọc dữ liệu
  Future<List<Task>> searchTasks(String query, String status) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'title LIKE ? AND (status = ? OR ? = "Tất cả")',
      whereArgs: ['%$query%', status, status],
    );
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        status: maps[i]['status'],
        priority: maps[i]['priority'],
        dueDate: DateTime.tryParse(maps[i]['dueDate']),
        createdAt: DateTime.parse(maps[i]['createdAt']),
        updatedAt: DateTime.parse(maps[i]['updatedAt']),
        assignedTo: maps[i]['assignedTo'],
        createdBy: maps[i]['createdBy'],
        category: maps[i]['category'],
        attachments: maps[i]['attachments']?.split(','),
        completed: maps[i]['completed'] == 1,
      );
    });
  }
}