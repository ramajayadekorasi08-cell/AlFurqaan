<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\SiswaController;
use App\Http\Controllers\Api\NilaiController;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/users', [AuthController::class, 'index']);
    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    // Siswa Routes
    Route::get('/siswas', [SiswaController::class, 'index']);
    Route::post('/siswas', [SiswaController::class, 'store']);
    Route::get('/siswas/{siswa}', [SiswaController::class, 'show']);

    // Nilai Routes
    Route::get('/nilais', [NilaiController::class, 'index']);
    Route::post('/nilais', [NilaiController::class, 'store']);
    Route::get('/nilais/detail', [NilaiController::class, 'getByMapelSiswa']);
});
