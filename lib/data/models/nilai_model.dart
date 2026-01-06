import '../../domain/entities/nilai_entity.dart';

/// Model untuk Nilai dengan JSON serialization
class NilaiModel extends NilaiEntity {
  const NilaiModel({
    required super.id,
    required super.siswaId,
    required super.namaSiswa,
    required super.mapelId,
    required super.namaMapel,
    required super.guruId,
    required super.namaGuru,
    required super.nilaiTugas,
    required super.nilaiUTS,
    required super.nilaiUAS,
    required super.nilaiAkhir,
    required super.tahunAjaran,
    required super.semester,
    super.createdAt,
    super.updatedAt,
  });

  /// From JSON
  factory NilaiModel.fromJson(Map<String, dynamic> json) {
    return NilaiModel(
      id: json['id'].toString(),
      siswaId: json['siswa_id'].toString(),
      namaSiswa: json['nama_siswa'] as String,
      mapelId: json['mapel_id'] as String,
      namaMapel: json['nama_mapel'] as String,
      guruId: json['guru_id'].toString(),
      namaGuru: json['nama_guru'] as String,
      nilaiTugas: double.parse(json['nilai_tugas'].toString()),
      nilaiUTS: double.parse(json['nilai_uts'].toString()),
      nilaiUAS: double.parse(json['nilai_uas'].toString()),
      nilaiAkhir: double.parse(json['nilai_akhir'].toString()),
      tahunAjaran: json['tahun_ajaran'] as String,
      semester: json['semester'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'siswa_id': siswaId,
      'nama_siswa': namaSiswa,
      'mapel_id': mapelId,
      'nama_mapel': namaMapel,
      'guru_id': guruId,
      'nama_guru': namaGuru,
      'nilai_tugas': nilaiTugas,
      'nilai_uts': nilaiUTS,
      'nilai_uas': nilaiUAS,
      'nilai_akhir': nilaiAkhir,
      'grade': grade,
      'tahun_ajaran': tahunAjaran,
      'semester': semester,
    };
  }

  /// From Entity
  factory NilaiModel.fromEntity(NilaiEntity entity) {
    return NilaiModel(
      id: entity.id,
      siswaId: entity.siswaId,
      namaSiswa: entity.namaSiswa,
      mapelId: entity.mapelId,
      namaMapel: entity.namaMapel,
      guruId: entity.guruId,
      namaGuru: entity.namaGuru,
      nilaiTugas: entity.nilaiTugas,
      nilaiUTS: entity.nilaiUTS,
      nilaiUAS: entity.nilaiUAS,
      nilaiAkhir: entity.nilaiAkhir,
      tahunAjaran: entity.tahunAjaran,
      semester: entity.semester,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// To Entity
  NilaiEntity toEntity() {
    return NilaiEntity(
      id: id,
      siswaId: siswaId,
      namaSiswa: namaSiswa,
      mapelId: mapelId,
      namaMapel: namaMapel,
      guruId: guruId,
      namaGuru: namaGuru,
      nilaiTugas: nilaiTugas,
      nilaiUTS: nilaiUTS,
      nilaiUAS: nilaiUAS,
      nilaiAkhir: nilaiAkhir,
      tahunAjaran: tahunAjaran,
      semester: semester,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create dengan perhitungan nilai akhir otomatis
  factory NilaiModel.create({
    required String id,
    required String siswaId,
    required String namaSiswa,
    required String mapelId,
    required String namaMapel,
    required String guruId,
    required String namaGuru,
    required double nilaiTugas,
    required double nilaiUTS,
    required double nilaiUAS,
    required String tahunAjaran,
    required String semester,
  }) {
    final nilaiAkhir = NilaiEntity.hitungNilaiAkhir(
      nilaiTugas: nilaiTugas,
      nilaiUTS: nilaiUTS,
      nilaiUAS: nilaiUAS,
    );

    return NilaiModel(
      id: id,
      siswaId: siswaId,
      namaSiswa: namaSiswa,
      mapelId: mapelId,
      namaMapel: namaMapel,
      guruId: guruId,
      namaGuru: namaGuru,
      nilaiTugas: nilaiTugas,
      nilaiUTS: nilaiUTS,
      nilaiUAS: nilaiUAS,
      nilaiAkhir: nilaiAkhir,
      tahunAjaran: tahunAjaran,
      semester: semester,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Copy with untuk update
  NilaiModel copyWith({
    String? id,
    String? siswaId,
    String? namaSiswa,
    String? mapelId,
    String? namaMapel,
    String? guruId,
    String? namaGuru,
    double? nilaiTugas,
    double? nilaiUTS,
    double? nilaiUAS,
    double? nilaiAkhir,
    String? tahunAjaran,
    String? semester,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NilaiModel(
      id: id ?? this.id,
      siswaId: siswaId ?? this.siswaId,
      namaSiswa: namaSiswa ?? this.namaSiswa,
      mapelId: mapelId ?? this.mapelId,
      namaMapel: namaMapel ?? this.namaMapel,
      guruId: guruId ?? this.guruId,
      namaGuru: namaGuru ?? this.namaGuru,
      nilaiTugas: nilaiTugas ?? this.nilaiTugas,
      nilaiUTS: nilaiUTS ?? this.nilaiUTS,
      nilaiUAS: nilaiUAS ?? this.nilaiUAS,
      nilaiAkhir: nilaiAkhir ?? this.nilaiAkhir,
      tahunAjaran: tahunAjaran ?? this.tahunAjaran,
      semester: semester ?? this.semester,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
