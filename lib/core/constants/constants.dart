// Constants untuk aplikasi Nilai Siswa MA Al-Furqaan

class AppConstants {
  // Role definitions
  static const String roleSuperAdmin = 'super_admin';
  static const String roleAdmin = 'admin';
  static const String roleUser = 'user';
  
  // Role display names
  static const String roleSuperAdminDisplay = 'Kepala Sekolah';
  static const String roleAdminDisplay = 'Guru Mapel';
  static const String roleUserDisplay = 'Guru Wali Kelas';
  
  // School information
  static const String schoolName = 'MA Al-Furqaan';
  static const String schoolAddress = 'Campaka Pasongsongan';
  static const String schoolPhone = '(0328) xxx-xxxx';
  
  // API Configuration (MockAPI)
  static const String baseUrl = 'http://localhost:8000/api'; // Local Laravel Backend
  // Ganti dengan endpoint MockAPI Anda nanti
  
  // Perhitungan Nilai
  static const double bobotTugas = 0.30; // 30%
  static const double bobotUTS = 0.30;   // 30%
  static const double bobotUAS = 0.40;   // 40%
  
  // Validation
  static const double minNilai = 0.0;
  static const double maxNilai = 100.0;
  
  // Semester
  static const List<String> semesterList = ['Ganjil', 'Genap'];
  
  // Tahun Ajaran (contoh)
  static const List<String> tahunAjaranList = [
    '2025/2026',
    '2024/2025',
    '2023/2024',
  ];
}
