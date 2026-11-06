import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  // Warna utama aplikasi Kas Kecil
  static const Color hijau = Color(0xFF16865C);
  static const Color hijauMuda = Color(0xFFE8F5EE);
  static const Color background = Color(0xFFF3F8F5);

  // Konversi harga USD ke Rupiah
  // Kurs simulasi: 1 USD = Rp16.000
  String get hargaRupiah {
    final rupiah = product.price * 16000;

    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(rupiah);
  }

  // Terjemahan kategori
  String get kategoriIndonesia {
    const kategori = {
      'beauty': 'Kecantikan',
      'fragrances': 'Parfum',
      'furniture': 'Perabotan',
      'groceries': 'Bahan Makanan',
      'smartphones': 'Smartphone',
      'laptops': 'Laptop',
      'home-decoration': 'Dekorasi Rumah',
      'kitchen-accessories': 'Peralatan Dapur',
      'mens-shirts': 'Kemeja Pria',
      'mens-shoes': 'Sepatu Pria',
      'womens-dresses': 'Gaun Wanita',
      'womens-shoes': 'Sepatu Wanita',
      'tops': 'Atasan',
      'sunglasses': 'Kacamata',
      'vehicle': 'Kendaraan',
      'motorcycle': 'Sepeda Motor',
    };

    return kategori[product.category.toLowerCase()] ?? product.category;
  }

  // Deskripsi bahasa Indonesia
  String get deskripsiIndonesia {
    final title = product.title.toLowerCase();

    if (title.contains('mascara')) {
      return 'Produk maskara untuk membantu memperindah '
          'tampilan bulu mata. Produk ini dapat menjadi '
          'referensi pilihan perlengkapan kecantikan.';
    }

    if (title.contains('eyeshadow')) {
      return 'Produk palet eyeshadow yang digunakan '
          'untuk mempercantik riasan mata. Cocok sebagai '
          'referensi produk kategori kecantikan.';
    }

    if (title.contains('powder')) {
      return 'Produk bedak untuk melengkapi kebutuhan '
          'riasan wajah. Informasi harga dapat digunakan '
          'sebagai referensi perbandingan produk.';
    }

    if (title.contains('lipstick')) {
      return 'Produk lipstik untuk memberikan warna '
          'pada bibir dan melengkapi penampilan. '
          'Produk ini termasuk kategori kecantikan.';
    }

    if (title.contains('nail polish')) {
      return 'Produk kuteks untuk memberikan warna '
          'dan mempercantik tampilan kuku. '
          'Termasuk dalam kategori produk kecantikan.';
    }

    if (title.contains('calvin klein') ||
        title.contains('chanel') ||
        product.category.toLowerCase() == 'fragrances') {
      return 'Produk parfum yang digunakan untuk '
          'memberikan aroma wangi. Harga yang ditampilkan '
          'merupakan referensi katalog produk.';
    }

    return 'Produk ${product.title} termasuk dalam '
        'kategori ${kategoriIndonesia}. Informasi harga '
        'ini dapat digunakan sebagai referensi untuk '
        'membandingkan harga produk.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // APP BAR
      appBar: AppBar(
        title: const Text(
          'Detail Produk',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: hijau,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // GAMBAR PRODUK
          Container(
            height: 260,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: product.thumbnail.isNotEmpty
                  ? Image.network(
                      product.thumbnail,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 65,
                            color: Colors.grey,
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Icon(Icons.image, size: 65, color: Colors.grey),
                    ),
            ),
          ),

          const SizedBox(height: 24),

          // NAMA PRODUK
          Text(
            product.title,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xFF20382C),
            ),
          ),

          const SizedBox(height: 12),

          // KATEGORI
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: hijauMuda,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                kategoriIndonesia,
                style: const TextStyle(
                  color: hijau,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // HARGA RUPIAH
          Text(
            hargaRupiah,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: hijau,
            ),
          ),

          const SizedBox(height: 12),

          // RATING
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 25),
              const SizedBox(width: 6),
              Text(
                '${product.rating} / 5',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              const Text('Rating produk', style: TextStyle(color: Colors.grey)),
            ],
          ),

          const Divider(height: 35),

          // DESKRIPSI PRODUK
          const Text(
            'Deskripsi Produk',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF20382C),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            deskripsiIndonesia,
            style: const TextStyle(
              fontSize: 15,
              height: 1.7,
              color: Colors.black87,
            ),
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: 25),

          // CATATAN
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: hijauMuda,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: hijau),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Catatan: Harga produk merupakan '
                    'data referensi dari DummyJSON yang '
                    'dikonversi menggunakan kurs simulasi '
                    'Rp16.000 per USD. Harga ini bukan '
                    'transaksi aktual pada aplikasi Kas Kecil.',
                    style: TextStyle(fontSize: 13, height: 1.5, color: hijau),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
