import 'package:equatable/equatable.dart';

/// Entity untuk User (Guru/Kepala Sekolah)
class UserEntity extends Equatable {
  final String id;
  final String nama;
  final String email;
  final String password;
  final String role; // super_admin, admin, user
  final String? kelasId; // untuk wali kelas
  final String? namaKelas; // untuk wali kelas
  final String? mapelId; // untuk guru mapel
  final String? namaMapel; // untuk guru mapel
  final String? nip;

  const UserEntity({
    required this.id,
    required this.nama,
    required this.email,
    required this.password,
    required this.role,
    this.kelasId,
    this.namaKelas,
    this.mapelId,
    this.namaMapel,
    this.nip,
  });

  @override
  List<Object?> get props => [
        id,
        nama,
        email,
        password,
        role,
        kelasId,
        namaKelas,
        mapelId,
        namaMapel,
        nip,
      ];

  // Helper methods
  bool get isSuperAdmin => role == 'super_admin';
  bool get isAdmin => role == 'admin';
  bool get isUser => role == 'user';

  String get roleDisplay {
    switch (role) {
      case 'super_admin':
        return 'Kepala Sekolah';
      case 'admin':
        return 'Guru Mapel';
      case 'user':
        return 'Guru Wali Kelas';
      default:
        return 'Unknown';
    }
  }
}
