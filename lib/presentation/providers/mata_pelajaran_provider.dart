import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/mata_pelajaran_entity.dart';
import 'repository_providers.dart';

/// Provider untuk get all mata pelajaran
final allMataPelajaranProvider = FutureProvider<List<MataPelajaranEntity>>((ref) async {
  final repository = ref.read(mataPelajaranRepositoryProvider);
  return await repository.getAllMataPelajaran();
});

/// Provider untuk get mata pelajaran by ID
final mataPelajaranByIdProvider = FutureProvider.family<MataPelajaranEntity?, String>(
  (ref, mapelId) async {
    final repository = ref.read(mataPelajaranRepositoryProvider);
    return await repository.getMataPelajaranById(mapelId);
  },
);
