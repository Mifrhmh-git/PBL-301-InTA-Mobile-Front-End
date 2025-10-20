import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dokumen_controller.dart';

class DokumenCard extends StatelessWidget {
  final DokumenModel dokumen;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onAdd;
  final VoidCallback onDownload;

  const DokumenCard({
    super.key,
    required this.dokumen,
    required this.onDelete,
    required this.onEdit,
    required this.onAdd,
    required this.onDownload,
  });

  // --- warna badge status ---
  Color _getStatusBgColor(String status) {
    switch (status.toLowerCase()) {
      case "menunggu":
        return const Color(0xFFFFEAC1); // kuning lembut
      case "revisi":
        return const Color(0xFFFFCACA); // merah lembut
      case "disetujui":
      case "selesai":
        return const Color(0xFFD6F5D6); // hijau lembut
      default:
        return Colors.grey.shade200;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case "menunggu":
        return const Color(0xFFB57B00);
      case "revisi":
        return const Color(0xFFB00020);
      case "disetujui":
      case "selesai":
        return const Color(0xFF1B5E20);
      default:
        return Colors.black54;
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate;
    try {
      formattedDate = DateFormat("d MMMM yyyy, HH.mm", 'id_ID')
          .format(DateTime.parse(dokumen.date));
    } catch (e) {
      formattedDate = dokumen.date;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Judul + status ===
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    dokumen.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.black,
                      height: 1.3,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusBgColor(dokumen.status),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    dokumen.status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _getStatusTextColor(dokumen.status),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // === tanggal dan jam ===
            Row(
              children: [
                const Icon(Icons.access_time, size: 15, color: Colors.black54),
                const SizedBox(width: 6),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // === Keterangan ===
            Text(
              "Keterangan : ${dokumen.description}",
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 12),

            // === Tombol aksi ===
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 4),
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, color: Colors.black87, size: 20),
                  tooltip: "Edit",
                ),
                IconButton(
                  onPressed: onDownload,
                  icon:
                      const Icon(Icons.download, color: Colors.black87, size: 20),
                  tooltip: "Download",
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete, color: Colors.black87, size: 20),
                  tooltip: "Hapus",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
