// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TaskDao? _taskDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TaskModel` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `description` TEXT, `createdDate` TEXT, `isCompleted` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TaskDao get taskDao {
    return _taskDaoInstance ??= _$TaskDao(database, changeListener);
  }
}

class _$TaskDao extends TaskDao {
  _$TaskDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _taskModelInsertionAdapter = InsertionAdapter(
            database,
            'TaskModel',
            (TaskModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'createdDate': item.createdDate,
                  'isCompleted': item.isCompleted
                },
            changeListener),
        _taskModelUpdateAdapter = UpdateAdapter(
            database,
            'TaskModel',
            ['id'],
            (TaskModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'createdDate': item.createdDate,
                  'isCompleted': item.isCompleted
                },
            changeListener),
        _taskModelDeletionAdapter = DeletionAdapter(
            database,
            'TaskModel',
            ['id'],
            (TaskModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'createdDate': item.createdDate,
                  'isCompleted': item.isCompleted
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TaskModel> _taskModelInsertionAdapter;

  final UpdateAdapter<TaskModel> _taskModelUpdateAdapter;

  final DeletionAdapter<TaskModel> _taskModelDeletionAdapter;

  @override
  Future<List<TaskModel>> findAllTasks() async {
    return _queryAdapter.queryList('SELECT * FROM TaskModel',
        mapper: (Map<String, Object?> row) => TaskModel(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            createdDate: row['createdDate'] as String?,
            isCompleted: row['isCompleted'] as int?));
  }

  @override
  Stream<TaskModel?> findTaskById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM TaskModel WHERE id = ?1',
        mapper: (Map<String, Object?> row) => TaskModel(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            createdDate: row['createdDate'] as String?,
            isCompleted: row['isCompleted'] as int?),
        arguments: [id],
        queryableName: 'TaskModel',
        isView: false);
  }

  @override
  Future<List<TaskModel>> getListTaskModelByStatus(int isCompleted) async {
    return _queryAdapter.queryList(
        'SELECT * FROM TaskModel WHERE isCompleted = ?1',
        mapper: (Map<String, Object?> row) => TaskModel(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            createdDate: row['createdDate'] as String?,
            isCompleted: row['isCompleted'] as int?),
        arguments: [isCompleted]);
  }

  @override
  Future<void> insertTask(TaskModel task) async {
    await _taskModelInsertionAdapter.insert(task, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    await _taskModelUpdateAdapter.update(task, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTask(TaskModel task) async {
    await _taskModelDeletionAdapter.delete(task);
  }
}
