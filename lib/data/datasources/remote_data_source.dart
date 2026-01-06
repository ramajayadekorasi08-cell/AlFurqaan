import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/constants.dart';
import '../models/user_model.dart';
import '../models/siswa_model.dart';
import '../models/nilai_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/nilai_entity.dart';
import '../../domain/entities/siswa_entity.dart';

class RemoteDataSource {
  final http.Client client;

  String? _token;

  RemoteDataSource({http.Client? client}) : client = client ?? http.Client();

  Map<String, String> get headers => {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    if (_token != null) 'Authorization': 'Bearer $_token',
  };

  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse('${AppConstants.baseUrl}/login'),
        headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _token = data['access_token'];
        return UserModel.fromJson(data['user']);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  void logout() {
    _token = null;
  }

  /// Helper to handle error response
  void _handleError(http.Response response, String defaultMessage) {
    String? message;
    try {
      final data = json.decode(response.body);
      if (response.statusCode == 422) {
        // Validation errors
        if (data is Map && data.isNotEmpty) {
          final firstError = data.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            message = firstError.first.toString();
          } else if (firstError is String) {
            message = firstError;
          }
        }
      } else if (data is Map) {
        message = data['message']?.toString();
      }
    } catch (_) {
      // Not a JSON or other error
    }
    
    throw Exception(message ?? '$defaultMessage (${response.statusCode})');
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await client.get(
        Uri.parse('${AppConstants.baseUrl}/users'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((json) => UserModel.fromJson(json)).toList();
      } else {
        _handleError(response, 'Gagal memuat daftar user');
        return []; // Never reached
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Gagal memuat users: $e');
    }
  }

  Future<UserModel> createUser(
    String nama, 
    String email, 
    String password, 
    String role, {
    String? namaMapel,
    String? kelasId,
    String? namaKelas,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('${AppConstants.baseUrl}/register'),
        headers: headers,
        body: jsonEncode({
          'name': nama,
          'email': email,
          'password': password,
          'role': role,
          'nama_mapel': namaMapel ?? '',
          'kelas_id': kelasId ?? '',
          'nama_kelas': namaKelas ?? '',
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return UserModel.fromJson(data['user']);
      } else {
        _handleError(response, 'Gagal membuat user');
        throw Exception(); // Never reached
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Error koneksi: $e');
    }
  }

  // ==================== SISWA ====================

  Future<List<SiswaModel>> getAllSiswa() async {
    try {
      final response = await client.get(
        Uri.parse('${AppConstants.baseUrl}/siswas'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((json) => SiswaModel.fromJson(json)).toList();
      } else {
        _handleError(response, 'Gagal memuat semua siswa');
        return []; // Never reached
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Error memuat semua siswa: $e');
    }
  }

  Future<List<SiswaModel>> getSiswasByKelas(String kelasId) async {
    try {
      final response = await client.get(
        Uri.parse('${AppConstants.baseUrl}/siswas?kelas_id=$kelasId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((json) => SiswaModel.fromJson(json)).toList();
      } else {
        _handleError(response, 'Gagal memuat daftar siswa');
        return []; // Never reached
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Error memuat siswa: $e');
    }
  }

  Future<SiswaModel> createSiswa(SiswaModel siswa) async {
    try {
      final response = await client.post(
        Uri.parse('${AppConstants.baseUrl}/siswas'),
        headers: headers,
        body: jsonEncode(siswa.toJson()),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return SiswaModel.fromJson(data['siswa']);
      } else {
        _handleError(response, 'Gagal menambah siswa');
        throw Exception(); // Never reached
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Error menambah siswa: $e');
    }
  }

  // ==================== NILAI ====================

  Future<List<NilaiModel>> getNilaiBySiswa(String siswaId) async {
    try {
      final response = await client.get(
        Uri.parse('${AppConstants.baseUrl}/nilais?siswa_id=$siswaId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((json) => NilaiModel.fromJson(json)).toList();
      } else {
        _handleError(response, 'Gagal memuat nilai siswa');
        return []; // Never reached
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Error memuat nilai: $e');
    }
  }

  Future<NilaiModel> saveNilai(NilaiModel nilai) async {
    try {
      final response = await client.post(
        Uri.parse('${AppConstants.baseUrl}/nilais'),
        headers: headers,
        body: jsonEncode(nilai.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return NilaiModel.fromJson(data['nilai']);
      } else {
        _handleError(response, 'Gagal menyimpan nilai');
        throw Exception(); // Never reached
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Error menyimpan nilai: $e');
    }
  }

  Future<NilaiModel?> getNilaiByMapelSiswa(String mapelId, String siswaId) async {
    try {
      final response = await client.get(
        Uri.parse('${AppConstants.baseUrl}/nilais/detail?mapel_id=$mapelId&siswa_id=$siswaId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data == null) return null;
        return NilaiModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
