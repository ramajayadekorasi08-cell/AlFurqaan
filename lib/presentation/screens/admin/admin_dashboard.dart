import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/auth_provider.dart';
import '../../providers/siswa_provider.dart';
import '../auth/login_screen.dart';
import 'input_nilai_screen.dart';

class AdminDashboard extends ConsumerStatefulWidget {
  const AdminDashboard({super.key});

  @override
  ConsumerState<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends ConsumerState<AdminDashboard> {
  String? selectedKelasId;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final allSiswaAsync = ref.watch(allSiswaProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Guru Mapel'),
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
                        Icons.school,
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
                            user?.nama ?? '',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            'Mata Pelajaran: ${user?.namaMapel ?? ''}',
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

            // Pilih Kelas
            Text(
              'Pilih Kelas',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            allSiswaAsync.when(
              data: (siswaList) {
                // Group siswa by kelas
                final kelasList = siswaList
                    .map((s) => {'id': s.kelasId, 'nama': s.namaKelas})
                    .toSet()
                    .toList();

                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: kelasList.map((kelas) {
                    final isSelected = selectedKelasId == kelas['id'];
                    return ChoiceChip(
                      label: Text(kelas['nama'] as String),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedKelasId = selected ? kelas['id'] as String : null;
                        });
                      },
                      selectedColor: AppTheme.primaryColor,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppTheme.textPrimary,
                      ),
                    );
                  }).toList(),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text('Error: $error'),
            ),
            const SizedBox(height: 24),

            // Daftar Siswa
            if (selectedKelasId != null) ...[
              Text(
                'Daftar Siswa',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              Consumer(
                builder: (context, ref, child) {
                  final siswaByKelasAsync = ref.watch(
                    siswaByKelasProvider(selectedKelasId!),
                  );

                  return siswaByKelasAsync.when(
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
                              trailing: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => InputNilaiScreen(
                                        siswa: siswa,
                                        mapelId: user!.mapelId!,
                                        namaMapel: user.namaMapel!,
                                        guruId: user.id,
                                        namaGuru: user.nama,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit, size: 18),
                                label: const Text('Input Nilai'),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Text('Error: $error'),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
