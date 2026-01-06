import 'package:equatable/equatable.dart';

/// Entity untuk Mata Pelajaran
class MataPelajaranEntity extends Equatable {
  final String id;
  final String kode;
  final String nama;
  final int? kkm; // Kriteria Ketuntasan Minimal

  const MataPelajaranEntity({
    required this.id,
    required this.kode,
    required this.nama,
    this.kkm,
  });

  @override
  List<Object?> get props => [id, kode, nama, kkm];
}
