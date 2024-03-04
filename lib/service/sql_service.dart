import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/post_model.dart';

class SqlService {
  static const _databaseName = "my_sql.db";
  static const _databaseVersion = 1;

  static Database? _database;

  static Future<void> init() async {
    _database = await _initDatabase();
  }

  static _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE post (
          id INTEGER PRIMARY KEY,
          title TEXT NOT NULL,
          body TEXT NOT NULL
         )''');
  }

  static Future<Post> createPost(Post post) async {
    Database db = _database!;
    await db.insert("post", post.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return post;
  }

  static Future<List<Post>> fetchPosts() async {
    Database db = _database!;
    List<Map<String, dynamic>> results = await db.query("post");

    List<Post> posts = [];
    results.forEach((result) {
      Post post = Post.fromMap(result);
      posts.add(post);
    });
    return posts;
  }

  static Future<Post> fetchPost(int id) async {
    Database db = _database!;
    List<Map> results =
        await db.query("post", where: "id = ?", whereArgs: [id]);

    Post post = Post.fromMap(results[0]);
    return post;
  }

  static Future<int> deletePost(int id) async {
    Database db = _database!;
    return await db.delete("post", where: "id = ?", whereArgs: [id]);
  }

  static Future<Post> updatePost(Post post) async {
    Database db = _database!;
    var count = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM post WHERE id = ?", [post.id]));
    if (count != 0) {
      await db
          .update("post", post.toMap(), where: "id = ?", whereArgs: [post.id]);
    }
    return post;
  }
}
