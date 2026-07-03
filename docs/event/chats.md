# 💬 Chats & Labels Events

Berikut adalah dokumentasi event terkait daftar obrolan (chats) dan pengelolaan label pada Baileys yang diambil langsung dari *source code* asli (`lib/Socket/chats.js` & `lib/Utils/chat-utils.js`).

---

## 1. `chats.upsert`
Dipicu ketika sebuah percakapan obrolan (chat) baru masuk ke dalam daftar chat utama untuk pertama kalinya.

### Payload Structure:
```typescript
interface ChatUpsert {
  /** JID Obrolan */
  id: string;
  /** Waktu aktivitas terakhir di dalam chat */
  conversationTimestamp?: number | Long;
  /** Jumlah pesan yang belum dibaca */
  unreadCount?: number;
  /** Menunjukkan jika chat sedang diarsipkan */
  archive?: boolean;
}
```

---

## 2. `chats.update`
Dipicu ketika ada perubahan pada status obrolan yang sudah terdaftar (misalnya: pesan ditandai telah dibaca, chat disematkan/pinned, status senyap/muted diaktifkan, atau chat diarsipkan).

### Payload Structure:
```typescript
interface ChatUpdate {
  /** JID Obrolan */
  id: string;
  /** Jumlah pesan belum dibaca yang diperbarui */
  unreadCount?: number;
  /** Status arsip: boolean */
  archive?: boolean;
  /** Waktu penyematan chat (jika dipin) */
  pin?: number;
  /** Waktu senyap (jika dimute) */
  mute?: number;
}
```

---

## 3. `chats.delete`
Dipicu ketika sebuah percakapan obrolan dihapus seluruhnya dari daftar obrolan WhatsApp.

### Payload Structure:
```typescript
type ChatDelete = string[]; // Array berisi daftar JID chat yang dihapus
```

---

## 4. `chats.lock`
Dipicu ketika sebuah obrolan dikunci (*locked*) atau dibuka kuncinya menggunakan fitur Kunci Chat (*Chat Lock*).

### Payload Structure:
```typescript
interface ChatLock {
  /** JID Obrolan */
  id: string;
  /** Status kunci */
  locked: boolean;
}
```

---

## 5. `labels.edit`
Dipicu ketika label WhatsApp Business dibuat, diedit nama/warnanya, atau dihapus.

### Payload Structure:
```typescript
interface LabelEdit {
  /** ID Label */
  id: string;
  /** Nama label baru */
  name?: string;
  /** ID warna label */
  colorId?: number;
  /** Menunjukkan aksi hapus */
  deleted?: boolean;
}
```

---

## 6. `labels.association`
Dipicu ketika sebuah label dikaitkan atau dilepas dari suatu chat atau pesan.

### Payload Structure:
```typescript
interface LabelAssociation {
  /** JID Chat yang diasosiasikan */
  chatId: string;
  /** ID Label */
  labelId: string;
  /** Aksi: 'add' (ditempelkan) | 'remove' (dilepas) */
  type: 'add' | 'remove';
  /** ID Pesan (jika label ditempelkan ke pesan spesifik, bukan ke chat) */
  messageId?: string;
}
```
