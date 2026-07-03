# 📢 Baileys System Events Reference

Dokumentasi ini mencakup referensi lengkap seluruh event sistem yang tersedia pada library kustom Baileys Anda. Seluruh data ini diekstrak dari *source code* asli (`lib/Socket/` & `lib/Utils/`) untuk menjamin keakuratan tipe data dan payload.

Pilih kategori dokumentasi event di bawah ini:

| Kategori Event | Deskripsi | Link Berkas |
| :--- | :--- | :--- |
| 🔌 **Connection & Auth** | Event status koneksi WebSocket (`connection.update`) dan pembaruan kredensial (`creds.update`). | [Baca di Sini](./connection.md) |
| ✉️ **Messages & Reactions** | Event pesan baru (`messages.upsert`), edit/status pesan (`messages.update`), reaksi, dll. | [Baca di Sini](./messages.md) |
| 👥 **Groups & Participants** | Event perubahan anggota grup (`group-participants.update`), info grup, & permintaan gabung. | [Baca di Sini](./groups.md) |
| 💬 **Chats & Labels** | Event daftar obrolan (`chats.upsert`, `chats.update`) dan asosiasi Label Business. | [Baca di Sini](./chats.md) |
| ⚙️ **Misc & Others** | Event panggilan masuk (`call`), daftar blokir, kontak, dan pemetaan LID-PN (`lid-mapping.update`). | [Baca di Sini](./misc.md) |
