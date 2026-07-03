# 🔌 Connection Events

Berikut adalah dokumentasi event terkait status koneksi dan kredensial autentikasi pada Baileys yang diambil langsung dari *source code* asli (`lib/Socket/socket.js`).

---

## 1. `connection.update`
Event ini dipicu setiap kali status koneksi WebSocket antara bot dan server WhatsApp mengalami perubahan.

### Payload Structure:
```typescript
interface ConnectionState {
  /** Status koneksi: 'connecting' | 'open' | 'close' */
  connection?: 'connecting' | 'open' | 'close';
  
  /** Detail error dan alasan jika koneksi terputus (close) */
  lastDisconnect?: {
    error: Error | Boom;
    date: Date;
  };
  
  /** Kode QR string (jika login menggunakan metode QR Code) */
  qr?: string;
  
  /** Menunjukkan jika ini adalah login sesi baru pertama kali */
  isNewLogin?: boolean;
  
  /** Menunjukkan status penerimaan notifikasi pending dari server */
  receivedPendingNotifications?: boolean;
}
```

### Contoh Penggunaan:
```javascript
sock.ev.on('connection.update', (update) => {
  const { connection, lastDisconnect, qr } = update;
  
  if (qr) {
    console.log('QR Code Baru Diterima, silakan scan!');
  }
  
  if (connection === 'connecting') {
    console.log('Sedang menghubungkan ke server WhatsApp...');
  }
  
  if (connection === 'open') {
    console.log('Bot berhasil terhubung dan siap digunakan!');
  }
  
  if (connection === 'close') {
    console.log('Koneksi terputus karena:', lastDisconnect?.error);
  }
});
```

---

## 2. `creds.update`
Event ini dipicu ketika ada pembaruan kredensial internal (misalnya: kunci noise baru, kunci pre-key baru, atau informasi identitas diri). Data ini harus segera disimpan ke database/file agar sesi bot tidak keluar.

### Payload Structure:
```typescript
// Mengembalikan objek kredensial lengkap (AuthenticationCreds)
interface AuthenticationCreds {
  noiseKey: KeyPair;
  signedIdentityKey: KeyPair;
  signedPreKey: SignedPreKey;
  registrationId: number;
  advSecretKey: string;
  me?: Contact;
  // ... properti kredensial lainnya
}
```

### Contoh Penggunaan:
```javascript
// Disimpan menggunakan helper SQLite / MultiFile bawaan
sock.ev.on('creds.update', saveCreds);
```
