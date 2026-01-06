import '../../domain/entities/siswa_entity.dart';
import '../../domain/repositories/siswa_repository.dart';
import '../datasources/remote_data_source.dart';
import '../models/siswa_model.dart';

/// Implementasi SiswaRepository menggunakan RemoteDataSource
class SiswaRepositoryImpl implements SiswaRepository {
  final RemoteDataSource remoteDataSource;

  SiswaRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<SiswaEntity>> getAllSiswa() async {
    final siswa = await remoteDataSource.getAllSiswa();
    return siswa.map((s) => s.toEntity()).toList();
  }

  @override
  Future<List<SiswaEntity>> getSiswaByKelas(String kelasId) async {
    final siswa = await remoteDataSource.getSiswasByKelas(kelasId);
    return siswa.map((s) => s.toEntity()).toList();
  }

  @override
  Future<SiswaEntity?> getSiswaById(String id) async {
    // Implement getById if needed in RemoteDataSource
    return null;
  }

  @override
  Future<SiswaEntity> createSiswa(SiswaEntity siswa) async {
    final siswaModel = SiswaModel.fromEntity(siswa);
    final savedSiswa = await remoteDataSource.createSiswa(siswaModel);
    return savedSiswa.toEntity();
  }
}
