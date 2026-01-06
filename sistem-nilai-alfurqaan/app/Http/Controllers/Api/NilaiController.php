<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Models\Nilai;
use Illuminate\Support\Facades\Validator;

class NilaiController extends Controller
{
    public function index(Request $request)
    {
        $siswa_id = $request->query('siswa_id');
        $guru_id = $request->query('guru_id');
        
        $query = Nilai::query();
        
        if ($siswa_id) {
            $query->where('siswa_id', $siswa_id);
        }
        
        if ($guru_id) {
            $query->where('guru_id', $guru_id);
        }
        
        return response()->json($query->get());
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'siswa_id' => 'required',
            'nama_siswa' => 'required|string',
            'mapel_id' => 'required|string',
            'nama_mapel' => 'required|string',
            'guru_id' => 'required',
            'nama_guru' => 'required|string',
            'nilai_tugas' => 'required|numeric',
            'nilai_uts' => 'required|numeric',
            'nilai_uas' => 'required|numeric',
            'nilai_akhir' => 'required|numeric',
            'grade' => 'required|string',
            'tahun_ajaran' => 'required|string',
            'semester' => 'required|string',
        ]);

        if ($validator->fails()) {
            \Log::error('Validation failed for Nilai:', $validator->errors()->toArray());
            return response()->json($validator->errors(), 422);
        }

        try {
            // Check if exists to update, else create
            // We exclude 'id' from the update data to avoid changing primary keys
            $data = $request->except('id');
            
            $nilai = Nilai::updateOrCreate(
                [
                    'siswa_id' => $request->siswa_id,
                    'mapel_id' => $request->mapel_id,
                    'tahun_ajaran' => $request->tahun_ajaran,
                    'semester' => $request->semester,
                ],
                $data
            );

            return response()->json([
                'message' => 'Nilai saved successfully',
                'nilai' => $nilai
            ], 200);
        } catch (\Exception $e) {
            \Log::error('Error saving Nilai: ' . $e->getMessage());
            return response()->json(['message' => 'Internal Server Error', 'error' => $e->getMessage()], 500);
        }
    }
    
    public function getByMapelSiswa(Request $request) {
        $mapel_id = $request->query('mapel_id');
        $siswa_id = $request->query('siswa_id');
        
        $nilai = Nilai::where('mapel_id', $mapel_id)
                      ->where('siswa_id', $siswa_id)
                      ->first();
                      
        return response()->json($nilai);
    }
}
