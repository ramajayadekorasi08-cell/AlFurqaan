<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Models\Siswa;
use Illuminate\Support\Facades\Validator;

class SiswaController extends Controller
{
    public function index(Request $request)
    {
        $kelas_id = $request->query('kelas_id');
        if ($kelas_id) {
            return response()->json(Siswa::where('kelas_id', $kelas_id)->get());
        }
        return response()->json(Siswa::all());
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nis' => 'required|string|unique:siswas',
            'nama' => 'required|string',
            'kelas_id' => 'required|string',
            'nama_kelas' => 'required|string',
            'tahun_ajaran' => 'required|string',
            'semester' => 'required|string',
            'alamat' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $siswa = Siswa::create($request->all());

        return response()->json([
            'message' => 'Siswa created successfully',
            'siswa' => $siswa
        ], 201);
    }

    public function show(Siswa $siswa)
    {
        return response()->json($siswa);
    }
}
