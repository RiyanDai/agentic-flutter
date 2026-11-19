# 🚀 Flutter Intermediate Architecture Skill for AI Agents

Repositori ini adalah **Agent Skill** universal yang membekali AI Coding Agent (Antigravity, Claude Code, Cursor, GitHub Copilot, Gemini CLI) dengan pengetahuan dan standar arsitektur tingkat lanjut dari **8 Modul Flutter Intermediate**.

Skill ini **tidak terbatas hanya untuk Story App**, melainkan dapat digunakan oleh AI Agent untuk merancang dan membangun **aplikasi Flutter baru apa pun** dari nol (*e-commerce, news app, social media, dashboard, delivery app, dll.*).

---

## 🗂️ 8 Modul Arsitektur yang Dikuasai Agent

1. **Declarative Navigation (Navigator 2.0)**:
   - Rute deklaratif murni berbasis state menggunakan `RouterDelegate` dan `PageConfiguration`.
   - Pola modal dialog deklaratif via `DialogPage<T> extends Page<T>` (tanpa imperative pop/push).
   - Penanganan tombol back fisik di `popRoute()` tanpa keluar aplikasi.
   - Clean Web URL tanpa tanda pagar (`#`) via `usePathUrlStrategy()`.
2. **Media, Camera, Kompresi Dinamis & Multipart Upload**:
   - Pengambilan gambar via kamera dan galeri dengan `image_picker`.
   - Algoritma kompresi otomatis dinamis menggunakan package `image` untuk menjamin payload `< 1MB`.
   - Pengiriman file multipart HTTP aman dengan header Bearer Token.
   - Deklarasi izin internet di `AndroidManifest.xml` release.
3. **Localization (L10n) & Accessibility (A11y)**:
   - Multi-bahasa standar `l10n.yaml` dan kamus format ARB.
   - Persistensi bahasa pengguna menggunakan `SharedPreferences`.
   - Kepatuhan aksesibilitas screen reader menggunakan widget `Semantics`.
4. **Multiplatform Responsive UI & State Management**:
   - Tata letak responsif untuk Mobile, Tablet, Web, dan Desktop (Fluent, macOS, Yaru).
   - Penanganan 4 kondisi data eksplisit via enum `ResultState` (loading, error + retry, empty, hasData).
   - Desain modern Material 3 (`useMaterial3: true`).
5. **Advanced Widgets & Custom Animations**:
   - Transisi gambar mulus antar halaman dengan widget `Hero`.
   - Transisi dialog berbasis kurva pegas `Curves.easeOutBack` (`ScaleTransition` & `FadeTransition`).
6. **Safe Data Modeling & Code Generation**:
   - Model data immutable dengan parsing JSON null-safe yang kebal terhadap type-casting error.
7. **Location Services & Google Maps**:
   - Integrasi `google_maps_flutter` dengan penanganan koordinat null yang aman.
   - Penanda lokasi (*Marker*), InfoWindow, dan location picker.
8. **Build Variants & Product Flavors**:
   - Konfigurasi `productFlavors` multi-tier di Android (`build.gradle.kts`) dan iOS.
   - File entrypoint terpisah (`main_dev.dart`, `main_prod.dart`, `main_free.dart`, `main_paid.dart`).
   - Deteksi flavor aktif pada saat runtime via `package_info_plus`.

---

## 💻 Cara Memasang Skill Ini ke AI Coding Agent

### Opsi 1: Pasang di Google Antigravity / Gemini CLI
Salin folder `flutter-intermediate-expert-skill` ini ke direktori skill lokal Anda:
- **Windows:** `C:\Users\<Username>\.gemini\config\skills\flutter-intermediate-expert\`
- **Linux/macOS:** `~/.gemini/config/skills/flutter-intermediate-expert/`

### Opsi 2: Pasang di Cursor / Claude Code / Copilot
Salin berkas `SKILL.md` ke folder `.cursor/rules/` atau `.claude/skills/` pada proyek Flutter Anda.

### Opsi 3: Publish ke GitHub
Unggah folder ini ke repositori GitHub Anda. Anda dapat langsung mengimpor atau mereferensikannya sebagai custom skill di berbagai AI assistant.

---

## 🎯 Contoh Perintah untuk AI Agent di Proyek Baru

Setelah skill ini terpasang, Anda cukup memberikan instruksi kepada AI Agent di proyek Flutter baru Anda:

> *"Gunakan skill `flutter-intermediate-expert` untuk membangun aplikasi E-Commerce Flutter baru dari awal. Terapkan navigasi deklaratif Navigator 2.0, multi-bahasa ID/EN, penanganan state ResultState, dan tema Material 3."*

AI Agent akan otomatis mengikuti seluruh aturan guardrails, pola arsitektur, dan standar kode profesional yang didefinisikan di dalam `SKILL.md`.

"# agentic-flutter" 
