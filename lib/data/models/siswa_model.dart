import '../../domain/entities/siswa_entity.dart';

/// Model untuk Siswa dengan JSON serialization
class SiswaModel extends SiswaEntity {
  const SiswaModel({
    required super.id,
    required super.nis,
    required super.nama,
    required super.kelasId,
    required super.namaKelas,
    required super.tahunAjaran,
    required super.semester,
    super.alamat,
    super.noTelp,
  });

  /// From JSON
  factory SiswaModel.fromJson(Map<String, dynamic> json) {
    return SiswaModel(
      id: json['id'].toString(),
      nis: json['nis'] as String,
      nama: json['nama'] as String,
      kelasId: json['kelas_id'] as String,
      namaKelas: json['nama_kelas'] as String,
      tahunAjaran: json['tahun_ajaran'] as String,
      semester: json['semester'] as String,
      alamat: json['alamat'] as String?,
      noTelp: json['no_telp'] as String?,
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nis': nis,
      'nama': nama,
      'kelas_id': kelasId,
      'nama_kelas': namaKelas,
      'tahun_ajaran': tahunAjaran,
      'semester': semester,
      'alamat': alamat,
      'no_telp': noTelp,
    };
  }

  /// From Entity
  factory SiswaModel.fromEntity(SiswaEntity entity) {
    return SiswaModel(
      id: entity.id,
      nis: entity.nis,
      nama: entity.nama,
      kelasId: entity.kelasId,
      namaKelas: entity.namaKelas,
      tahunAjaran: entity.tahunAjaran,
      semester: entity.semester,
      alamat: entity.alamat,
      noTelp: entity.noTelp,
    );
  }

  /// To Entity
  SiswaEntity toEntity() {
    return SiswaEntity(
      id: id,
      nis: nis,
      nama: nama,
      kelasId: kelasId,
      namaKelas: namaKelas,
      tahunAjaran: tahunAjaran,
      semester: semester,
      alamat: alamat,
      noTelp: noTelp,
    );
  }
}
