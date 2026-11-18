import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'kelola_karyawan_page.dart';

class ProfilTokoPage extends StatefulWidget {
  const ProfilTokoPage({super.key});

  @override
  State<ProfilTokoPage> createState() => _ProfilTokoPageState();
}

class _ProfilTokoPageState extends State<ProfilTokoPage> {
  final _namaTokoC = TextEditingController();
  final _alamatC = TextEditingController();
  final _noWaC = TextEditingController();
  final _footerC = TextEditingController();

  bool _loading = false;
  String _kasirAktif = 'Belum Ditentukan';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _namaTokoC.dispose();
    _alamatC.dispose();
    _noWaC.dispose();
    _footerC.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _namaTokoC.text = prefs.getString('nama_toko') ?? 'SmartKasir Poliban';
      _alamatC.text = prefs.getString('alamat_toko') ?? 'Jl. Brigjend H. Hasan Basry, Banjarmasin';
      _noWaC.text = prefs.getString('no_wa') ?? '081234567890';
      _footerC.text = prefs.getString('footer_struk') ??
          'Terima Kasih Atas Kunjungan Anda! Barang yang sudah dibeli tidak dapat ditukar.';
      _kasirAktif = prefs.getString('active_cashier_name') ?? 'Belum Ditentukan';
    });
  }

  Future<void> _saveData() async {
    setState(() => _loading = true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama_toko', _namaTokoC.text.trim());
    await prefs.setString('alamat_toko', _alamatC.text.trim());
    await prefs.setString('no_wa', _noWaC.text.trim());
    await prefs.setString('footer_struk', _footerC.text.trim());

    if (!mounted) return;
    setState(() => _loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Identitas toko berhasil diperbarui!'),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Profil & Pengaturan Toko',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 1,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: Color(0xFF1E3A8A),
                      child: Icon(Icons.storefront, color: Colors.white, size: 26),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'KASIR AKTIF SHIFT INI',
                            style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _kasirAktif,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const KelolaKaryawanPage()),
                        );
                        _loadData();
                      },
                      icon: const Icon(Icons.people_outline, size: 16),
                      label: const Text('Kelola'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'IDENTITAS USAHA & STRUK KASIR',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1E3A8A)),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _namaTokoC,
              decoration: InputDecoration(
                labelText: 'Nama Toko / Usaha',
                prefixIcon: const Icon(Icons.store),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _alamatC,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Alamat Toko',
                prefixIcon: const Icon(Icons.location_on_outlined),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _noWaC,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Nomor WhatsApp / Kontak Toko',
                prefixIcon: const Icon(Icons.phone_outlined),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _footerC,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Catatan Kaki Struk (Footer Nota)',
                prefixIcon: const Icon(Icons.receipt_outlined),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loading ? null : _saveData,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              icon: _loading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Icon(Icons.save),
              label: Text(
                _loading ? 'Menyimpan Pengaturan...' : 'Simpan Profil Toko',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
