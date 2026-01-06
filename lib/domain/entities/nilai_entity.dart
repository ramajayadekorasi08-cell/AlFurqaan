import 'package:equatable/equatable.dart';

/// Entity untuk Nilai Siswa
class NilaiEntity extends Equatable {
  final String id;
  final String siswaId;
  final String namaSiswa;
  final String mapelId;
  final String namaMapel;
  final String guruId;
  final String namaGuru;
  final double nilaiTugas;
  final double nilaiUTS;
  final double nilaiUAS;
  final double nilaiAkhir;
  final String tahunAjaran;
  final String semester;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const NilaiEntity({
    required this.id,
    required this.siswaId,
    required this.namaSiswa,
    required this.mapelId,
    required this.namaMapel,
    required this.guruId,
    required this.namaGuru,
    required this.nilaiTugas,
    required this.nilaiUTS,
    required this.nilaiUAS,
    required this.nilaiAkhir,
    required this.tahunAjaran,
    required this.semester,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        siswaId,
        namaSiswa,
        mapelId,
        namaMapel,
        guruId,
        namaGuru,
        nilaiTugas,
        nilaiUTS,
        nilaiUAS,
        nilaiAkhir,
        tahunAjaran,
        semester,
        createdAt,
        updatedAt,
      ];

  /// Hitung nilai akhir berdasarkan bobot
  /// Formula: (Tugas × 30%) + (UTS × 30%) + (UAS × 40%)
  static double hitungNilaiAkhir({
    required double nilaiTugas,
    required double nilaiUTS,
    required double nilaiUAS,
  }) {
    const bobotTugas = 0.30;
    const bobotUTS = 0.30;
    const bobotUAS = 0.40;

    final nilaiAkhir = (nilaiTugas * bobotTugas) +
        (nilaiUTS * bobotUTS) +
        (nilaiUAS * bobotUAS);

    // Bulatkan ke 2 desimal
    return double.parse(nilaiAkhir.toStringAsFixed(2));
  }

  /// Helper untuk mendapatkan grade
  String get grade {
    if (nilaiAkhir >= 90) return 'A';
    if (nilaiAkhir >= 80) return 'B';
    if (nilaiAkhir >= 70) return 'C';
    if (nilaiAkhir >= 60) return 'D';
    return 'E';
  }

  /// Helper untuk status kelulusan (asumsi KKM 75)
  bool get lulus => nilaiAkhir >= 75;
}
