<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Super Admin (Kepala Sekolah)
        User::create([
            'name' => 'Kepala Sekolah',
            'email' => 'kepsek@sekolah.id',
            'password' => 'password',
            'role' => 'super_admin',
        ]);

        // Guru Wali Kelas (User Login)
        User::create([
            'name' => 'Wali Kelas X-A',
            'email' => 'wali@sekolah.id',
            'password' => 'password',
            'role' => 'user',
            'kelas_id' => 'X-A',
            'nama_kelas' => 'X-A',
        ]);

        // Guru Mapel (Admin)
        User::create([
            'name' => 'Guru Matematika',
            'email' => 'mtk@sekolah.id',
            'password' => 'password',
            'role' => 'admin',
            'mapel_id' => 'MAT101',
            'nama_mapel' => 'Matematika',
        ]);
    }
}
