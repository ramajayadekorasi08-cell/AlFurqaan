import '../entities/siswa_entity.dart';

/// Repository interface untuk Siswa
abstract class SiswaRepository {
  /// Get all siswa
  Future<List<SiswaEntity>> getAllSiswa();
  
  /// Get siswa by kelas
  Future<List<SiswaEntity>> getSiswaByKelas(String kelasId);
  
  /// Get siswa by ID
  Future<SiswaEntity?> getSiswaById(String id);

  /// Create new siswa
  Future<SiswaEntity> createSiswa(SiswaEntity siswa);
}
