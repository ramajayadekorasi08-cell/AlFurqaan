<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Siswa extends Model
{
    protected $fillable = [
        'nis',
        'nama',
        'kelas_id',
        'nama_kelas',
        'tahun_ajaran',
        'semester',
        'alamat',
        'no_telp',
    ];
}
