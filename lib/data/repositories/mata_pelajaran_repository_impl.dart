import '../../domain/entities/mata_pelajaran_entity.dart';
import '../../domain/repositories/mata_pelajaran_repository.dart';
import '../datasources/mock_data_source.dart';

/// Implementasi MataPelajaranRepository menggunakan MockDataSource
class MataPelajaranRepositoryImpl implements MataPelajaranRepository {
  @override
  Future<List<MataPelajaranEntity>> getAllMataPelajaran() async {
    final mataPelajaran = await MockDataSource.getAllMataPelajaran();
    return mataPelajaran.map((m) => m.toEntity()).toList();
  }

  @override
  Future<MataPelajaranEntity?> getMataPelajaranById(String id) async {
    final mataPelajaran = await MockDataSource.getMataPelajaranById(id);
    return mataPelajaran?.toEntity();
  }
}
