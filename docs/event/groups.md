# 👥 Groups Events

Berikut adalah dokumentasi event terkait grup WhatsApp (pembuatan grup, pembaruan info grup, aksi anggota, dan permintaan bergabung) pada Baileys yang diambil langsung dari *source code* asli (`lib/Socket/groups.js` & `lib/Utils/process-message.js`).

---

## 1. `group-participants.update`
Event krusial yang dipicu ketika ada anggota yang bergabung, keluar, dikeluarkan, atau diubah status administrasinya di dalam grup.

### Payload Structure:
```typescript
interface GroupParticipantsUpdate {
  /** JID Grup tempat event terjadi (misal: 120363xxx@g.us) */
  id: string;
  
  /** Daftar JID anggota yang terpengaruh (nomor HP anggota) */
  participants: string[];
  
  /** Aksi yang terjadi:
   * - 'add': Anggota baru masuk/ditambahkan
   * - 'remove': Anggota keluar/dikeluarkan (kick)
   * - 'promote': Anggota diangkat menjadi admin grup
   * - 'demote': Anggota diturunkan dari jabatan admin grup
   */
  action: 'add' | 'remove' | 'promote' | 'demote';
}
```

### Contoh Penggunaan:
```javascript
sock.ev.on('group-participants.update', async (ev) => {
  const { id, participants, action } = ev;
  
  if (action === 'add') {
    await sock.sendMessage(id, { 
      text: `Selamat datang @${participants[0].split('@')[0]} di grup!` 
    });
  }
});
```

---

## 2. `groups.update`
Dipicu ketika detail pengaturan grup diubah oleh admin (seperti mengubah subjek/nama grup, mengganti deskripsi grup, mengubah setelan ikon/foto profil, atau pembatasan kirim pesan).

### Payload Structure:
```typescript
interface GroupUpdate {
  /** JID Grup */
  id: string;
  /** Subjek/Nama baru grup (jika diubah) */
  subject?: string;
  /** Deskripsi baru grup (jika diubah) */
  desc?: string;
  /** Pembatasan kirim pesan: 'announcement' (hanya admin) | 'not_announcement' (semua orang) */
  announce?: 'announcement' | 'not_announcement';
  /** Pembatasan edit setelan grup: 'locked' (hanya admin) | 'unlocked' (semua orang) */
  restrict?: 'locked' | 'unlocked';
}
```

---

## 3. `group.join-request`
Dipicu ketika ada seseorang yang meminta bergabung ke grup yang mengaktifkan fitur persetujuan admin (*Admin Approval Mode*).

### Payload Structure:
```typescript
interface GroupJoinRequest {
  /** JID Grup */
  id: string;
  /** Nomor JID pengguna yang meminta bergabung */
  participant: string;
  /** Aksi permintaan: 'add' (meminta masuk) | 'remove' (membatalkan permintaan) */
  action: 'add' | 'remove';
  /** Waktu pengajuan permintaan */
  timestamp: number;
}
```
