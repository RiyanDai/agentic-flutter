---
name: flutter-intermediate-expert
description: Universal Flutter Intermediate architectural agent skill. Equips AI agents to build any Flutter application from scratch using enterprise-grade patterns from Modules 1-8 (Navigator 2.0 Declarative Routing, Media & Dynamic Compression, Localization & Accessibility, Multiplatform Responsive UI, Custom Animations & Advanced Widgets, Safe Code Generation, Google Maps & Location, and Build Variants / Product Flavors).
---

# 🚀 Flutter Intermediate Universal Architecture Skill

Skill ini adalah cetak biru arsitektur tingkat lanjut (*advanced architecture blueprint*) universal untuk AI Coding Agent. Skill ini membekali agent agar mampu merancang, membangun, dan menyusun struktur kode untuk **aplikasi Flutter baru apa pun** (e-commerce, media sosial, produktivitas, dashboard, marketplace, dll.) menggunakan standar arsitektur profesional yang dipelajari dari **8 Modul Flutter Intermediate**.

---

## 🏛️ Arsitektur Inti: 8 Pilar Fondasi Flutter Enterprise

Setiap kali agent membangun atau mengembangkan fitur pada aplikasi Flutter baru, agent wajib mengacu pada 8 pilar materi berikut:

```
┌────────────────────────────────────────────────────────────────────────┐
│                   UNIVERSAL FLUTTER INTERMEDIATE STACK                 │
├────────────────────────────────┬───────────────────────────────────────┤
│ 1. Advanced Navigation         │ Navigator 2.0, RouterDelegate,        │
│    (Declarative Routing)       │ DialogPage, Deep Linking, Web URL     │
├────────────────────────────────┼───────────────────────────────────────┤
│ 2. Media & Upload              │ Camera, ImagePicker, Compression <1MB,│
│                                │ MultipartRequest, Audio/Video         │
├────────────────────────────────┼───────────────────────────────────────┤
│ 3. Localization & Accessibility│ l10n.yaml, ARB (Multi-language),      │
│                                │ Persistent Locale, Semantics (A11y)   │
├────────────────────────────────┼───────────────────────────────────────┤
│ 4. Multiplatform Responsive UI │ Mobile, Web, Desktop (Fluent, macOS,  │
│                                │ Yaru), Adaptive Layout, Material 3    │
├────────────────────────────────┼───────────────────────────────────────┤
│ 5. Advanced Widgets & Motion   │ Hero, Curves Transitions, Custom-     │
│                                │ Painter, AnimatedList, Canvas         │
├────────────────────────────────┼───────────────────────────────────────┤
│ 6. Safe Data & Code Generation │ Immutability, fromJson/toJson, Null-  │
│                                │ Safety, Freezed / json_serializable   │
├────────────────────────────────┼───────────────────────────────────────┤
│ 7. Location & Google Maps      │ GoogleMap widget, Markers, Camera,    │
│                                │ Location Picker, LatLng Null-handling │
├────────────────────────────────┼───────────────────────────────────────┤
│ 8. Build Variants & Flavors    │ productFlavors (dev/prod/free/paid),  │
│                                │ flavorDimensions, Entrypoints, Config │
└────────────────────────────────┴───────────────────────────────────────┘
```

---

## 📐 Standar Implementasi per Modul

### 1️⃣ Modul 1: Declarative Navigation (Navigator 2.0 / Router API)
- **Larangan:** Jangan gunakan navigasi imperatif (`Navigator.push`, `Navigator.pop`, `showDialog`, `showGeneralDialog`) untuk alur navigasi inti dan dialog aplikasi.
- **Pola Rute:**
  1. `PageConfiguration`: Hierarki rute menggunakan *sealed class* atau *abstract class*.
  2. `RouterDelegate`: Mengelola stack `Navigator.pages` murni dari kondisi *state* (auth, screen selection, dialog visibility).
  3. **Dialog Declarative Pattern:**
     Untuk menampilkan modal dialog atau konfirmasi, deklarasikan kelas kustom `DialogPage<T> extends Page<T>`:
     ```dart
     class DialogPage<T> extends Page<T> {
       final Widget child;
       const DialogPage({required this.child, super.key, super.name});

       @override
       Route<T> createRoute(BuildContext context) {
         return RawDialogRoute<T>(
           settings: this,
           barrierDismissible: true,
           barrierColor: Colors.black54,
           pageBuilder: (context, anim1, anim2) => child,
           transitionBuilder: (context, anim1, anim2, child) {
             return ScaleTransition(
               scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
               child: FadeTransition(opacity: anim1, child: child),
             );
           },
         );
       }
     }
     ```
  4. **Back Button Interception:** Tangani event back tombol fisik pada `popRoute()` dan `onDidRemovePage` di `RouterDelegate` agar dialog atau halaman anak tertutup via perubahan state (`state = false`) tanpa mengeluarkan aplikasi secara tiba-tiba.
  5. **Clean Web URL:** Selalu panggil `usePathUrlStrategy()` di fungsi `main()` untuk membuang tanda `#` pada URL web.

---

### 2️⃣ Modul 2: Media, Camera, Kompresi & Multipart Upload
- **Pengambilan Gambar:** Gunakan `image_picker` untuk input dari `ImageSource.camera` dan `ImageSource.gallery`.
- **Algoritma Kompresi Dinamis (< 1 MB):**
  Untuk mencegah request jaringan gagal akibat payload terlalu besar:
  ```dart
  import 'dart:typed_data';
  import 'package:image/image.dart' as img;

  Future<Uint8List> compressImageBytes(Uint8List bytes, {int maxBytes = 1000000}) async {
    if (bytes.lengthInBytes <= maxBytes) return bytes;
    final image = img.decodeImage(bytes);
    if (image == null) return bytes;

    int quality = 90;
    Uint8List output = bytes;
    while (output.lengthInBytes > maxBytes && quality > 15) {
      output = Uint8List.fromList(img.encodeJpg(image, quality: quality));
      quality -= 10;
    }
    return output;
  }
  ```
- **Multipart Upload:** Gunakan `http.MultipartRequest` dengan field teks, token autentikasi pada headers, dan file binary `http.MultipartFile.fromBytes`.
- **Izin Jaringan:** Selalu deklarasikan `<uses-permission android:name="android.permission.INTERNET"/>` di `android/app/src/main/AndroidManifest.xml`.

---

### 3️⃣ Modul 3: Localization (L10n) & Accessibility (Semantics)
- **Multi-Bahasa Standar:**
  Gunakan konfigurasi `l10n.yaml` dengan kamus ARB (misal: `app_en.arb` dan `app_id.arb`).
- **Persistensi Bahasa:**
  Buat `LocalizationProvider` yang menyimpan preferensi bahasa pengguna (`Locale`) ke `SharedPreferences` agar pilihan bahasa tidak reset saat aplikasi ditutup.
- **Aksesibilitas (Screen Reader):**
  Bungkus setiap elemen yang interaktif atau berupa ikon murni (`IconButton`, `FloatingActionButton`, kartu yang bisa diklik) dengan widget `Semantics`:
  ```dart
  Semantics(
    label: 'Ganti Bahasa Aplikasi',
    button: true,
    child: IconButton(icon: Icon(Icons.language), onPressed: ...),
  )
  ```

---

### 4️⃣ Modul 4: Multiplatform Responsive UI & Adaptive Layout
- **Responsivitas:** Gunakan `LayoutBuilder` atau batasan `BoxConstraints(maxWidth: 720 / 1080)` untuk membatasi lebar tampilan saat aplikasi dibuka di tablet, browser, atau desktop.
- **Tema Desain:** Terapkan standar Material 3 (`useMaterial3: true`) dengan palet warna terpusat dan tipografi rapi (misal: Google Fonts).
- **Penanganan State UI Eksplisit:**
  Gunakan enum state terstandarisasi untuk setiap panggilan API:
  `enum ResultState { initial, loading, hasData, noData, error }`.
  Sediakan widget visual terpisah untuk masing-masing kondisi:
  - `LoadingWidget` (indikator loading di tengah)
  - `ErrorWidget` (pesan kesalahan ramah pengguna + tombol aksi coba lagi)
  - `EmptyWidget` (ilustrasi/pesan ketika data kosong)
  - `HasDataWidget` (tampilan data list/grid)

---

### 5️⃣ Modul 5: Advanced Widgets, Custom Animations & Transitions
- **Hero Transitions:** Selalu sematkan `Hero(tag: uniqueId, child: ...)` pada elemen visual (seperti thumbnail gambar produk, avatar profil, foto postingan) yang berpindah dari list ke halaman detail.
- **Kurva Gerakan Halus:** Gunakan kurva animasi alami seperti `Curves.easeOutBack`, `Curves.easeInOutCubic`, atau `Curves.fastOutSlowIn` untuk transisi halaman dan dialog.
- **Custom Feedback:** Gunakan floating banner notifikasi kustom yang memiliki animasi slide-in & fade-in untuk feedback aksi sukses/gagal.

---

### 6️⃣ Modul 6: Safe Data Modeling & Code Generation
- **Immutability:** Seluruh model data wajib berstatus `immutable` (`@immutable`) dengan properti `final`.
- **Null-Safety Toleran:** Parsing JSON tidak boleh berasumsi data API selalu lengkap. Sediakan fallback default:
  ```dart
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Tanpa Nama',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }
  ```

---

### 7️⃣ Modul 7: Location Services & Google Maps Integration
- **Display Peta Kondisional:** Widget peta (`GoogleMap`) hanya boleh dirender jika koordinat (`lat`, `lon`) bernilai valid dan tidak null.
- **Marker & InfoWindow:** Tempatkan `Marker` dengan `MarkerId` unik dan `InfoWindow` deskriptif di atas peta.
- **Location Picker:** Sediakan antarmuka pemilihan titik lokasi di mana pengguna dapat menggeser pin peta atau memilih koordinat untuk disimpan.

---

### 8️⃣ Modul 8: Build Variants / Product Flavors
- **Konfigurasi Gradle Android (`build.gradle.kts`):**
  ```kotlin
  flavorDimensions += "environment"
  productFlavors {
      create("dev") {
          dimension = "environment"
          applicationIdSuffix = ".dev"
          resValue("string", "app_name", "App Dev")
      }
      create("prod") {
          dimension = "environment"
          resValue("string", "app_name", "App")
      }
  }
  ```
- **Entrypoints Terpisah:**
  Buat file entrypoint independen untuk membedakan konfigurasi environment:
  - `lib/main_dev.dart` (mengarah ke Base URL server development/staging)
  - `lib/main_prod.dart` (mengarah ke Base URL server production)
- **Deteksi Runtime:** Gunakan `package_info_plus` atau kelas singleton `AppConfig` untuk membaca konfigurasi flavor yang sedang aktif.

---

## 🛠️ Panduan Eksekusi AI Agent Saat Membangun Aplikasi Baru

Ketika user meminta Anda membangun aplikasi Flutter baru dari awal:
1. **Analisis Kebutuhan:** Tentukan fitur apa saja dari 8 pilar di atas yang relevan dengan domain aplikasi user.
2. **Setup Fondasi:** Inisialisasi dependensi, permission di AndroidManifest, L10n, dan theme tokens.
3. **Bangun Data Layer:** Buat model immutable null-safe, client API dengan timeout, dan SharedPreferences wrapper.
4. **Bangun State Management:** Buat Provider dengan pola `ResultState`.
5. **Rakit Navigator 2.0:** Buat `PageConfiguration`, `StoryRouterDelegate`, `DialogPage`, dan `usePathUrlStrategy()`.
6. **Implementasikan UI Responsif:** Terapkan Material 3, layout responsif, dan state widget handling.
7. **Integrasikan Media / Maps / Flavors:** Jika aplikasi membutuhkan upload media, terapkan kompresi dinamis `< 1MB`. Jika membutuhkan peta atau multi-environment, terapkan pola Modul 7 & 8.
8. **Audit Mutu:** Pastikan kode lolos analisis statis dengan 0 error dan 0 warning.

