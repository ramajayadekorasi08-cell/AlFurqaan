import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/remote_data_source.dart';

/// Implementasi UserRepository menggunakan MockDataSource
class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity?> login(String email, String password) async {
    final userModel = await remoteDataSource.login(email, password);
    return userModel?.toEntity();
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    final userModels = await remoteDataSource.getAllUsers();
    return userModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<UserEntity>> getUsersByRole(String role) async {
    final allUsers = await getAllUsers();
    return allUsers.where((user) => user.role == role).toList();
  }

  @override
  Future<UserEntity?> getUserById(String id) async {
    final allUsers = await getAllUsers();
    try {
      return allUsers.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> createUser({
    required String nama,
    required String email,
    required String password,
    required String role,
    String? namaMapel,
    String? kelasId,
    String? namaKelas,
  }) async {
    await remoteDataSource.createUser(
      nama,
      email,
      password,
      role,
      namaMapel: namaMapel,
      kelasId: kelasId,
      namaKelas: namaKelas,
    );
  }
}
