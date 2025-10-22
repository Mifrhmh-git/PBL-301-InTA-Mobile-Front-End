import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'dokumen_controller.dart';
import '../shared/shared.dart';

class DokumenModal extends StatefulWidget {
  final DokumenModel? dokumen;
  final bool isEdit;

  const DokumenModal({super.key, this.dokumen, this.isEdit = false});

  @override
  State<DokumenModal> createState() => _DokumenModalState();
}

class _DokumenModalState extends State<DokumenModal> {
  final _formKey = GlobalKey<FormState>();
  final DokumenController controller = Get.find();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _babController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String? _fileName;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.dokumen != null) {
      _titleController.text = widget.dokumen!.title;
      _babController.text = widget.dokumen!.bab;
      _descController.text = widget.dokumen!.description;
      _fileName = widget.dokumen!.fileName;
    }
  }

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

  void _saveDokumen() {
    if (_formKey.currentState!.validate()) {
      if (widget.isEdit && widget.dokumen != null) {
        controller.editDokumen(
          0,
          DokumenModel(
            title: _titleController.text,
            bab: _babController.text,
            description: _descController.text,
            status: widget.dokumen!.status,
            fileName: _fileName ?? widget.dokumen!.fileName,
            date: widget.dokumen!.date,
          ),
          widget.dokumen!.status,
        );
      } else {
        controller.addDokumen(DokumenModel(
          title: _titleController.text,
          bab: _babController.text,
          description: _descController.text,
          status: "Menunggu",
          fileName: _fileName ?? "Belum dipilih",
          date: DateTime.now().toString(),
        ));
      }
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.45,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(20),
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
                      widget.isEdit
                          ? "Edit File Dokumen"
                          : "Upload File Dokumen",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "File",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.2),
                      border: Border.all(
                        color: primaryColor.withOpacity(0.3),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              _fileName ?? 'Belum ada file dipilih',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: TextButton(
                            onPressed: _pickFile,
                            child: const Text(
                              "Pilih File",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Text("Nama Dokumen",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: primaryColor.withOpacity(0.2),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: primaryColor.withOpacity(0.3), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: primaryColor.withOpacity(0.3), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: primaryColor, width: 1.5),
                      ),
                    ),
                    validator: (v) =>
                        v!.isEmpty ? "Nama dokumen wajib diisi" : null,
                  ),

                  const SizedBox(height: 16),
                  const Text("BAB",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _babController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: primaryColor.withOpacity(0.2),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: primaryColor.withOpacity(0.3), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: primaryColor.withOpacity(0.3), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: primaryColor, width: 1.5),
                      ),
                    ),
                    validator: (v) => v!.isEmpty ? "BAB wajib diisi" : null,
                  ),

                  const SizedBox(height: 16),
                  const Text("Keterangan",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: primaryColor.withOpacity(0.2),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: primaryColor.withOpacity(0.3), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: primaryColor.withOpacity(0.3), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: primaryColor, width: 1.5),
                      ),
                    ),
                    maxLines: 2,
                  ),

                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _saveDokumen,
                      child: Text(
                        widget.isEdit ? "UPDATE" : "UPLOAD",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
