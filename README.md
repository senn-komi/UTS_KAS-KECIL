APLIKASI KAS KECIL
Ujian Tengah Semester (UTS) Pemrograman Multi Platform
Fakultas Teknologi Informasi — Institut Sains dan Bisnis Atma Luhur Pangkalpinang
Program Studi: Teknologi Informasi | Tahun Akademik: 2026/2027

Aplikasi Flutter untuk mencatat dan mengelola transaksi pemasukan serta pengeluaran dengan Firebase Authentication, Cloud Firestore, Provider, dan REST API Dio.
👥 Anggota Kelompok & Pembagian Peran
No.	Nama Mahasiswa	NIM	Peran
1	Zena Juniarti	2411500046	Firebase Authentication, AuthProvider, navigasi, main.dart, dan struktur folder
2	Zahro Safitri	2411500063	Firestore CRUD, Model, Service, TransactionProvider, ViewState, Dio REST API, ApiProvider, dan Future vs Stream


Rincian Pembagian Tugas
Anggota 1 — Authentication, Navigasi, dan Struktur Aplikasi
- Menyiapkan struktur folder dan konfigurasi awal aplikasi.
- Menginisialisasi Firebase melalui main.dart dan firebase_options.dart.
- Mengimplementasikan Firebase Authentication: Register, Login, dan Logout.
- Membuat dan mengelola AuthService serta AuthProvider.
- Memantau perubahan status autentikasi menggunakan authStateChanges().
- Mengatur AuthGate dan navigasi berdasarkan status login pengguna.
Anggota 2 — Firestore CRUD, Provider, dan REST API
- Membuat TransactionModel dan ProductModel.
- Membuat FirestoreService untuk operasi Create, Read, Update, dan Delete transaksi.
- Membuat TransactionProvider untuk mengelola data transaksi dan menghitung pemasukan, pengeluaran, serta saldo.
- Mengimplementasikan ViewState untuk status loading, loaded, error, dan empty.
- Membuat ApiService menggunakan Dio untuk mengambil data dari REST API DummyJSON.
- Membuat ApiProvider serta mendukung tampilan daftar dan detail produk.
- Menerapkan Future untuk proses asynchronous satu kali dan Stream untuk memantau perubahan data secara berkelanjutan.
Karena kelompok terdiri dari dua orang, Anggota 2 merangkap tugas integrasi Dio REST API, penanganan loading/error/empty, serta penerapan Future dan Stream.

🚀 Fitur Aplikasi
1. Firebase Authentication
- Register, login, dan logout menggunakan email dan password.
- Memantau status autentikasi secara reaktif menggunakan Stream<User?> melalui authStateChanges().
- Mengarahkan pengguna ke halaman login atau halaman utama berdasarkan status autentikasi.
2. Cloud Firestore CRUD
- Menyimpan data transaksi pada collection transactions.
- Mendukung Create, Read, Update, dan Delete transaksi.
- Menggunakan owner (UID pengguna) untuk mengaitkan transaksi dengan akun pemiliknya.
- Menggunakan Timestamp untuk menyimpan waktu transaksi.
- Memantau perubahan data transaksi menggunakan snapshots().
3. Provider dan ViewState
- Menggunakan tiga ChangeNotifier: AuthProvider, TransactionProvider, dan ApiProvider.
- Mendaftarkan Provider melalui MultiProvider pada main.dart.
- Mengelola kondisi tampilan menggunakan ViewState: loading, loaded, error, dan empty.
- Menggunakan notifyListeners() untuk memberi tahu widget ketika state berubah.
- Membatalkan subscription Stream ketika Provider tidak lagi digunakan.
4. REST API Dio (read-only)
- Mengambil data produk dari DummyJSON (https://dummyjson.com/products).
- Menggunakan Dio untuk mengirim HTTP GET request.
- Mengubah respons JSON menjadi objek ProductModel.
- Menampilkan loading, empty state, error, dan tombol untuk mencoba kembali.
- Menampilkan daftar produk dan halaman detail produk.
- Menampilkan harga dalam Rupiah menggunakan kurs simulasi Rp16.000 per USD.
5. Navigasi dan Halaman Aplikasi
Halaman	Berkas	Fungsi
Login	login_screen.dart	Autentikasi pengguna yang telah memiliki akun
Register	register_screen.dart	Pendaftaran akun pengguna baru
Home	home_screen.dart	Ringkasan saldo, pemasukan, pengeluaran, dan riwayat transaksi
Form Transaksi	transaction_form.dart	Menambah atau mengubah transaksi
Daftar Produk	api_screen.dart	Menampilkan produk dari REST API
Detail Produk	product_detail_screen.dart	Menampilkan informasi detail produk yang dipilih


🛠️ Teknologi yang Digunakan
Teknologi	Keterangan
Flutter	Framework untuk membangun aplikasi mobile
Dart	Bahasa pemrograman aplikasi
Firebase Authentication	Mengelola register, login, dan logout
Cloud Firestore	Menyimpan dan mengelola transaksi
Provider / MultiProvider	Mengelola state aplikasi
Dio	Menghubungkan aplikasi dengan REST API
DummyJSON	Sumber data produk dari REST API
Future	Menangani proses asynchronous yang menghasilkan satu penyelesaian
Stream	Menangani aliran data dan pembaruan secara berkelanjutan


📸 Screenshot
Tambahkan screenshot aktual aplikasi pada bagian berikut. Simpan gambar di repository, misalnya pada folder screenshots/, kemudian sesuaikan nama file pada tautan gambar.
Login	Register
keuangan_gambar/login.png	keuangan_gambar/register.png


Home	Form Transaksi
keuangan_gambar/home.png	keuangan_gambar/tambah.png


Daftar Produk	Detail Produk
keuangan_gambar/hapus.png	keuangan_gambar/logout.png


Contoh menampilkan gambar setelah file screenshot tersedia:
![Halaman Login](screenshots/login.png)
🛠️ Cara Menjalankan Aplikasi
Prasyarat: Flutter SDK, Dart SDK, Android Studio atau Visual Studio Code, koneksi internet, serta proyek Firebase.
# 1. Clone repository
git clone https://github.com/senn-komi/UTS_KAS-KECIL.git

# 2. Masuk ke folder proyek
cd UTS_KAS-KECIL

# 3. Unduh dependensi
flutter pub get

# 4. Jalankan aplikasi
flutter run
Konfigurasi Firebase
File lib/firebase_options.dart perlu tersedia di repository dan tidak boleh dimasukkan ke .gitignore agar konfigurasi Firebase proyek dapat digunakan.

Jika ingin menghubungkan aplikasi ke proyek Firebase sendiri, jalankan:
dart pub global activate flutterfire_cli
firebase login
flutterfire configure
Pastikan Email/Password telah diaktifkan pada Firebase Console bagian Authentication dan Cloud Firestore telah dibuat serta dikonfigurasi.

Untuk memeriksa kode, jalankan:
flutter analyze
🔄 Penerapan Future dan Stream
Future digunakan untuk proses asynchronous yang menghasilkan satu hasil penyelesaian. Dalam aplikasi ini, Future digunakan antara lain untuk mengambil data produk melalui Dio, proses login/register, serta operasi CRUD dan pengambilan data satu kali.

Stream digunakan untuk menerima data atau perubahan secara berkelanjutan. Dalam aplikasi ini, Stream digunakan untuk memantau perubahan status autentikasi melalui authStateChanges() dan perubahan data transaksi Firestore melalui snapshots().

Dengan demikian, Future sesuai untuk proses yang cukup dilakukan satu kali, sedangkan Stream digunakan ketika aplikasi perlu terus mendengarkan pembaruan.
🔗 Video Presentasi
- Link Video: Tambahkan tautan video presentasi di sini
ℹ️ Informasi Repository
- Nama Repository: UTS_KAS-KECIL
- Link GitHub: https://github.com/senn-komi/UTS_KAS-KECIL
- Folder Project: keuangan
- Mata Kuliah: Pemrograman Multi Platform
- Institusi: Institut Sains dan Bisnis Atma Luhur Pangkalpinang
