import '../entities/mata_pelajaran_entity.dart';

/// Repository interface untuk Mata Pelajaran
abstract class MataPelajaranRepository {
  /// Get all mata pelajaran
  Future<List<MataPelajaranEntity>> getAllMataPelajaran();
  
  /// Get mata pelajaran by ID
  Future<MataPelajaranEntity?> getMataPelajaranById(String id);
}
