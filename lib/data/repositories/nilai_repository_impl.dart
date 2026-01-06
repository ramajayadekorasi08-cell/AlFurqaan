import '../../domain/entities/nilai_entity.dart';
import '../../domain/repositories/nilai_repository.dart';
import '../datasources/remote_data_source.dart';
import '../models/nilai_model.dart';

/// Implementasi NilaiRepository menggunakan RemoteDataSource
class NilaiRepositoryImpl implements NilaiRepository {
  final RemoteDataSource remoteDataSource;

  NilaiRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<NilaiEntity>> getAllNilai() async {
    return []; // Implement if needed
  }

  @override
  Future<List<NilaiEntity>> getNilaiBySiswa(String siswaId) async {
    final nilai = await remoteDataSource.getNilaiBySiswa(siswaId);
    return nilai.map((n) => n.toEntity()).toList();
  }

  @override
  Future<List<NilaiEntity>> getNilaiByGuru(String guruId) async {
    // Implement getByGuru if needed in RemoteDataSource
    return [];
  }

  @override
  Future<NilaiEntity?> getNilaiByMapelSiswa(
    String mapelId,
    String siswaId,
  ) async {
    final nilai = await remoteDataSource.getNilaiByMapelSiswa(mapelId, siswaId);
    return nilai?.toEntity();
  }

  @override
  Future<NilaiEntity> saveNilai(NilaiEntity nilai) async {
    final nilaiModel = NilaiModel.fromEntity(nilai);
    final savedNilai = await remoteDataSource.saveNilai(nilaiModel);
    return savedNilai.toEntity();
  }

  @override
  Future<bool> deleteNilai(String id) async {
    // Implement if needed in RemoteDataSource
    return false;
  }
}
