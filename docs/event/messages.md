# ✉️ Messages Events

Berikut adalah dokumentasi event terkait lalu lintas pesan, reaksi, dan tanda terima pada Baileys yang diambil langsung dari *source code* asli (`lib/Socket/messages-recv.js` & `lib/Utils/process-message.js`).

---

## 1. `messages.upsert`
Event utama yang dipicu ketika ada pesan baru yang masuk (diterima) atau keluar (dikirim dari bot/ponsel Anda).

### Payload Structure:
```typescript
interface MessagesUpsert {
  /** Array pesan yang masuk */
  messages: WAMessage[];
  /** Tipe pesan: 'notify' (pesan baru waktu nyata) | 'append' (riwayat sinkronisasi) */
  type: 'notify' | 'append';
}
```

### Contoh Penggunaan:
```javascript
sock.ev.on('messages.upsert', async (m) => {
  if (m.type === 'notify') {
    for (const msg of m.messages) {
      if (!msg.message) continue;
      console.log('Pesan baru dari:', msg.key.remoteJid, 'Isi:', msg.message.conversation);
    }
  }
});
```

---

## 2. `messages.update`
Dipicu ketika ada modifikasi status pada pesan yang sudah ada (misalnya status terkirim/terbaca berubah, pesan diedit, atau pesan ditarik kembali/deleted).

### Payload Structure:
```typescript
interface MessageUpdate {
  /** Kunci unik dari pesan yang diupdate */
  key: WAMessageKey;
  /** Properti pesan yang mengalami pembaruan */
  update: Partial<WAMessage>;
}
```

### Contoh Penggunaan:
```javascript
sock.ev.on('messages.update', (updates) => {
  for (const { key, update } of updates) {
    if (update.status) {
      console.log(`Pesan ID ${key.id} statusnya berubah menjadi:`, update.status); 
      // 2 = Sent (Centang 1), 3 = Delivered (Centang 2), 4 = Read (Centang Biru)
    }
  }
});
```

---

## 3. `messages.delete`
Dipicu ketika sebuah pesan dihapus secara permanen dari riwayat percakapan.

### Payload Structure:
```typescript
type MessageDelete = 
  | { keys: WAMessageKey[] } // Hapus beberapa pesan spesifik berdasarkan kunci
  | { jid: string, all: true }; // Hapus seluruh obrolan pada JID tertentu
```

---

## 4. `messages.reaction`
Dipicu ketika seseorang menambahkan atau memperbarui reaksi emoji pada suatu pesan.

### Payload Structure:
```typescript
interface MessageReaction {
  /** Kunci pesan asli yang direaksikan */
  key: WAMessageKey;
  /** Detail reaksi */
  reaction: {
    /** Teks emoji reaksi (misal: "👍", "❤️") atau kosong jika reaksi dihapus */
    text: string;
    /** Waktu reaksi diberikan */
    senderTimestampMs: number;
  };
  /** Pengirim reaksi */
  sender: string;
}
```

---

## 5. `message-receipt.update`
Dipicu saat tanda terima pesan (tanda dibaca, terkirim) dikirimkan oleh lawan bicara.

### Payload Structure:
```typescript
interface MessageReceiptUpdate {
  key: WAMessageKey;
  receipt: {
    userJid: string;
    readTimestamp?: number;
    deliveredTimestamp?: number;
  };
}
```
