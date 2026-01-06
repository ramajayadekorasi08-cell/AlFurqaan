import '../../domain/entities/user_entity.dart';

/// Model untuk User dengan JSON serialization
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.nama,
    required super.email,
    required super.password,
    required super.role,
    super.kelasId,
    super.namaKelas,
    super.mapelId,
    super.namaMapel,
    super.nip,
  });

  /// From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(), // Convert int ID to String
      nama: json['name'] ?? json['nama'] ?? '', // Handle 'name' from Laravel
      email: json['email'] ?? '',
      password: '', // Password usually not returned in user object
      role: json['role'] ?? 'user',
      kelasId: json['kelas_id'] ?? json['kelasId'], // Handle snake_case
      namaKelas: json['nama_kelas'] ?? json['namaKelas'],
      mapelId: json['mapel_id'] ?? json['mapelId'],
      namaMapel: json['nama_mapel'] ?? json['namaMapel'],
      nip: json['nip'],
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'email': email,
      'password': password,
      'role': role,
      'kelasId': kelasId,
      'namaKelas': namaKelas,
      'mapelId': mapelId,
      'namaMapel': namaMapel,
      'nip': nip,
    };
  }

  /// From Entity
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      nama: entity.nama,
      email: entity.email,
      password: entity.password,
      role: entity.role,
      kelasId: entity.kelasId,
      namaKelas: entity.namaKelas,
      mapelId: entity.mapelId,
      namaMapel: entity.namaMapel,
      nip: entity.nip,
    );
  }

  /// To Entity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      nama: nama,
      email: email,
      password: password,
      role: role,
      kelasId: kelasId,
      namaKelas: namaKelas,
      mapelId: mapelId,
      namaMapel: namaMapel,
      nip: nip,
    );
  }
}
