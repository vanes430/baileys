# ⚙️ Miscellaneous Events

Berikut adalah dokumentasi event serbaguna lainnya (seperti panggilan suara/video, daftar blokir, kontak, pengaturan aplikasi, riwayat chat pertama kali, dan mapping LID-PN) pada Baileys yang diambil langsung dari *source code* asli (`lib/Socket/messages-recv.js` & `lib/Utils/chat-utils.js`).

---

## 1. `call`
Dipicu ketika ada panggilan suara (*voice call*) atau panggilan video (*video call*) masuk ke akun bot Anda.

### Payload Structure:
```typescript
interface CallEvent {
  /** ID Panggilan unik */
  id: string;
  /** JID pemanggil (nomor WhatsApp) */
  from: string;
  /** Waktu panggilan dimulai */
  timestamp: number;
  /** Menunjukkan jika panggilan berupa video: boolean */
  isVideo: boolean;
  /** Status panggilan: 'offer' (berdering) | 'accept' | 'reject' | 'timeout' */
  status: 'offer' | 'accept' | 'reject' | 'timeout';
}
```

---

## 2. `blocklist.update`
Dipicu ketika ada perubahan pada daftar kontak yang diblokir oleh bot Anda.

### Payload Structure:
```typescript
interface BlocklistUpdate {
  /** Daftar nomor JID kontak yang diblokir/dibuka kuncinya */
  blocklist: string[];
  /** Tipe aksi: 'add' (diblokir baru) | 'remove' (dibuka blokirnya) */
  type: 'add' | 'remove';
}
```

---

## 3. `contacts.upsert` & `contacts.update`
* **`contacts.upsert`**: Dipicu ketika kontak-kontak baru disinkronisasikan dari server WhatsApp Web ke bot Anda pertama kali.
* **`contacts.update`**: Dipicu ketika properti kontak yang sudah ada diperbarui (misalnya pushName berubah, status profil diperbarui, atau foto profil diubah).

### Payload Structure:
```typescript
interface Contact {
  /** JID Kontak */
  id: string;
  /** Nama tampilan WhatsApp yang diatur oleh kontak tersebut */
  notify?: string;
  /** Nama kontak yang Anda simpan di buku telepon (jika disinkronisasikan) */
  name?: string;
  /** Status bio kontak */
  status?: string;
  /** URL foto profil */
  imgUrl?: string;
}
```

---

## 4. `settings.update`
Dipicu saat pengaturan global akun diubah melalui perangkat seluler utama (seperti perubahan bahasa/locale atau privasi status).

### Payload Structure:
```typescript
type SettingsUpdate =
  | { setting: 'locale', value: string }
  | { setting: 'timeFormat', value: string }
  | { setting: 'statusPrivacy', value: any };
```

---

## 5. `lid-mapping.update`
Event khusus dan eksklusif untuk melacak pemetaan internal antara ID Linked Identifier (**LID**) WhatsApp baru dengan nomor telepon asli (**PN JID**).

### Payload Structure:
```typescript
interface LidMappingUpdate {
  /** Linked Identifier ID (misal: 22927xxxx@lid) */
  lid: string;
  /** Phone Number JID (misal: 6281xxxx@s.whatsapp.net) */
  pn: string;
}
```

---

## 6. `messaging-history.set`
Dipicu hanya sekali pada saat awal bot login untuk mengirimkan riwayat percakapan lama, obrolan, dan kontak secara massal untuk mengisi database lokal Anda.

### Payload Structure:
```typescript
interface MessagingHistorySet {
  chats: Chat[];
  messages: WAMessage[];
  contacts: Contact[];
  isLatest: boolean;
}
```
