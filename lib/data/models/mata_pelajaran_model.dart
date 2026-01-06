import '../../domain/entities/mata_pelajaran_entity.dart';

/// Model untuk Mata Pelajaran dengan JSON serialization
class MataPelajaranModel extends MataPelajaranEntity {
  const MataPelajaranModel({
    required super.id,
    required super.kode,
    required super.nama,
    super.kkm,
  });

  /// From JSON
  factory MataPelajaranModel.fromJson(Map<String, dynamic> json) {
    return MataPelajaranModel(
      id: json['id'] as String,
      kode: json['kode'] as String,
      nama: json['nama'] as String,
      kkm: json['kkm'] as int?,
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kode': kode,
      'nama': nama,
      'kkm': kkm,
    };
  }

  /// From Entity
  factory MataPelajaranModel.fromEntity(MataPelajaranEntity entity) {
    return MataPelajaranModel(
      id: entity.id,
      kode: entity.kode,
      nama: entity.nama,
      kkm: entity.kkm,
    );
  }

  /// To Entity
  MataPelajaranEntity toEntity() {
    return MataPelajaranEntity(
      id: id,
      kode: kode,
      nama: nama,
      kkm: kkm,
    );
  }
}
