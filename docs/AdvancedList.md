# 📜 Advanced List with Bottom Sheet

Fitur ini memungkinkan pembuatan tampilan list yang lebih kompleks dengan dukungan banyak tombol select (`single_select`) dan kustomisasi judul list di bagian bawah (*Bottom Sheet*).

## 🚀 Implementasi
Gunakan struktur di bawah ini untuk mengirim pesan dengan banyak kategori list yang dapat dibuka secara bergantian.

```javascript
const interactiveMessage = {
  header: {
    title: "Ini judul",
    subtitle: "Ini subjudul",
    hasMediaAttachment: false
  },
  body: { text: "Ini body" },
  footer: { text: "Ini footer" },
  nativeFlowMessage: {
    buttons: [
      {
        name: "single_select",
        buttonParamsJson: JSON.stringify({
          title: "Judul#1",
          sections: [
            {
              title: "Kategori 1",
              rows: [
                { title: "Item 1", description: "Deskripsi", id: "id1" },
                { title: "Item 2", description: "Deskripsi", id: "id2" }
              ]
            }
          ],
          has_multiple_buttons: true
        })
      },
      {
        name: "single_select",
        buttonParamsJson: JSON.stringify({
          title: "Judul#2",
          sections: [
            {
              title: "Kategori 2",
              rows: [
                { title: "Item 3", description: "Deskripsi", id: "id3" }
              ]
            }
          ],
          has_multiple_buttons: true
        })
      },
      {
        name: "quick_reply",
        buttonParamsJson: JSON.stringify({
          display_text: "Tutup",
          id: "close"
        })
      }
    ],
    messageParamsJson: JSON.stringify({
      bottom_sheet: {
        in_thread_buttons_limit: 1,
        divider_indices: [1, 2],
        list_title: "Daftar Opsi",
        button_title: "Buka Menu"
      }
    })
  }
};
```

## ⚙️ Penjelasan Properti `bottom_sheet`

| Properti | Deskripsi |
| :--- | :--- |
| `in_thread_buttons_limit` | Jumlah tombol yang muncul langsung di chat sebelum "Buka Menu" diklik. |
| `divider_indices` | Indeks tombol mana yang akan diberikan garis pembagi (*separator*). |
| `list_title` | Judul yang muncul di atas list saat *bottom sheet* terbuka. |
| `button_title` | Teks pada tombol utama untuk membuka list. |

---
*Kembali ke [Tutorial Utama](./Interactive.md)*
