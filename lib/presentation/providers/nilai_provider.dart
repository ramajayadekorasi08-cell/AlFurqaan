import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/nilai_entity.dart';
import '../../data/models/nilai_model.dart';
import 'repository_providers.dart';

/// Provider untuk get all nilai
final allNilaiProvider = FutureProvider<List<NilaiEntity>>((ref) async {
  final repository = ref.read(nilaiRepositoryProvider);
  return await repository.getAllNilai();
});

/// Provider untuk get nilai by siswa
final nilaiBySiswaProvider = FutureProvider.family<List<NilaiEntity>, String>(
  (ref, siswaId) async {
    final repository = ref.read(nilaiRepositoryProvider);
    return await repository.getNilaiBySiswa(siswaId);
  },
);

/// Provider untuk get nilai by guru
final nilaiByGuruProvider = FutureProvider.family<List<NilaiEntity>, String>(
  (ref, guruId) async {
    final repository = ref.read(nilaiRepositoryProvider);
    return await repository.getNilaiByGuru(guruId);
  },
);

/// State untuk Input Nilai
class InputNilaiState {
  final double? nilaiTugas;
  final double? nilaiUTS;
  final double? nilaiUAS;
  final double? nilaiAkhir;
  final bool isLoading;
  final String? errorMessage;
  final bool isSaved;

  InputNilaiState({
    this.nilaiTugas,
    this.nilaiUTS,
    this.nilaiUAS,
    this.nilaiAkhir,
    this.isLoading = false,
    this.errorMessage,
    this.isSaved = false,
  });

  InputNilaiState copyWith({
    double? nilaiTugas,
    double? nilaiUTS,
    double? nilaiUAS,
    double? nilaiAkhir,
    bool? isLoading,
    String? errorMessage,
    bool? isSaved,
  }) {
    return InputNilaiState(
      nilaiTugas: nilaiTugas ?? this.nilaiTugas,
      nilaiUTS: nilaiUTS ?? this.nilaiUTS,
      nilaiUAS: nilaiUAS ?? this.nilaiUAS,
      nilaiAkhir: nilaiAkhir ?? this.nilaiAkhir,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  bool get isValid =>
      nilaiTugas != null &&
      nilaiUTS != null &&
      nilaiUAS != null &&
      nilaiTugas! >= 0 &&
      nilaiTugas! <= 100 &&
      nilaiUTS! >= 0 &&
      nilaiUTS! <= 100 &&
      nilaiUAS! >= 0 &&
      nilaiUAS! <= 100;
}

/// Notifier untuk Input Nilai
class InputNilaiNotifier extends StateNotifier<InputNilaiState> {
  final Ref ref;

  InputNilaiNotifier(this.ref) : super(InputNilaiState());

  /// Set nilai tugas dan hitung nilai akhir
  void setNilaiTugas(double nilai) {
    state = state.copyWith(nilaiTugas: nilai, isSaved: false);
    _hitungNilaiAkhir();
  }

  /// Set nilai UTS dan hitung nilai akhir
  void setNilaiUTS(double nilai) {
    state = state.copyWith(nilaiUTS: nilai, isSaved: false);
    _hitungNilaiAkhir();
  }

  /// Set nilai UAS dan hitung nilai akhir
  void setNilaiUAS(double nilai) {
    state = state.copyWith(nilaiUAS: nilai, isSaved: false);
    _hitungNilaiAkhir();
  }

  /// Hitung nilai akhir otomatis
  void _hitungNilaiAkhir() {
    if (state.nilaiTugas != null &&
        state.nilaiUTS != null &&
        state.nilaiUAS != null) {
      final nilaiAkhir = NilaiEntity.hitungNilaiAkhir(
        nilaiTugas: state.nilaiTugas!,
        nilaiUTS: state.nilaiUTS!,
        nilaiUAS: state.nilaiUAS!,
      );
      state = state.copyWith(nilaiAkhir: nilaiAkhir);
    }
  }

  /// Save nilai
  Future<bool> saveNilai({
    required String siswaId,
    required String namaSiswa,
    required String mapelId,
    required String namaMapel,
    required String guruId,
    required String namaGuru,
    required String tahunAjaran,
    required String semester,
  }) async {
    if (!state.isValid) {
      state = state.copyWith(
        errorMessage: 'Mohon isi semua nilai dengan benar (0-100)',
      );
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(nilaiRepositoryProvider);

      final nilai = NilaiModel.create(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        siswaId: siswaId,
        namaSiswa: namaSiswa,
        mapelId: mapelId,
        namaMapel: namaMapel,
        guruId: guruId,
        namaGuru: namaGuru,
        nilaiTugas: state.nilaiTugas!,
        nilaiUTS: state.nilaiUTS!,
        nilaiUAS: state.nilaiUAS!,
        tahunAjaran: tahunAjaran,
        semester: semester,
      );

      await repository.saveNilai(nilai.toEntity());

      state = state.copyWith(isLoading: false, isSaved: true);
      
      // Refresh nilai providers
      ref.invalidate(allNilaiProvider);
      ref.invalidate(nilaiBySiswaProvider);
      ref.invalidate(nilaiByGuruProvider);
      
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Gagal menyimpan nilai: ${e.toString()}',
      );
      return false;
    }
  }

  /// Load nilai yang sudah ada
  Future<void> loadNilai(String mapelId, String siswaId) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(nilaiRepositoryProvider);
      final nilai = await repository.getNilaiByMapelSiswa(mapelId, siswaId);

      if (nilai != null) {
        state = InputNilaiState(
          nilaiTugas: nilai.nilaiTugas,
          nilaiUTS: nilai.nilaiUTS,
          nilaiUAS: nilai.nilaiUAS,
          nilaiAkhir: nilai.nilaiAkhir,
          isLoading: false,
        );
      } else {
        state = InputNilaiState(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Gagal memuat nilai: ${e.toString()}',
      );
    }
  }

  /// Reset state
  void reset() {
    state = InputNilaiState();
  }
}

/// Provider untuk InputNilaiNotifier
final inputNilaiProvider = StateNotifierProvider<InputNilaiNotifier, InputNilaiState>((ref) {
  return InputNilaiNotifier(ref);
});
