import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/pdf_generator.dart';
import '../../../domain/entities/siswa_entity.dart';
import '../../providers/nilai_provider.dart';
import '../../providers/mata_pelajaran_provider.dart';
import '../../providers/auth_provider.dart';
import '../../../domain/entities/nilai_entity.dart';

class RekapNilaiScreen extends ConsumerWidget {
  final SiswaEntity siswa;

  const RekapNilaiScreen({super.key, required this.siswa});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nilaiAsync = ref.watch(nilaiBySiswaProvider(siswa.id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rekap Nilai Siswa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Info Siswa
            Card(
              color: AppTheme.primaryColor.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      siswa.nama,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text('NIS: ${siswa.nis}'),
                    Text('Kelas: ${siswa.namaKelas}'),
                    Text('Semester: ${siswa.semester} ${siswa.tahunAjaran}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Tabel Nilai
            Text(
              'Daftar Nilai',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            nilaiAsync.when(
              data: (nilaiList) {
                if (nilaiList.isEmpty) {
                  return const Card(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(
                        child: Text('Belum ada nilai yang diinput'),
                      ),
                    ),
                  );
                }

                // Hitung rata-rata
                final rataRata = nilaiList.isEmpty
                    ? 0.0
                    : nilaiList.map((n) => n.nilaiAkhir).reduce((a, b) => a + b) /
                        nilaiList.length;

                return Column(
                  children: [
                    // Tabel
                    Card(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Mata Pelajaran')),
                            DataColumn(label: Text('Tugas')),
                            DataColumn(label: Text('UTS')),
                            DataColumn(label: Text('UAS')),
                            DataColumn(label: Text('Nilai Akhir')),
                            DataColumn(label: Text('Grade')),
                          ],
                          rows: nilaiList.map((nilai) {
                            return DataRow(
                              cells: [
                                DataCell(Text(nilai.namaMapel)),
                                DataCell(Text(nilai.nilaiTugas.toStringAsFixed(0))),
                                DataCell(Text(nilai.nilaiUTS.toStringAsFixed(0))),
                                DataCell(Text(nilai.nilaiUAS.toStringAsFixed(0))),
                                DataCell(
                                  Text(
                                    nilai.nilaiAkhir.toStringAsFixed(2),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getGradeColor(nilai.grade),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      nilai.grade,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Rata-rata
                    Card(
                      color: AppTheme.successColor.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rata-rata Nilai',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              rataRata.toStringAsFixed(2),
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    color: AppTheme.successColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Tombol Aksi PDF
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _handlePdfAction(context, ref, nilaiList, rataRata, isPrint: true),
                            icon: const Icon(Icons.print),
                            label: const Text('Cetak / Print'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _handlePdfAction(context, ref, nilaiList, rataRata, isPrint: false),
                            icon: const Icon(Icons.download),
                            label: const Text('Download PDF'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.errorColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A':
        return AppTheme.successColor;
      case 'B':
        return AppTheme.accentColor;
      case 'C':
        return AppTheme.secondaryColor;
      case 'D':
        return AppTheme.warningColor;
      default:
        return AppTheme.errorColor;
    }
  }

  Future<void> _handlePdfAction(
    BuildContext context,
    WidgetRef ref,
    List<NilaiEntity> nilaiList,
    double rataRata, {
    required bool isPrint,
  }) async {
    try {
      // Show loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Get current user (Wali Kelas)
      final currentUser = ref.read(currentUserProvider);

      if (isPrint) {
        await PDFGenerator.printPDF(
          siswa: siswa,
          nilaiList: nilaiList,
          rataRata: rataRata,
          waliKelasName: currentUser?.nama,
          waliKelasNip: currentUser?.nip,
          kepsekName: 'Nama Kepala Sekolah, M.Pd', 
          kepsekNip: '19700101 200003 1 001',
        );
      } else {
        await PDFGenerator.downloadPDF(
          siswa: siswa,
          nilaiList: nilaiList,
          rataRata: rataRata,
          waliKelasName: currentUser?.nama,
          waliKelasNip: currentUser?.nip,
          kepsekName: 'Nama Kepala Sekolah, M.Pd', 
          kepsekNip: '19700101 200003 1 001',
        );
      }

      // Close loading
      if (context.mounted) {
        Navigator.pop(context);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isPrint ? 'Menyiapkan pratinjau cetak...' : 'PDF berhasil diproses'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      }
    } catch (e) {
      // Close loading
      if (context.mounted) {
        Navigator.pop(context);

        // Show error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }
}
