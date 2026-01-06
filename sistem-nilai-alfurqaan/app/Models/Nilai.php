<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Nilai extends Model
{
    protected $fillable = [
        'siswa_id',
        'nama_siswa',
        'mapel_id',
        'nama_mapel',
        'guru_id',
        'nama_guru',
        'nilai_tugas',
        'nilai_uts',
        'nilai_uas',
        'nilai_akhir',
        'grade',
        'tahun_ajaran',
        'semester',
    ];
}
