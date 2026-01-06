import '../entities/nilai_entity.dart';

/// Repository interface untuk Nilai
abstract class NilaiRepository {
  /// Get all nilai
  Future<List<NilaiEntity>> getAllNilai();
  
  /// Get nilai by siswa
  Future<List<NilaiEntity>> getNilaiBySiswa(String siswaId);
  
  /// Get nilai by guru
  Future<List<NilaiEntity>> getNilaiByGuru(String guruId);
  
  /// Get nilai by mapel dan siswa
  Future<NilaiEntity?> getNilaiByMapelSiswa(String mapelId, String siswaId);
  
  /// Save nilai (create or update)
  Future<NilaiEntity> saveNilai(NilaiEntity nilai);
  
  /// Delete nilai
  Future<bool> deleteNilai(String id);
}
