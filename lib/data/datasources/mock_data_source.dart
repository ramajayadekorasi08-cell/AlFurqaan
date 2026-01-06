import '../models/user_model.dart';
import '../models/siswa_model.dart';
import '../models/mata_pelajaran_model.dart';
import '../models/nilai_model.dart';

/// Mock Data Source untuk demonstrasi aplikasi
/// Nanti bisa diganti dengan API real (MockAPI/Firebase)
class MockDataSource {
  // Storage untuk data (simulasi database)
  static final List<UserModel> _users = _initUsers();
  static final List<SiswaModel> _siswa = _initSiswa();
  static final List<MataPelajaranModel> _mataPelajaran = _initMataPelajaran();
  static final List<NilaiModel> _nilai = [];

  // ==================== USERS ====================
  
  static List<UserModel> _initUsers() {
    return [
      // Super Admin - Kepala Sekolah
      const UserModel(
        id: '1',
        nama: 'Drs. H. Ahmad Fauzi, M.Pd',
        email: 'kepala@alfurqaan.sch.id',
        password: 'admin123',
        role: 'super_admin',
        nip: '196505101990031001',
      ),
      
      // Admin - Guru Mapel Matematika
      const UserModel(
        id: '2',
        nama: 'Siti Nurhaliza, S.Pd',
        email: 'siti@alfurqaan.sch.id',
        password: 'guru123',
        role: 'admin',
        mapelId: '1',
        namaMapel: 'Matematika',
        nip: '198203152006042001',
      ),
      
      // Admin - Guru Mapel Bahasa Indonesia
      const UserModel(
        id: '3',
        nama: 'Ahmad Hidayat, S.Pd',
        email: 'ahmad@alfurqaan.sch.id',
        password: 'guru123',
        role: 'admin',
        mapelId: '2',
        namaMapel: 'Bahasa Indonesia',
        nip: '198505202008011002',
      ),
      
      // Admin - Guru Mapel Bahasa Inggris
      const UserModel(
        id: '4',
        nama: 'Dewi Sartika, S.Pd',
        email: 'dewi@alfurqaan.sch.id',
        password: 'guru123',
        role: 'admin',
        mapelId: '3',
        namaMapel: 'Bahasa Inggris',
        nip: '198708122010012003',
      ),
      
      // User - Wali Kelas X IPA 1
      const UserModel(
        id: '5',
        nama: 'Budi Santoso, S.Pd',
        email: 'budi@alfurqaan.sch.id',
        password: 'wali123',
        role: 'user',
        kelasId: '1',
        namaKelas: 'X IPA 1',
        nip: '198912052012011001',
      ),
      
      // User - Wali Kelas X IPA 2
      const UserModel(
        id: '6',
        nama: 'Rina Wati, S.Pd',
        email: 'rina@alfurqaan.sch.id',
        password: 'wali123',
        role: 'user',
        kelasId: '2',
        namaKelas: 'X IPA 2',
        nip: '199001152013012002',
      ),
    ];
  }

  static Future<List<UserModel>> getAllUsers() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _users;
  }

  static Future<UserModel?> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    try {
      return _users.firstWhere(
        (user) => user.email == email && user.password == password,
      );
    } catch (e) {
      return null;
    }
  }

  static Future<List<UserModel>> getUsersByRole(String role) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _users.where((user) => user.role == role).toList();
  }

  // ==================== SISWA ====================
  
  static List<SiswaModel> _initSiswa() {
    return [
      // Kelas X IPA 1
      const SiswaModel(
        id: '1',
        nis: '2025001',
        nama: 'Muhammad Rizki',
        kelasId: '1',
        namaKelas: 'X IPA 1',
        tahunAjaran: '2025/2026',
        semester: 'Ganjil',
        alamat: 'Pasongsongan',
      ),
      const SiswaModel(
        id: '2',
        nis: '2025002',
        nama: 'Fatimah Azzahra',
        kelasId: '1',
        namaKelas: 'X IPA 1',
        tahunAjaran: '2025/2026',
        semester: 'Ganjil',
        alamat: 'Campaka',
      ),
      const SiswaModel(
        id: '3',
        nis: '2025003',
        nama: 'Ahmad Firdaus',
        kelasId: '1',
        namaKelas: 'X IPA 1',
        tahunAjaran: '2025/2026',
        semester: 'Ganjil',
        alamat: 'Pasongsongan',
      ),
      const SiswaModel(
        id: '4',
        nis: '2025004',
        nama: 'Siti Aisyah',
        kelasId: '1',
        namaKelas: 'X IPA 1',
        tahunAjaran: '2025/2026',
        semester: 'Ganjil',
        alamat: 'Campaka',
      ),
      const SiswaModel(
        id: '5',
        nis: '2025005',
        nama: 'Abdullah Aziz',
        kelasId: '1',
        namaKelas: 'X IPA 1',
        tahunAjaran: '2025/2026',
        semester: 'Ganjil',
        alamat: 'Pasongsongan',
      ),
      
      // Kelas X IPA 2
      const SiswaModel(
        id: '6',
        nis: '2025006',
        nama: 'Nur Hidayah',
        kelasId: '2',
        namaKelas: 'X IPA 2',
        tahunAjaran: '2025/2026',
        semester: 'Ganjil',
        alamat: 'Campaka',
      ),
      const SiswaModel(
        id: '7',
        nis: '2025007',
        nama: 'Umar Faruq',
        kelasId: '2',
        namaKelas: 'X IPA 2',
        tahunAjaran: '2025/2026',
        semester: 'Ganjil',
        alamat: 'Pasongsongan',
      ),
      const SiswaModel(
        id: '8',
        nis: '2025008',
        nama: 'Khadijah',
        kelasId: '2',
        namaKelas: 'X IPA 2',
        tahunAjaran: '2025/2026',
        semester: 'Ganjil',
        alamat: 'Campaka',
      ),
      const SiswaModel(
        id: '9',
        nis: '2025009',
        nama: 'Yusuf Ibrahim',
        kelasId: '2',
        namaKelas: 'X IPA 2',
        tahunAjaran: '2025/2026',
        semester: 'Ganjil',
        alamat: 'Pasongsongan',
      ),
      const SiswaModel(
        id: '10',
        nis: '2025010',
        nama: 'Maryam Zahra',
        kelasId: '2',
        namaKelas: 'X IPA 2',
        tahunAjaran: '2025/2026',
        semester: 'Ganjil',
        alamat: 'Campaka',
      ),
    ];
  }

  static Future<List<SiswaModel>> getAllSiswa() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _siswa;
  }

  static Future<List<SiswaModel>> getSiswaByKelas(String kelasId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _siswa.where((s) => s.kelasId == kelasId).toList();
  }

  static Future<SiswaModel?> getSiswaById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _siswa.firstWhere((s) => s.id == id);
    } catch (e) {
      return null;
    }
  }

  // ==================== MATA PELAJARAN ====================
  
  static List<MataPelajaranModel> _initMataPelajaran() {
    return const [
      MataPelajaranModel(id: '1', kode: 'MTK', nama: 'Matematika', kkm: 75),
      MataPelajaranModel(id: '2', kode: 'BIND', nama: 'Bahasa Indonesia', kkm: 75),
      MataPelajaranModel(id: '3', kode: 'BING', nama: 'Bahasa Inggris', kkm: 75),
      MataPelajaranModel(id: '4', kode: 'FIS', nama: 'Fisika', kkm: 75),
      MataPelajaranModel(id: '5', kode: 'KIM', nama: 'Kimia', kkm: 75),
      MataPelajaranModel(id: '6', kode: 'BIO', nama: 'Biologi', kkm: 75),
      MataPelajaranModel(id: '7', kode: 'SEJ', nama: 'Sejarah', kkm: 75),
      MataPelajaranModel(id: '8', kode: 'GEO', nama: 'Geografi', kkm: 75),
      MataPelajaranModel(id: '9', kode: 'EKO', nama: 'Ekonomi', kkm: 75),
      MataPelajaranModel(id: '10', kode: 'PAI', nama: 'Pendidikan Agama Islam', kkm: 75),
    ];
  }

  static Future<List<MataPelajaranModel>> getAllMataPelajaran() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mataPelajaran;
  }

  static Future<MataPelajaranModel?> getMataPelajaranById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _mataPelajaran.firstWhere((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }

  // ==================== NILAI ====================
  
  static Future<List<NilaiModel>> getAllNilai() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _nilai;
  }

  static Future<List<NilaiModel>> getNilaiBySiswa(String siswaId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _nilai.where((n) => n.siswaId == siswaId).toList();
  }

  static Future<List<NilaiModel>> getNilaiByGuru(String guruId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _nilai.where((n) => n.guruId == guruId).toList();
  }

  static Future<NilaiModel?> getNilaiByMapelSiswa(
    String mapelId,
    String siswaId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _nilai.firstWhere(
        (n) => n.mapelId == mapelId && n.siswaId == siswaId,
      );
    } catch (e) {
      return null;
    }
  }

  static Future<NilaiModel> saveNilai(NilaiModel nilai) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Cek apakah sudah ada nilai untuk mapel dan siswa ini
    final existingIndex = _nilai.indexWhere(
      (n) => n.mapelId == nilai.mapelId && n.siswaId == nilai.siswaId,
    );

    if (existingIndex != -1) {
      // Update nilai yang sudah ada
      _nilai[existingIndex] = nilai.copyWith(updatedAt: DateTime.now());
      return _nilai[existingIndex];
    } else {
      // Tambah nilai baru
      final newNilai = nilai.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      _nilai.add(newNilai);
      return newNilai;
    }
  }

  static Future<bool> deleteNilai(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _nilai.indexWhere((n) => n.id == id);
    if (index != -1) {
      _nilai.removeAt(index);
      return true;
    }
    return false;
  }

  // ==================== HELPER METHODS ====================
  
  /// Get status input nilai per wali kelas
  static Future<Map<String, dynamic>> getStatusInputNilai(String kelasId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final siswaKelas = _siswa.where((s) => s.kelasId == kelasId).toList();
    final totalSiswa = siswaKelas.length;
    final totalMapel = _mataPelajaran.length;
    final targetTotal = totalSiswa * totalMapel;
    
    int nilaiTerisi = 0;
    for (var siswa in siswaKelas) {
      final nilaiSiswa = _nilai.where((n) => n.siswaId == siswa.id).toList();
      nilaiTerisi += nilaiSiswa.length;
    }
    
    final persentase = targetTotal > 0 ? (nilaiTerisi / targetTotal * 100) : 0.0;
    
    return {
      'kelasId': kelasId,
      'totalSiswa': totalSiswa,
      'totalMapel': totalMapel,
      'targetTotal': targetTotal,
      'nilaiTerisi': nilaiTerisi,
      'persentase': persentase,
      'status': persentase >= 100 ? 'Lengkap' : 'Belum Lengkap',
    };
  }
}
