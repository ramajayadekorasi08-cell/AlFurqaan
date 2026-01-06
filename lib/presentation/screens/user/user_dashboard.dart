import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/auth_provider.dart';
import '../../providers/siswa_provider.dart';
import '../auth/login_screen.dart';
import 'rekap_nilai_screen.dart';
import 'add_teacher_screen.dart';
import 'add_siswa_screen.dart';

class UserDashboard extends ConsumerWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final siswaByKelasAsync = ref.watch(siswaByKelasProvider(user!.kelasId!));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Wali Kelas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.class_,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selamat Datang,',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            user.nama,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            'Wali Kelas ${user.namaKelas}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Manajemen Guru Mapel
            Card(
              color: Colors.blue.shade50,
              child: ListTile(
                leading: const Icon(Icons.person_add, color: Colors.blue),
                title: const Text('Manajemen Guru Mapel'),
                subtitle: const Text('Buat akun untuk Guru Mata Pelajaran'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddTeacherScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Manajemen Siswa
            Card(
              color: Colors.green.shade50,
              child: ListTile(
                leading: const Icon(Icons.person_add_alt_1, color: Colors.green),
                title: const Text('Manajemen Siswa'),
                subtitle: const Text('Tambah data siswa baru ke kelas ini'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddSiswaScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Daftar Siswa
            Text(
              'Daftar Siswa Kelas ${user.namaKelas}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            siswaByKelasAsync.when(
              data: (siswaList) {
                if (siswaList.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada siswa di kelas ini'),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: siswaList.length,
                  itemBuilder: (context, index) {
                    final siswa = siswaList[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppTheme.primaryColor,
                          child: Text(
                            siswa.nama[0].toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(siswa.nama),
                        subtitle: Text('NIS: ${siswa.nis}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RekapNilaiScreen(siswa: siswa),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.assessment, size: 18),
                              label: const Text('Rekap Nilai'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
}
