import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import '../shared/shared.dart';
import 'dokumen_controller.dart';

class TambahDokumenModal extends StatefulWidget {
  const TambahDokumenModal({super.key});

  @override
  State<TambahDokumenModal> createState() => _TambahDokumenModalState();
}

class _TambahDokumenModalState extends State<TambahDokumenModal> {
  final _formKey = GlobalKey<FormState>();
  final DokumenController controller = Get.find<DokumenController>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _babController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String? _fileName;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
        _titleController.text = result.files.single.name;
      });
    }
  }

  void _uploadDokumen() {
    if (_formKey.currentState!.validate()) {
      controller.addDokumen(
        DokumenModel(
          title: _titleController.text,
          bab: _babController.text,
          description: _descController.text,
          status: "Menunggu",
          fileName: _fileName ?? "Belum dipilih",
          date: DateTime.now().toString(),
          catatanDosen: "",
          fileRevisi: "",
        ),
      );
      Get.back();
      Get.snackbar(
        "Berhasil",
        "Dokumen berhasil diunggah",
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      minChildSize: 0.45,
      maxChildSize: 0.95,
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drag handle
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

                  const Center(
                    child: Text(
                      "Upload File Dokumen",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // File Picker
                  const Text("File Dokumen", style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.2),
                            border: Border.all(color: primaryColor.withOpacity(0.3)),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                          child: Text(
                            _fileName ?? 'Belum ada file dipilih',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _pickFile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                          ),
                          child: const Text("Pilih File", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  _buildFieldLabel("Nama Dokumen"),
                  _buildTextFormField(_titleController, "Masukkan nama dokumen"),

                  const SizedBox(height: 16),
                  _buildFieldLabel("BAB"),
                  _buildTextFormField(_babController, "Contoh: BAB I"),

                  const SizedBox(height: 16),
                  _buildFieldLabel("Keterangan"),
                  _buildTextFormField(_descController, "Opsional", maxLines: 2),

                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _uploadDokumen,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: dangerColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        "UPLOAD",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String hint, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: (v) => v!.isEmpty && maxLines == 1 ? "Field wajib diisi" : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: primaryColor.withOpacity(0.2),
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: primaryColor.withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: primaryColor.withOpacity(0.3))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: primaryColor, width: 1.5)),
      ),
    );
  }
}
