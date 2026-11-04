class Produk {
  final int id;
  final String nama;
  final double harga;
  final String kategori;
  final String pathGambar;
  final int diskonPersen;

  Produk({
    required this.id,
    required this.nama,
    required this.harga,
    required this.kategori,
    required this.pathGambar,
    this.diskonPersen = 0,
  });

  double get hargaSetelahDiskon {
    if (diskonPersen <= 0) return harga;
    return harga - (harga * (diskonPersen / 100));
  }
}

List<Produk> daftarProdukDummy = [
  Produk(
    id: 1,
    nama: 'Kopi Susu Gula Aren',
    harga: 18000,
    kategori: 'Minuman',
    pathGambar: 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=500',
    diskonPersen: 20, // Tantangan Live Tweak 3: Diskon 20%
  ),
  Produk(
    id: 2,
    nama: 'Roti Bakar Cokelat',
    harga: 15000,
    kategori: 'Makanan',
    pathGambar: 'https://images.unsplash.com/photo-1584776296944-ab6fb57b0bdd?w=500',
    diskonPersen: 0,
  ),
  Produk(
    id: 3,
    nama: 'Croissant Butter',
    harga: 22000,
    kategori: 'Makanan',
    pathGambar: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=500',
    diskonPersen: 0,
  ),
  Produk(
    id: 4,
    nama: 'Matcha Latte',
    harga: 24000,
    kategori: 'Minuman',
    pathGambar: 'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=500',
    diskonPersen: 0,
  ),
  Produk(
    id: 5,
    nama: 'Kentang Goreng',
    harga: 12000,
    kategori: 'Camilan',
    pathGambar: 'https://images.unsplash.com/photo-1576107232684-1279f3908594?w=500',
    diskonPersen: 0,
  ),
];