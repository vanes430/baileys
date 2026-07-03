# 🔄 Dynamic WAProto Auto-Update & GitHub Actions

Fitur ini memungkinkan repositori Baileys Anda untuk melakukan pelacakan, pengunduhan, dan pengompilasi skema Protocol Buffers (`WAProto.proto`) terbaru secara langsung dari server resmi WhatsApp Web.

Dengan fitur ini, Anda tidak perlu lagi menunggu update manual dari repositori utama saat WhatsApp memperbarui protokol komunikasinya.

---

## 🚀 Perintah CLI Lokal

Anda dapat mengelola skema proto secara lokal di dalam folder proyek Anda menggunakan perintah-perintah berikut:

### 1. Ekstraksi dan Kompilasi (Otomatis)
Menjalankan script analisis kode sumber WhatsApp Web, memperbarui `WAProto.proto`, dan mengompilasi modul JS/TS dalam sekali jalan:
```bash
bun run update-proto
```

### 2. Kompilasi Ulang Saja
Jika Anda melakukan perubahan manual pada file [WAProto.proto](file:///c:/Users/ACER/Desktop/workspace/baileys/WAProto/WAProto.proto), Anda bisa mengompilasi ulang tanpa melakukan fetching ulang:
```bash
bun run compile-proto
```

---

## 🤖 GitHub Actions Workflow

Sistem pembaruan otomatis ini juga telah dilengkapi dengan GitHub Action yang berjalan secara otomatis:
* **Jadwal Rutin**: Setiap hari Minggu pukul 00:00 UTC.
* **Setiap Perubahan**: Berjalan pada setiap push atau pull request ke branch `main`.

### Cara Kerja Workflow:
1. Memeriksa file JavaScript bootstrap terbaru di WhatsApp Web.
2. Mengekstrak skema proto menggunakan parser `acorn` AST.
3. Mengompilasi ulang berkas JavaScript statis dan TypeScript definition.
4. **Auto-commit & Push**: Jika terdeteksi adanya perubahan versi WhatsApp Web baru, bot GitHub Actions secara otomatis melakukan commit dan push kembali ke repositori Anda.

> 💡 **PENTING**: Agar GitHub Actions dapat melakukan push otomatis, pastikan Anda telah memberikan izin tulis pada repositori Anda di GitHub:
> `Settings` -> `Actions` -> `General` -> `Workflow permissions` -> Pilih **Read and write permissions**.

---

## 🛠️ Cara Kerja di Balik Layar

Mekanisme ekstraksi menggunakan script [extract.js](file:///c:/Users/ACER/Desktop/workspace/baileys/WAProto/extract.js) yang bekerja dengan langkah berikut:
1. Mengambil berkas Service Worker WhatsApp Web (`/sw.js`) untuk mendeteksi `client_revision` versi terbaru.
2. Mengunduh berkas JS bootstrap WhatsApp Web yang di-minify.
3. Mem-parsing kode JavaScript tersebut menjadi **Abstract Syntax Tree (AST)** menggunakan library `acorn`.
4. Menelusuri AST menggunakan `acorn-walk` untuk menemukan modul objek `internalSpec` WhatsApp Web.
5. Menyusun ulang informasi field dan tipe data tersebut kembali menjadi skema `.proto` yang valid.
6. Mengonversi tipe `required` bawaan JavaScript WhatsApp Web ke `optional` agar kompatibel dengan standar compile `proto3` pada `protobufjs` versi 8+.
