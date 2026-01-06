import '../entities/user_entity.dart';

/// Repository interface untuk User
abstract class UserRepository {
  /// Login user
  Future<UserEntity?> login(String email, String password);
  
  /// Get all users
  Future<List<UserEntity>> getAllUsers();
  
  /// Get users by role
  Future<List<UserEntity>> getUsersByRole(String role);
  
  /// Get user by ID
  Future<UserEntity?> getUserById(String id);
  
  /// Create new user (Teacher)
  /// Create new user (Teacher or Wali Kelas)
  Future<void> createUser({
    required String nama,
    required String email,
    required String password,
    required String role,
    String? namaMapel,
    String? kelasId,
    String? namaKelas,
  });
}
