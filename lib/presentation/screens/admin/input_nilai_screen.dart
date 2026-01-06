import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/siswa_entity.dart';
import '../../providers/nilai_provider.dart';

class InputNilaiScreen extends ConsumerStatefulWidget {
  final SiswaEntity siswa;
  final String mapelId;
  final String namaMapel;
  final String guruId;
  final String namaGuru;

  const InputNilaiScreen({
    super.key,
    required this.siswa,
    required this.mapelId,
    required this.namaMapel,
    required this.guruId,
    required this.namaGuru,
  });

  @override
  ConsumerState<InputNilaiScreen> createState() => _InputNilaiScreenState();
}

class _InputNilaiScreenState extends ConsumerState<InputNilaiScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tugasController = TextEditingController();
  final _utsController = TextEditingController();
  final _uasController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load nilai yang sudah ada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(inputNilaiProvider.notifier).loadNilai(
            widget.mapelId,
            widget.siswa.id,
          );
    });
  }

  @override
  void dispose() {
    _tugasController.dispose();
    _utsController.dispose();
    _uasController.dispose();
    super.dispose();
  }

  void _handleSave() async {
    if (_formKey.currentState!.validate()) {
      final success = await ref.read(inputNilaiProvider.notifier).saveNilai(
            siswaId: widget.siswa.id,
            namaSiswa: widget.siswa.nama,
            mapelId: widget.mapelId,
            namaMapel: widget.namaMapel,
            guruId: widget.guruId,
            namaGuru: widget.namaGuru,
            tahunAjaran: widget.siswa.tahunAjaran,
            semester: widget.siswa.semester,
          );

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nilai berhasil disimpan'),
            backgroundColor: AppTheme.successColor,
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputState = ref.watch(inputNilaiProvider);

    // Update controllers when nilai loaded
    ref.listen(inputNilaiProvider, (previous, next) {
      if (next.nilaiTugas != null && _tugasController.text.isEmpty) {
        _tugasController.text = next.nilaiTugas.toString();
      }
      if (next.nilaiUTS != null && _utsController.text.isEmpty) {
        _utsController.text = next.nilaiUTS.toString();
      }
      if (next.nilaiUAS != null && _uasController.text.isEmpty) {
        _uasController.text = next.nilaiUAS.toString();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Nilai'),
      ),
      body: inputState.isLoading && inputState.nilaiTugas == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
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
                              widget.siswa.nama,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text('NIS: ${widget.siswa.nis}'),
                            Text('Kelas: ${widget.siswa.namaKelas}'),
                            Text('Mata Pelajaran: ${widget.namaMapel}'),
                            Text('Semester: ${widget.siswa.semester} ${widget.siswa.tahunAjaran}'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Input Nilai Tugas
                    TextFormField(
                      controller: _tugasController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Nilai Tugas',
                        hintText: '0-100',
                        prefixIcon: Icon(Icons.assignment),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nilai tugas tidak boleh kosong';
                        }
                        final nilai = double.tryParse(value);
                        if (nilai == null || nilai < 0 || nilai > 100) {
                          return 'Nilai harus antara 0-100';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        final nilai = double.tryParse(value);
                        if (nilai != null) {
                          ref.read(inputNilaiProvider.notifier).setNilaiTugas(nilai);
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Input Nilai UTS
                    TextFormField(
                      controller: _utsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Nilai UTS',
                        hintText: '0-100',
                        prefixIcon: Icon(Icons.quiz),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nilai UTS tidak boleh kosong';
                        }
                        final nilai = double.tryParse(value);
                        if (nilai == null || nilai < 0 || nilai > 100) {
                          return 'Nilai harus antara 0-100';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        final nilai = double.tryParse(value);
                        if (nilai != null) {
                          ref.read(inputNilaiProvider.notifier).setNilaiUTS(nilai);
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Input Nilai UAS
                    TextFormField(
                      controller: _uasController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Nilai UAS',
                        hintText: '0-100',
                        prefixIcon: Icon(Icons.school),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nilai UAS tidak boleh kosong';
                        }
                        final nilai = double.tryParse(value);
                        if (nilai == null || nilai < 0 || nilai > 100) {
                          return 'Nilai harus antara 0-100';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        final nilai = double.tryParse(value);
                        if (nilai != null) {
                          ref.read(inputNilaiProvider.notifier).setNilaiUAS(nilai);
                        }
                      },
                    ),
                    const SizedBox(height: 24),

                    // Nilai Akhir (Auto Calculate)
                    if (inputState.nilaiAkhir != null)
                      Card(
                        color: AppTheme.successColor.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                'Nilai Akhir (Otomatis)',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                inputState.nilaiAkhir!.toStringAsFixed(2),
                                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                      color: AppTheme.successColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tugas (30%) + UTS (30%) + UAS (40%)',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),

                    // Error Message
                    if (inputState.errorMessage != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: AppTheme.errorColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppTheme.errorColor),
                        ),
                        child: Text(
                          inputState.errorMessage!,
                          style: const TextStyle(color: AppTheme.errorColor),
                        ),
                      ),

                    // Save Button
                    ElevatedButton(
                      onPressed: inputState.isLoading ? null : _handleSave,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: inputState.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text('Simpan Nilai'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
