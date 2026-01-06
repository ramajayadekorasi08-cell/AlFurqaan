import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../domain/entities/siswa_entity.dart';
import '../../domain/entities/nilai_entity.dart';

class PDFGenerator {
  /// Build PDF Document (Helper)
  static Future<pw.Document> _buildPDFDocument({
    required SiswaEntity siswa,
    required List<NilaiEntity> nilaiList,
    required double rataRata,
    String? waliKelasName,
    String? waliKelasNip,
    String? kepsekName,
    String? kepsekNip,
  }) async {
    // Inisialisasi locale Indonesia untuk tanggal
    await initializeDateFormatting('id_ID', null);
    
    final pdf = pw.Document();

    // Load logo
    final ByteData logoData = await rootBundle.load('assets/images/logo_sekolah.jpg');
    final Uint8List logoBytes = logoData.buffer.asUint8List();
    final logo = pw.MemoryImage(logoBytes);

    // Font
    final font = await PdfGoogleFonts.poppinsRegular();
    final fontBold = await PdfGoogleFonts.poppinsBold();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildHeader(logo, fontBold),
              pw.SizedBox(height: 20),
              pw.Divider(thickness: 2),
              pw.SizedBox(height: 20),
              _buildIdentitasSiswa(siswa, font, fontBold),
              pw.SizedBox(height: 20),
              _buildTabelNilai(nilaiList, font, fontBold),
              pw.SizedBox(height: 20),
              _buildRataRata(rataRata, font, fontBold),
              pw.SizedBox(height: 30),
              pw.Spacer(),
              _buildTandaTangan(
                font, 
                fontBold,
                waliKelasName: waliKelasName,
                waliKelasNip: waliKelasNip,
                kepsekName: kepsekName,
                kepsekNip: kepsekNip,
              ),
              pw.SizedBox(height: 20),
              _buildFooter(font),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  /// Print PDF
  static Future<void> printPDF({
    required SiswaEntity siswa,
    required List<NilaiEntity> nilaiList,
    required double rataRata,
    String? waliKelasName,
    String? waliKelasNip,
    String? kepsekName,
    String? kepsekNip,
  }) async {
    final pdf = await _buildPDFDocument(
      siswa: siswa,
      nilaiList: nilaiList,
      rataRata: rataRata,
      waliKelasName: waliKelasName,
      waliKelasNip: waliKelasNip,
      kepsekName: kepsekName,
      kepsekNip: kepsekNip,
    );

    await Printing.layoutPdf(
      name: 'Nilai_${siswa.nama.replaceAll(' ', '_')}.pdf',
      onLayout: (format) async => pdf.save(),
    );
  }

  /// Download PDF
  static Future<void> downloadPDF({
    required SiswaEntity siswa,
    required List<NilaiEntity> nilaiList,
    required double rataRata,
    String? waliKelasName,
    String? waliKelasNip,
    String? kepsekName,
    String? kepsekNip,
  }) async {
    final pdf = await _buildPDFDocument(
      siswa: siswa,
      nilaiList: nilaiList,
      rataRata: rataRata,
      waliKelasName: waliKelasName,
      waliKelasNip: waliKelasNip,
      kepsekName: kepsekName,
      kepsekNip: kepsekNip,
    );

    final bytes = await pdf.save();

    if (kIsWeb) {
      // Di Web, sharePdf akan memicu download browser
      await Printing.sharePdf(
        bytes: bytes,
        filename: 'Nilai_${siswa.nama.replaceAll(' ', '_')}.pdf',
      );
    } else {
      // Di Mobile, simpan ke dokumen dan beri pilihan share/save
      await _savePDF(pdf, siswa);
      await Printing.sharePdf(
        bytes: bytes,
        filename: 'Nilai_${siswa.nama.replaceAll(' ', '_')}.pdf',
      );
    }
  }

  /// DEPRECATED: Gunakan printPDF atau downloadPDF
  static Future<void> generateNilaiPDF({
    required SiswaEntity siswa,
    required List<NilaiEntity> nilaiList,
    required double rataRata,
    String? waliKelasName,
    String? waliKelasNip,
    String? kepsekName,
    String? kepsekNip,
  }) async {
    await printPDF(
      siswa: siswa,
      nilaiList: nilaiList,
      rataRata: rataRata,
      waliKelasName: waliKelasName,
      waliKelasNip: waliKelasNip,
      kepsekName: kepsekName,
      kepsekNip: kepsekNip,
    );
  }

  /// Build Header
  static pw.Widget _buildHeader(pw.MemoryImage logo, pw.Font fontBold) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Logo
        pw.Container(
          width: 80,
          height: 80,
          child: pw.Image(logo, fit: pw.BoxFit.contain),
        ),
        pw.SizedBox(width: 20),

        // Info Sekolah
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(
                'MA AL-FURQAAN',
                style: pw.TextStyle(
                  font: fontBold,
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                'Campaka Pasongsongan',
                style: pw.TextStyle(fontSize: 12),
              ),
              pw.SizedBox(height: 2),
              pw.Text(
                'Telp: (0328) xxx-xxxx',
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                'LAPORAN NILAI SISWA',
                style: pw.TextStyle(
                  font: fontBold,
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(width: 100), // Balance logo
      ],
    );
  }

  /// Build Identitas Siswa
  static pw.Widget _buildIdentitasSiswa(
    SiswaEntity siswa,
    pw.Font font,
    pw.Font fontBold,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Nama Siswa', siswa.nama, font, fontBold),
          pw.SizedBox(height: 6),
          _buildInfoRow('NIS', siswa.nis, font, fontBold),
          pw.SizedBox(height: 6),
          _buildInfoRow('Kelas', siswa.namaKelas, font, fontBold),
          pw.SizedBox(height: 6),
          _buildInfoRow('Semester', siswa.semester, font, fontBold),
          pw.SizedBox(height: 6),
          _buildInfoRow('Tahun Ajaran', siswa.tahunAjaran, font, fontBold),
        ],
      ),
    );
  }

  static pw.Widget _buildInfoRow(
    String label,
    String value,
    pw.Font font,
    pw.Font fontBold,
  ) {
    return pw.Row(
      children: [
        pw.SizedBox(
          width: 120,
          child: pw.Text(
            label,
            style: pw.TextStyle(font: font, fontSize: 11),
          ),
        ),
        pw.Text(
          ': ',
          style: pw.TextStyle(font: font, fontSize: 11),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(font: fontBold, fontSize: 11),
        ),
      ],
    );
  }

  /// Build Tabel Nilai
  static pw.Widget _buildTabelNilai(
    List<NilaiEntity> nilaiList,
    pw.Font font,
    pw.Font fontBold,
  ) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey400),
      children: [
        // Header
        pw.TableRow(
          decoration: const pw.BoxDecoration(
            color: PdfColors.green700,
          ),
          children: [
            _buildTableCell('No', font, fontBold, isHeader: true),
            _buildTableCell('Mata Pelajaran', font, fontBold, isHeader: true),
            _buildTableCell('Tugas', font, fontBold, isHeader: true),
            _buildTableCell('UTS', font, fontBold, isHeader: true),
            _buildTableCell('UAS', font, fontBold, isHeader: true),
            _buildTableCell('Nilai Akhir', font, fontBold, isHeader: true),
          ],
        ),

        // Data rows
        ...nilaiList.asMap().entries.map((entry) {
          final index = entry.key;
          final nilai = entry.value;
          return pw.TableRow(
            decoration: pw.BoxDecoration(
              color: index.isEven ? PdfColors.grey100 : PdfColors.white,
            ),
            children: [
              _buildTableCell((index + 1).toString(), font, fontBold),
              _buildTableCell(nilai.namaMapel, font, fontBold, align: pw.TextAlign.left),
              _buildTableCell(nilai.nilaiTugas.toStringAsFixed(0), font, fontBold),
              _buildTableCell(nilai.nilaiUTS.toStringAsFixed(0), font, fontBold),
              _buildTableCell(nilai.nilaiUAS.toStringAsFixed(0), font, fontBold),
              _buildTableCell(
                nilai.nilaiAkhir.toStringAsFixed(2),
                font,
                fontBold,
                isBold: true,
              ),
            ],
          );
        }).toList(),
      ],
    );
  }

  static pw.Widget _buildTableCell(
    String text,
    pw.Font font,
    pw.Font fontBold, {
    bool isHeader = false,
    bool isBold = false,
    pw.TextAlign align = pw.TextAlign.center,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          font: isHeader || isBold ? fontBold : font,
          fontSize: isHeader ? 11 : 10,
          color: isHeader ? PdfColors.white : PdfColors.black,
          fontWeight: isHeader || isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
        textAlign: align,
      ),
    );
  }

  /// Build Rata-rata
  static pw.Widget _buildRataRata(
    double rataRata,
    pw.Font font,
    pw.Font fontBold,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColors.green50,
        border: pw.Border.all(color: PdfColors.green700),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Rata-rata Nilai',
            style: pw.TextStyle(
              font: fontBold,
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            rataRata.toStringAsFixed(2),
            style: pw.TextStyle(
              font: fontBold,
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green900,
            ),
          ),
        ],
      ),
    );
  }

  /// Build Tanda Tangan
  static pw.Widget _buildTandaTangan(
    pw.Font font, 
    pw.Font fontBold, {
    String? waliKelasName,
    String? waliKelasNip,
    String? kepsekName,
    String? kepsekNip,
  }) {
    final tanggal = DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.now());

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Wali Kelas
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Wali Kelas,',
              style: pw.TextStyle(font: font, fontSize: 10),
            ),
            pw.SizedBox(height: 50),
            pw.Text(
              waliKelasName ?? '(...........................)',
              style: pw.TextStyle(
                font: fontBold, 
                fontSize: 10,
                decoration: pw.TextDecoration.underline,
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              'NIP: ${waliKelasNip ?? "........................"}',
              style: pw.TextStyle(font: font, fontSize: 9),
            ),
          ],
        ),

        // Kepala Sekolah
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              'Pasongsongan, $tanggal',
              style: pw.TextStyle(font: font, fontSize: 10),
            ),
            pw.Text(
              'Kepala Sekolah,',
              style: pw.TextStyle(font: font, fontSize: 10),
            ),
            pw.SizedBox(height: 50),
            pw.Text(
              kepsekName ?? '(...........................)',
              style: pw.TextStyle(
                font: fontBold, 
                fontSize: 10,
                decoration: pw.TextDecoration.underline,
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              'NIP: ${kepsekNip ?? "........................"}',
              style: pw.TextStyle(font: font, fontSize: 9),
            ),
          ],
        ),
      ],
    );
  }

  /// Build Footer
  static pw.Widget _buildFooter(pw.Font font) {
    final tanggalCetak = DateFormat('dd MMMM yyyy HH:mm', 'id_ID').format(DateTime.now());

    return pw.Center(
      child: pw.Text(
        'Dicetak pada: $tanggalCetak',
        style: pw.TextStyle(
          font: font,
          fontSize: 8,
          color: PdfColors.grey600,
        ),
      ),
    );
  }

  /// Save PDF to device
  static Future<void> _savePDF(pw.Document pdf, SiswaEntity siswa) async {
    try {
      final output = await getApplicationDocumentsDirectory();
      final fileName = 'Nilai_${siswa.nama.replaceAll(' ', '_')}_${siswa.namaKelas}_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('${output.path}/$fileName');
      await file.writeAsBytes(await pdf.save());
      print('PDF saved to: ${file.path}');
    } catch (e) {
      print('Error saving PDF: $e');
      rethrow;
    }
  }
}
