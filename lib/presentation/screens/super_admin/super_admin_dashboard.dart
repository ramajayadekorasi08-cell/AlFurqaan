import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/auth_provider.dart';
import '../auth/login_screen.dart';
import 'add_wali_kelas_screen.dart';

class SuperAdminDashboard extends ConsumerWidget {
  const SuperAdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Kepala Sekolah'),
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
                        Icons.person,
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
                            user?.roleDisplay ?? '',
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

            // Menu Cards
            Text(
              'Menu Utama',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildMenuCard(
                  context,
                  icon: Icons.people,
                  title: 'Tambah Wali Kelas',
                  subtitle: 'Buat akun wali kelas baru',
                  color: AppTheme.primaryColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddWaliKelasScreen(),
                      ),
                    );
                  },
                ),
                _buildMenuCard(
                  context,
                  icon: Icons.assessment,
                  title: 'Status Input Nilai',
                  subtitle: 'Monitor progress nilai',
                  color: AppTheme.accentColor,
                  onTap: () {
                    // TODO: Navigate to status input nilai
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fitur dalam pengembangan')),
                    );
                  },
                ),
                _buildMenuCard(
                  context,
                  icon: Icons.message,
                  title: 'Kirim Pesan',
                  subtitle: 'Ke wali kelas',
                  color: AppTheme.secondaryColor,
                  onTap: () {
                    // TODO: Navigate to send message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fitur dalam pengembangan')),
                    );
                  },
                ),
                _buildMenuCard(
                  context,
                  icon: Icons.bar_chart,
                  title: 'Statistik',
                  subtitle: 'Lihat statistik nilai',
                  color: AppTheme.successColor,
                  onTap: () {
                    // TODO: Navigate to statistics
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fitur dalam pengembangan')),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 32,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
