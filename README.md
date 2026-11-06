# APLIKASI KAS KECIL
### Ujian Tengah Semester (UTS) Pemrograman Multi Platform

<p align="center">
  <b>Repository GitHub:</b> UTS_KAS-KECIL
</p>

## 1. Identitas Proyek

| Keterangan | Informasi |
|---|---|
| Nama Aplikasi | Kas Kecil |
| Nama Repository | UTS_KAS-KECIL |
| Folder Project | keuangan |
| Mata Kuliah | Pemrograman Multi Platform |
| Program Studi | Teknologi Informasi |
| Institusi | Institut Sains dan Bisnis Atma Luhur Pangkalpinang |
| Tahun Akademik | 2026/2027 |
| Framework | Flutter |
| Bahasa Pemrograman | Dart |
| Basis Data | Firebase Cloud Firestore |
| Autentikasi | Firebase Authentication |
| REST API | Dio |
| State Management | Provider / MultiProvider |

## 2. Deskripsi Aplikasi

Kas Kecil merupakan aplikasi berbasis mobile yang dikembangkan menggunakan framework Flutter dan bahasa pemrograman Dart. Aplikasi ini dirancang untuk membantu pengguna dalam melakukan pencatatan serta pengelolaan keuangan sederhana, khususnya transaksi pemasukan dan pengeluaran.

Melalui aplikasi ini, pengguna dapat melakukan registrasi dan login, mencatat transaksi pemasukan maupun pengeluaran, melihat daftar transaksi, mengubah data transaksi, serta menghapus transaksi yang sudah tidak diperlukan.

Aplikasi ini menggunakan Firebase Authentication untuk mengelola autentikasi pengguna dan Firebase Cloud Firestore sebagai media penyimpanan data transaksi. Selain itu, aplikasi juga dilengkapi dengan fitur integrasi REST API menggunakan package Dio untuk mengambil dan menampilkan data dari layanan API.

Pengelolaan state aplikasi dilakukan menggunakan Provider dan MultiProvider, sehingga proses pengambilan serta pengelolaan data dapat dilakukan secara lebih terstruktur.

Proyek ini dikembangkan sebagai bagian dari Ujian Tengah Semester mata kuliah Pemrograman Multi Platform dengan menerapkan materi Dart Async, REST API, Provider/MultiProvider, Firebase Authentication, dan Firestore CRUD.

## 3. Anggota Kelompok

| No. | Nama | NIM |
|---|---|---|
| 1 | Zena Juniarti | 2411500046 |
| 2 | Zahro Safitri | 2411500063 |

## 4. Fitur Aplikasi

Aplikasi Kas Kecil memiliki beberapa fitur utama, antara lain:

1. *Registrasi Pengguna*  
   Memungkinkan pengguna membuat akun baru untuk menggunakan aplikasi.

2. *Login Pengguna*  
   Pengguna dapat masuk ke aplikasi menggunakan akun yang telah terdaftar melalui Firebase Authentication.

3. *Logout*  
   Menyediakan fitur keluar dari akun pengguna.

4. *Halaman Beranda*  
   Menampilkan halaman utama aplikasi setelah pengguna berhasil melakukan login.

5. *Tambah Transaksi*  
   Memungkinkan pengguna mencatat transaksi pemasukan dan pengeluaran.

6. *Daftar Transaksi*  
   Menampilkan data transaksi yang telah disimpan dalam database.

7. *Edit Transaksi*  
   Memungkinkan pengguna mengubah informasi transaksi yang telah dibuat.

8. *Hapus Transaksi*  
   Memungkinkan pengguna menghapus data transaksi yang sudah tidak diperlukan.

9. *Integrasi REST API*  
   Mengambil data dari layanan API publik menggunakan package Dio.

10. *Daftar Data API*  
    Menampilkan data yang diperoleh dari REST API.

11. *Detail Data API*  
    Menampilkan informasi lebih lengkap berdasarkan data yang dipilih.

12. *Pengelolaan State*  
    Menggunakan Provider untuk mengelola kondisi loading, loaded, error, dan empty.

13. *Integrasi Firebase*  
    Menggunakan Firebase Authentication dan Cloud Firestore untuk mendukung proses autentikasi serta penyimpanan data transaksi.

## 5. Teknologi yang Digunakan

| Teknologi | Keterangan |
|---|---|
| Flutter | Framework untuk membangun aplikasi mobile. |
| Dart | Bahasa pemrograman yang digunakan dalam pengembangan aplikasi. |
| Firebase Authentication | Mengelola proses registrasi, login, dan logout pengguna. |
| Cloud Firestore | Menyimpan dan mengelola data transaksi. |
| Provider | Mengelola state atau kondisi data aplikasi. |
| MultiProvider | Menyediakan beberapa provider dalam aplikasi. |
| Dio | Menghubungkan aplikasi dengan layanan REST API. |
| Future | Menangani proses asinkron yang menghasilkan satu nilai. |
| Stream | Menangani aliran data secara berkelanjutan. |

## 6. Struktur Folder Proyek

Berikut merupakan struktur folder utama dari proyek aplikasi Kas Kecil:

text
keuangan/
│
├── android/
│
├── lib/
│   ├── models/
│   │   ├── product_model.dart
│   │   └── transaction_model.dart
│   │
│   ├── providers/
│   │   ├── api_provider.dart
│   │   ├── auth_provider.dart
│   │   ├── transaction_provider.dart
│   │   └── view_state.dart
│   │
│   ├── screens/
│   │   ├── api_screen.dart
│   │   ├── auth_screen.dart
│   │   ├── home_screen.dart
│   │   ├── login_screen.dart
│   │   ├── product_detail_screen.dart
│   │   └── register_screen.dart
│   │
│   ├── services/
│   │   ├── api_service.dart
│   │   ├── auth_service.dart
│   │   └── firestore_service.dart
│   │
│   ├── widgets/
│   │   ├── transaction_card.dart
│   │   └── transaction_form.dart
│   │
│   ├── firebase_options.dart
│   └── main.dart
│
├── pubspec.yaml
├── pubspec.lock
└── README.md


### Penjelasan Struktur Folder

- *models/*  
  Berisi model data yang digunakan untuk merepresentasikan data produk dan transaksi dalam aplikasi.

- *providers/*  
  Berisi pengelolaan state aplikasi, termasuk autentikasi pengguna, pengambilan data API, pengelolaan transaksi, serta status tampilan aplikasi.

- *screens/*  
  Berisi halaman antarmuka aplikasi, seperti halaman login, registrasi, beranda, daftar data API, dan detail produk.

- *services/*  
  Berisi layanan yang bertanggung jawab dalam proses komunikasi dengan Firebase Authentication, Cloud Firestore, dan REST API.

- *widgets/*  
  Berisi komponen antarmuka yang dapat digunakan kembali, seperti kartu transaksi dan formulir transaksi.

- *firebase_options.dart*  
  Berisi konfigurasi Firebase yang digunakan untuk menghubungkan aplikasi dengan proyek Firebase.

- *main.dart*  
  Merupakan file utama aplikasi yang digunakan untuk menjalankan aplikasi serta mengatur konfigurasi awal dan provider.

## 7. Dokumentasi Screenshot Aplikasi

Bagian ini berisi dokumentasi tampilan aplikasi dan bukti implementasi fitur yang telah dikembangkan.

### A. Tampilan Aplikasi

*1. Halaman Login*

Menampilkan halaman autentikasi untuk pengguna yang telah memiliki akun.

*2. Halaman Registrasi*

Menampilkan halaman pendaftaran akun pengguna baru.

*3. Halaman Beranda*

Menampilkan halaman utama aplikasi setelah pengguna berhasil login.

*4. Halaman Daftar Transaksi*

Menampilkan daftar transaksi pemasukan dan pengeluaran.

*5. Halaman Tambah Transaksi*

Menampilkan formulir untuk memasukkan data transaksi baru.

*6. Halaman Edit Transaksi*

Menampilkan formulir untuk mengubah data transaksi.

*7. Proses Hapus Transaksi*

Menampilkan proses penghapusan data transaksi.

*8. Proses Logout*

Menampilkan proses pengguna keluar dari aplikasi.

*9. Halaman Data API*

Menampilkan daftar data yang diperoleh melalui REST API.

*10. Halaman Detail API*

Menampilkan informasi detail dari data yang dipilih.

### B. Bukti Implementasi Firebase

*1. Firebase Authentication*

Dokumentasi proses autentikasi dan data akun pengguna yang telah terdaftar.

*2. Cloud Firestore*

Dokumentasi penyimpanan data transaksi pemasukan dan pengeluaran.

*3. Firestore Security Rules*

Dokumentasi aturan keamanan yang diterapkan pada database Firestore.

> Catatan: Screenshot aplikasi dan Firebase dapat ditambahkan pada bagian ini agar dokumentasi proyek lebih lengkap.

## 8. Cara Menjalankan Aplikasi

### A. Persyaratan

Sebelum menjalankan aplikasi, pastikan perangkat telah memiliki:

- Flutter SDK.
- Dart SDK.
- Android Studio atau Visual Studio Code.
- Koneksi internet.
- Akun dan proyek Firebase.
- Emulator Android atau perangkat Android.

### B. Langkah Instalasi

*1. Clone Repository*

Buka terminal dan jalankan perintah berikut:

bash
git clone https://github.com/senn-komi/UTS_KAS-KECIL.git


*2. Masuk ke Folder Proyek*

bash
cd UTS_KAS-KECIL


*3. Instal Dependensi*

Jalankan perintah berikut untuk mengunduh seluruh package yang dibutuhkan:

bash
flutter pub get


*4. Konfigurasi Firebase*

Pastikan aplikasi telah terhubung dengan proyek Firebase yang sesuai.

Apabila diperlukan, lakukan konfigurasi menggunakan FlutterFire CLI:

bash
dart pub global activate flutterfire_cli
flutterfire configure


Pastikan konfigurasi Firebase pada file firebase_options.dart dan konfigurasi platform sudah sesuai.

Aktifkan Firebase Authentication dan Cloud Firestore pada Firebase Console.

*5. Pemeriksaan Kode Program*

Untuk memeriksa kemungkinan kesalahan pada kode, jalankan:

bash
flutter analyze


*6. Menjalankan Aplikasi*

Jalankan aplikasi menggunakan perintah:

bash
flutter run


Aplikasi kemudian dapat dijalankan melalui emulator Android maupun perangkat Android yang terhubung.

## 9. Penerapan Konsep Pemrograman Asinkron

Dalam aplikasi Kas Kecil, konsep pemrograman asinkron diterapkan untuk mendukung proses komunikasi data, autentikasi, dan pengelolaan database.

### A. Future

Future merupakan mekanisme pemrograman asinkron yang digunakan untuk menangani proses yang menghasilkan satu nilai atau hasil penyelesaian.

Dalam aplikasi ini, Future digunakan pada proses seperti:

- Registrasi akun pengguna.
- Login pengguna.
- Pengambilan data REST API.
- Penyimpanan transaksi.
- Pengubahan dan penghapusan data transaksi.

### B. Stream

Stream merupakan mekanisme pemrograman asinkron yang digunakan untuk menerima rangkaian data atau perubahan secara berkelanjutan.

Dalam aplikasi ini, Stream dapat digunakan untuk memantau perubahan status autentikasi pengguna dan perubahan data transaksi pada Cloud Firestore.

## 10. Kesimpulan

Aplikasi Kas Kecil merupakan proyek Ujian Tengah Semester mata kuliah Pemrograman Multi Platform yang dikembangkan menggunakan framework Flutter dan bahasa pemrograman Dart.

Aplikasi ini dirancang untuk membantu pengguna dalam melakukan pencatatan dan pengelolaan transaksi pemasukan serta pengeluaran secara lebih terstruktur.

Dalam proses pengembangannya, proyek ini menerapkan berbagai materi perkuliahan, meliputi pemrograman asinkron menggunakan Future dan Stream, integrasi REST API menggunakan Dio, pengelolaan state menggunakan Provider/MultiProvider, serta Firebase Authentication dan Cloud Firestore untuk mendukung autentikasi dan pengelolaan data.

Melalui proyek ini, diharapkan pemahaman mengenai pengembangan aplikasi mobile multiplatform dapat diterapkan secara langsung dalam sebuah aplikasi yang memiliki fungsi dan kebutuhan nyata.

---

### Informasi Repository

*Nama Repository:* UTS_KAS-KECIL

*Link GitHub:* https://github.com/senn-komi/UTS_KAS-KECIL

*Nama Folder Project:* keuangan

*Mata Kuliah:* Pemrograman Multi Platform

*Tahun Akademik:* 2026/2027

*Dikembangkan oleh:*
- Zena Juniarti (2411500046)
- Zahro Safitri (2411500063)

Program Studi Teknologi Informasi  
Institut Sains dan Bisnis Atma Luhur Pangkalpinang