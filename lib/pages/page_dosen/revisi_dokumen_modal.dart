import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:inta301/shared/shared.dart';

class RevisiDokumenModal extends StatefulWidget {
  final String judulDokumen;
  final Function(String newStatus)? onSave;

  const RevisiDokumenModal({
    super.key,
    required this.judulDokumen,
    this.onSave,
  });

  @override
  State<RevisiDokumenModal> createState() => _RevisiDokumenModalState();
}

class _RevisiDokumenModalState extends State<RevisiDokumenModal> {
  final TextEditingController catatanController = TextEditingController();
  String? uploadedFileName;

  String selectedStatus = "Revisi";

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        uploadedFileName = result.files.single.name;
      });
    }
  }

  void saveRevisi() {
    if (widget.onSave != null) widget.onSave!(selectedStatus);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.45,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                Center(
                  child: Text(
                    "Revisi: ${widget.judulDokumen}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // =================== DROPDOWN STATUS ==================
               const Text("Ubah Status",
    style: TextStyle(fontWeight: FontWeight.w600)),
SizedBox(height: 8),

Container(
  height: 50,
  padding: const EdgeInsets.symmetric(horizontal: 14),
  decoration: BoxDecoration(
    color: primaryColor.withOpacity(0.1),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: primaryColor.withOpacity(0.3)),
  ),

  // 👉 Tambahkan ini agar dropdown mengikuti tinggi Container
  child: Row(
    children: [
      Expanded(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,       // ⬅️ WAJIB
            alignment: Alignment.centerLeft,  // ⬅️ Biar sejajar
            value: selectedStatus,
            borderRadius: BorderRadius.circular(16),
            items: const [
              DropdownMenuItem(value: "Revisi", child: Text("Revisi")),
              DropdownMenuItem(value: "Disetujui", child: Text("Disetujui")),
            ],
            onChanged: (value) {
              setState(() => selectedStatus = value!);
            },
          ),
        ),
      ),
    ],
  ),
),


                const SizedBox(height: 20),

                // =================== CATATAN DOSEN ==================
                const Text("Catatan Dosen",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),

                Container(
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: primaryColor.withOpacity(0.3)),
                  ),
                  child: TextField(
                    controller: catatanController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                      border: InputBorder.none,
                      hintText: "Tulis catatan revisi di sini...",
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // =================== FILE REVISI ==================
                const Text("File Revisi",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          border: Border.all(
                              color: primaryColor.withOpacity(0.3)),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                        ),
                        child: Text(
                          uploadedFileName ?? 'Belum ada file dipilih',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: pickFile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                        ),
                        child: const Text(
                          "UPLOAD",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // =================== TOMBOL SIMPAN ==================
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: saveRevisi,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: dangerColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "SIMPAN",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
