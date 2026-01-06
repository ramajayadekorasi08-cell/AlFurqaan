import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/siswa_entity.dart';
import 'repository_providers.dart';

/// Provider untuk get all siswa
final allSiswaProvider = FutureProvider<List<SiswaEntity>>((ref) async {
  final repository = ref.read(siswaRepositoryProvider);
  return await repository.getAllSiswa();
});

/// Provider untuk get siswa by kelas
final siswaByKelasProvider = FutureProvider.family<List<SiswaEntity>, String>(
  (ref, kelasId) async {
    final repository = ref.read(siswaRepositoryProvider);
    return await repository.getSiswaByKelas(kelasId);
  },
);

/// Provider untuk get siswa by ID
final siswaByIdProvider = FutureProvider.family<SiswaEntity?, String>(
  (ref, siswaId) async {
    final repository = ref.read(siswaRepositoryProvider);
    return await repository.getSiswaById(siswaId);
  },
);
