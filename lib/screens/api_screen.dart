import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/api_provider.dart';
import '../providers/view_state.dart';
import 'product_detail_screen.dart';

// ==========================================
// WARNA TEMA KAS KECIL
// ==========================================

const Color warnaHijau = Color(0xFF16865C);
const Color warnaHijauMuda = Color(0xFFE8F5EE);
const Color warnaBackground = Color(0xFFF3F8F5);

// ==========================================
// FORMAT HARGA RUPIAH
// Kurs simulasi: 1 USD = Rp16.000
// ==========================================

String formatRupiah(double hargaUSD) {
  final hargaIDR = hargaUSD * 16000;

  return NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  ).format(hargaIDR);
}

// ==========================================
// TERJEMAHAN NAMA PRODUK
// ==========================================

String namaProdukIndonesia(String nama) {
  const terjemahan = {
    'Essence Mascara Lash Princess': 'Maskara Essence Lash Princess',

    'Eyeshadow Palette with Mirror': 'Palet Eyeshadow dengan Cermin',

    'Powder Canister': 'Bedak Tabur',

    'Red Lipstick': 'Lipstik Merah',

    'Red Nail Polish': 'Kuteks Merah',

    'Calvin Klein CK One': 'Parfum Calvin Klein CK One',

    'Chanel Coco Noir Eau De': 'Parfum Chanel Coco Noir',
  };

  return terjemahan[nama] ?? nama;
}

// ==========================================
// TERJEMAHAN KATEGORI PRODUK
// ==========================================

String kategoriIndonesia(String kategori) {
  const terjemahan = {
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

  return terjemahan[kategori.toLowerCase()] ?? kategori;
}

// ==========================================
// HALAMAN REFERENSI HARGA PRODUK
// ==========================================

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ApiProvider>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final api = context.watch<ApiProvider>();

    return Scaffold(
      backgroundColor: warnaBackground,

      // ======================================
      // APP BAR
      // ======================================
      appBar: AppBar(
        title: const Text(
          'Referensi Harga Produk',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: warnaHijau,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // ======================================
      // KONDISI VIEW STATE
      // ======================================
      body: switch (api.state) {
        // LOADING
        ViewState.loading => const Center(
          child: CircularProgressIndicator(color: warnaHijau),
        ),

        // ERROR
        ViewState.error => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.cloud_off, size: 65, color: Colors.redAccent),

                const SizedBox(height: 16),

                Text(
                  api.error ?? 'Terjadi kesalahan saat mengambil data.',
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                FilledButton.icon(
                  style: FilledButton.styleFrom(backgroundColor: warnaHijau),
                  onPressed: api.fetchProducts,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        ),

        // EMPTY
        ViewState.empty => const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.inventory_2_outlined, size: 65, color: Colors.grey),

              SizedBox(height: 12),

              Text(
                'Data produk belum tersedia.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),

        // LOADED
        ViewState.loaded => RefreshIndicator(
          color: warnaHijau,
          onRefresh: api.fetchProducts,

          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: api.products.length,

            itemBuilder: (context, index) {
              final product = api.products[index];

              return Card(
                color: Colors.white,
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),

                  // GAMBAR PRODUK
                  leading: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: warnaHijauMuda,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),

                      child: product.thumbnail.isEmpty
                          ? const Icon(Icons.inventory_2, color: warnaHijau)
                          : Image.network(
                              product.thumbnail,
                              width: 65,
                              height: 65,
                              fit: BoxFit.contain,

                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.inventory_2,
                                  color: warnaHijau,
                                );
                              },
                            ),
                    ),
                  ),

                  // NAMA PRODUK INDONESIA
                  title: Text(
                    namaProdukIndonesia(product.title),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF20382C),
                    ),
                  ),

                  // KATEGORI DAN HARGA RUPIAH
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          kategoriIndonesia(product.category),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          formatRupiah(product.price),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: warnaHijau,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ICON DETAIL
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: warnaHijau,
                    size: 26,
                  ),

                  // NAVIGASI DETAIL PRODUK
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(product: product),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      },
    );
  }
}
