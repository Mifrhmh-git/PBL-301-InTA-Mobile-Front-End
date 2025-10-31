import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dokumen_controller.dart';
import '../shared/shared.dart';

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

  Color _getStatusBgColor(String status) {
    switch (status.toLowerCase()) {
      case "menunggu":
        return const Color(0xFFFFEAC1);
      case "revisi":
        return const Color(0xFFFFCACA);
      case "disetujui":
      case "selesai":
        return const Color(0xFFD6F5D6);
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

  void _showCatatanDosenModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.45,
          maxChildSize: 0.9,
          minChildSize: 0.3,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Icon(Icons.horizontal_rule,
                          color: Colors.grey, size: 40),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Catatan Dosen",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      dokumen.catatanDosen?.isNotEmpty == true
                          ? dokumen.catatanDosen!
                          : "Tidak ada catatan dari dosen.",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 🔵 UBAHAN: Garis pemisah warna primaryColor
                    Divider(
                      thickness: 1.5,
                      color: primaryColor,
                    ),

                    const SizedBox(height: 10),
                    const Text(
                      "File Revisi dari Dosen",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    dokumen.fileRevisi != null
                        ? InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Membuka file revisi..."),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.insert_drive_file,
                                      color: Colors.blue, size: 22),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      dokumen.fileRevisi!,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Icon(Icons.download,
                                      color: Colors.black54, size: 20),
                                ],
                              ),
                            ),
                          )
                        : const Text(
                            "Tidak ada file revisi yang dikirim.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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

    return GestureDetector(
      onTap: () {
        if (dokumen.status.toLowerCase() == "revisi") {
          _showCatatanDosenModal(context);
        }
      },
      child: Container(
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
                  const Icon(Icons.access_time,
                      size: 15, color: Colors.black54),
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

              const SizedBox(height: 10),

              // 🔵 UBAHAN: Garis antara keterangan & tombol pakai primaryColor
              Container(height: 2, color: primaryColor),
              const SizedBox(height: 4),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: onDownload,
                    icon: const Icon(Icons.download,
                        color: Colors.black87, size: 20),
                    tooltip: "Download",
                  ),
                  IconButton(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit,
                        color: Colors.black87, size: 20),
                    tooltip: "Edit",
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete,
                        color: Colors.black87, size: 20),
                    tooltip: "Hapus",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
