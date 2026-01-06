import 'package:equatable/equatable.dart';

/// Entity untuk Siswa
class SiswaEntity extends Equatable {
  final String id;
  final String nis;
  final String nama;
  final String kelasId;
  final String namaKelas;
  final String tahunAjaran;
  final String semester;
  final String? alamat;
  final String? noTelp;

  const SiswaEntity({
    required this.id,
    required this.nis,
    required this.nama,
    required this.kelasId,
    required this.namaKelas,
    required this.tahunAjaran,
    required this.semester,
    this.alamat,
    this.noTelp,
  });

  @override
  List<Object?> get props => [
        id,
        nis,
        nama,
        kelasId,
        namaKelas,
        tahunAjaran,
        semester,
        alamat,
        noTelp,
      ];
}
