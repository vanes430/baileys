# 🔑 Custom Pairing Code Guide

Library ini mendukung penggunaan *custom pairing code* saat menghubungkan bot ke WhatsApp tanpa QR Code. Fitur ini memungkinkan Anda menentukan sendiri kode 8-karakter yang akan dimasukkan di aplikasi WhatsApp.

## ⚠️ Aturan Penting
* **Panjang Kode:** Wajib tepat **8 karakter**.
* **Karakter:** Harus berupa huruf (A-Z) atau angka (0-9).
* **Format:** Kode akan otomatis diubah menjadi huruf kapital (Uppercase).

---

## 🚀 Cara Penggunaan

Gunakan method `requestPairingCode` dengan menyertakan parameter kedua sebagai kode kustom Anda.

```javascript
// Contoh penggunaan di bot Anda
const phoneNumber = "628123456789";
const myCustomCode = "BOTWA001"; // Wajib 8 karakter

const code = await sock.requestPairingCode(phoneNumber, myCustomCode);
console.log(`Silakan masukkan kode ini di WhatsApp Anda: ${code}`);
```

### Flow Koneksi:
1. Pastikan `auth` bot Anda belum terhubung.
2. Jalankan fungsi `requestPairingCode` seperti contoh di atas.
3. Buka WhatsApp di HP Anda -> Perangkat Tertaut -> Tautkan Perangkat -> Tautkan dengan nomor telepon.
4. Masukkan kode `BOTWA001` tersebut.

---

## ❓ Mengapa Harus 8 Karakter?
WhatsApp secara sistem mengharuskan kode pemasangan (pairing code) memiliki panjang 8 karakter (format: `XXXX-XXXX`). Jika Anda memberikan kurang atau lebih dari 8 karakter, sistem WhatsApp tidak akan mengenali kode tersebut dan proses tautan akan gagal.
