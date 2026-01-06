import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/repositories/siswa_repository_impl.dart';
import '../../data/repositories/nilai_repository_impl.dart';
import '../../data/repositories/mata_pelajaran_repository_impl.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/repositories/siswa_repository.dart';
import '../../domain/repositories/nilai_repository.dart';
import '../../domain/repositories/mata_pelajaran_repository.dart';

import '../../data/datasources/remote_data_source.dart';

/// Provider untuk RemoteDataSource
final remoteDataSourceProvider = Provider<RemoteDataSource>((ref) {
  return RemoteDataSource();
});

/// Provider untuk UserRepository
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final remoteDataSource = ref.watch(remoteDataSourceProvider);
  return UserRepositoryImpl(remoteDataSource: remoteDataSource);
});

/// Provider untuk SiswaRepository
final siswaRepositoryProvider = Provider<SiswaRepository>((ref) {
  final remoteDataSource = ref.watch(remoteDataSourceProvider);
  return SiswaRepositoryImpl(remoteDataSource: remoteDataSource);
});

/// Provider untuk NilaiRepository
final nilaiRepositoryProvider = Provider<NilaiRepository>((ref) {
  final remoteDataSource = ref.watch(remoteDataSourceProvider);
  return NilaiRepositoryImpl(remoteDataSource: remoteDataSource);
});

/// Provider untuk MataPelajaranRepository
final mataPelajaranRepositoryProvider = Provider<MataPelajaranRepository>((ref) {
  return MataPelajaranRepositoryImpl();
});
