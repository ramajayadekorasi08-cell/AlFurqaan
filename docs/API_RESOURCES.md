# API Resources Documentation
## Sistem Nilai Siswa MA Al-Furqaan

Base URL: `https://your-api-domain.mockapi.io/api/v1`

---

## 📋 Table of Contents
- [Users API](#users-api)
- [Siswa API](#siswa-api)
- [Mata Pelajaran API](#mata-pelajaran-api)
- [Nilai API](#nilai-api)
- [Data Models](#data-models)

---

## 👤 Users API

### Login
```http
POST /auth/login
```

**Request Body:**
```json
{
  "email": "string",
  "password": "string"
}
```

**Response:**
```json
{
  "id": "1",
  "nama": "Drs. H. Ahmad Fauzi, M.Pd",
  "email": "kepala@alfurqaan.sch.id",
  "role": "super_admin",
  "nip": "196505101990031001",
  "mapelId": null,
  "namaMapel": null,
  "kelasId": null,
  "namaKelas": null
}
```

---

### Get All Users
```http
GET /users
```

**Response:**
```json
[
  {
    "id": "1",
    "nama": "Drs. H. Ahmad Fauzi, M.Pd",
    "email": "kepala@alfurqaan.sch.id",
    "role": "super_admin",
    "nip": "196505101990031001"
  }
]
```

---

### Get Users by Role
```http
GET /users?role={role}
```

**Parameters:**
| Parameter | Type   | Description                           |
|-----------|--------|---------------------------------------|
| role      | string | Filter by role (super_admin/admin/user) |

**Role Types:**
- `super_admin` - Kepala Sekolah
- `admin` - Guru Mata Pelajaran
- `user` - Wali Kelas

---

## 👨‍🎓 Siswa API

### Get All Siswa
```http
GET /siswa
```

**Response:**
```json
[
  {
    "id": "1",
    "nis": "2025001",
    "nama": "Muhammad Rizki",
    "kelasId": "1",
    "namaKelas": "X IPA 1",
    "tahunAjaran": "2025/2026",
    "semester": "Ganjil",
    "alamat": "Pasongsongan"
  }
]
```

---

### Get Siswa by Kelas
```http
GET /siswa?kelasId={kelasId}
```

**Parameters:**
| Parameter | Type   | Description       |
|-----------|--------|-------------------|
| kelasId   | string | Filter by kelas ID |

---

### Get Siswa by ID
```http
GET /siswa/{id}
```

**Parameters:**
| Parameter | Type   | Description |
|-----------|--------|-------------|
| id        | string | Siswa ID    |

---

## 📚 Mata Pelajaran API

### Get All Mata Pelajaran
```http
GET /mata-pelajaran
```

**Response:**
```json
[
  {
    "id": "1",
    "kode": "MTK",
    "nama": "Matematika",
    "kkm": 75
  },
  {
    "id": "2",
    "kode": "BIND",
    "nama": "Bahasa Indonesia",
    "kkm": 75
  }
]
```

---

### Get Mata Pelajaran by ID
```http
GET /mata-pelajaran/{id}
```

---

## 📊 Nilai API

### Get All Nilai
```http
GET /nilai
```

**Response:**
```json
[
  {
    "id": "1704067200000",
    "siswaId": "1",
    "namaSiswa": "Muhammad Rizki",
    "mapelId": "1",
    "namaMapel": "Matematika",
    "guruId": "2",
    "namaGuru": "Siti Nurhaliza, S.Pd",
    "nilaiTugas": 85.5,
    "nilaiUTS": 80.0,
    "nilaiUAS": 88.0,
    "nilaiAkhir": 84.85,
    "tahunAjaran": "2025/2026",
    "semester": "Ganjil",
    "createdAt": "2025-01-01T00:00:00.000Z",
    "updatedAt": "2025-01-01T00:00:00.000Z"
  }
]
```

---

### Get Nilai by Siswa
```http
GET /nilai?siswaId={siswaId}
```

**Parameters:**
| Parameter | Type   | Description       |
|-----------|--------|-------------------|
| siswaId   | string | Filter by siswa ID |

---

### Get Nilai by Guru
```http
GET /nilai?guruId={guruId}
```

**Parameters:**
| Parameter | Type   | Description      |
|-----------|--------|------------------|
| guruId    | string | Filter by guru ID |

---

### Get Nilai by Mapel dan Siswa
```http
GET /nilai?mapelId={mapelId}&siswaId={siswaId}
```

**Parameters:**
| Parameter | Type   | Description             |
|-----------|--------|-------------------------|
| mapelId   | string | Filter by mata pelajaran |
| siswaId   | string | Filter by siswa ID      |

---

### Create/Update Nilai
```http
POST /nilai
```

**Request Body:**
```json
{
  "siswaId": "1",
  "namaSiswa": "Muhammad Rizki",
  "mapelId": "1",
  "namaMapel": "Matematika",
  "guruId": "2",
  "namaGuru": "Siti Nurhaliza, S.Pd",
  "nilaiTugas": 85.5,
  "nilaiUTS": 80.0,
  "nilaiUAS": 88.0,
  "tahunAjaran": "2025/2026",
  "semester": "Ganjil"
}
```

> **Note:** `nilaiAkhir` dihitung otomatis dengan formula:
> `(nilaiTugas × 30%) + (nilaiUTS × 30%) + (nilaiUAS × 40%)`

**Response:**
```json
{
  "id": "1704067200000",
  "siswaId": "1",
  "namaSiswa": "Muhammad Rizki",
  "mapelId": "1",
  "namaMapel": "Matematika",
  "guruId": "2",
  "namaGuru": "Siti Nurhaliza, S.Pd",
  "nilaiTugas": 85.5,
  "nilaiUTS": 80.0,
  "nilaiUAS": 88.0,
  "nilaiAkhir": 84.85,
  "tahunAjaran": "2025/2026",
  "semester": "Ganjil",
  "createdAt": "2025-01-01T00:00:00.000Z",
  "updatedAt": "2025-01-01T00:00:00.000Z"
}
```

---

### Delete Nilai
```http
DELETE /nilai/{id}
```

**Response:**
```json
{
  "success": true
}
```

---

## 📦 Data Models

### UserModel
```json
{
  "id": "string",
  "nama": "string",
  "email": "string",
  "password": "string",
  "role": "super_admin | admin | user",
  "nip": "string",
  "mapelId": "string | null",
  "namaMapel": "string | null",
  "kelasId": "string | null",
  "namaKelas": "string | null"
}
```

### SiswaModel
```json
{
  "id": "string",
  "nis": "string",
  "nama": "string",
  "kelasId": "string",
  "namaKelas": "string",
  "tahunAjaran": "string",
  "semester": "string",
  "alamat": "string"
}
```

### MataPelajaranModel
```json
{
  "id": "string",
  "kode": "string",
  "nama": "string",
  "kkm": "number"
}
```

### NilaiModel
```json
{
  "id": "string",
  "siswaId": "string",
  "namaSiswa": "string",
  "mapelId": "string",
  "namaMapel": "string",
  "guruId": "string",
  "namaGuru": "string",
  "nilaiTugas": "number",
  "nilaiUTS": "number",
  "nilaiUAS": "number",
  "nilaiAkhir": "number",
  "tahunAjaran": "string",
  "semester": "string",
  "createdAt": "datetime | null",
  "updatedAt": "datetime | null"
}
```

---

## 🔧 MockAPI Setup

Untuk setup MockAPI, buat endpoint berikut di [mockapi.io](https://mockapi.io):

1. **users** - untuk data pengguna (guru, kepala sekolah, wali kelas)
2. **siswa** - untuk data siswa
3. **mata-pelajaran** - untuk data mata pelajaran
4. **nilai** - untuk data nilai siswa

### Sample Data untuk Import

#### Users:
```json
[
  {
    "id": "1",
    "nama": "Drs. H. Ahmad Fauzi, M.Pd",
    "email": "kepala@alfurqaan.sch.id",
    "password": "admin123",
    "role": "super_admin",
    "nip": "196505101990031001"
  },
  {
    "id": "2",
    "nama": "Siti Nurhaliza, S.Pd",
    "email": "siti@alfurqaan.sch.id",
    "password": "guru123",
    "role": "admin",
    "mapelId": "1",
    "namaMapel": "Matematika",
    "nip": "198203152006042001"
  },
  {
    "id": "5",
    "nama": "Budi Santoso, S.Pd",
    "email": "budi@alfurqaan.sch.id",
    "password": "wali123",
    "role": "user",
    "kelasId": "1",
    "namaKelas": "X IPA 1",
    "nip": "198912052012011001"
  }
]
```

#### Siswa:
```json
[
  {
    "id": "1",
    "nis": "2025001",
    "nama": "Muhammad Rizki",
    "kelasId": "1",
    "namaKelas": "X IPA 1",
    "tahunAjaran": "2025/2026",
    "semester": "Ganjil",
    "alamat": "Pasongsongan"
  },
  {
    "id": "2",
    "nis": "2025002",
    "nama": "Fatimah Azzahra",
    "kelasId": "1",
    "namaKelas": "X IPA 1",
    "tahunAjaran": "2025/2026",
    "semester": "Ganjil",
    "alamat": "Campaka"
  }
]
```

#### Mata Pelajaran:
```json
[
  {"id": "1", "kode": "MTK", "nama": "Matematika", "kkm": 75},
  {"id": "2", "kode": "BIND", "nama": "Bahasa Indonesia", "kkm": 75},
  {"id": "3", "kode": "BING", "nama": "Bahasa Inggris", "kkm": 75},
  {"id": "4", "kode": "FIS", "nama": "Fisika", "kkm": 75},
  {"id": "5", "kode": "KIM", "nama": "Kimia", "kkm": 75},
  {"id": "6", "kode": "BIO", "nama": "Biologi", "kkm": 75},
  {"id": "7", "kode": "SEJ", "nama": "Sejarah", "kkm": 75},
  {"id": "8", "kode": "GEO", "nama": "Geografi", "kkm": 75},
  {"id": "9", "kode": "EKO", "nama": "Ekonomi", "kkm": 75},
  {"id": "10", "kode": "PAI", "nama": "Pendidikan Agama Islam", "kkm": 75}
]
```

---

## 📝 Status Codes

| Code | Description |
|------|-------------|
| 200  | Success     |
| 201  | Created     |
| 400  | Bad Request |
| 401  | Unauthorized|
| 404  | Not Found   |
| 500  | Server Error|

---

## 🔐 Authentication

Saat ini menggunakan mock authentication. Untuk production, implementasikan:

1. **JWT Token** - Untuk autentikasi request
2. **Refresh Token** - Untuk memperbarui access token
3. **Role-based Access** - Sesuai dengan role user

---

**Last Updated:** 2026-01-05
