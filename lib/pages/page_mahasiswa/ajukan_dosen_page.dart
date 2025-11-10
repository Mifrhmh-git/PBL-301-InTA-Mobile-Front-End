import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'ajukan_dosen_terkirim_page.dart';
import 'package:inta301/shared/shared.dart';

class AjukanDosenPage extends StatefulWidget {
  const AjukanDosenPage({super.key});

  @override
  State<AjukanDosenPage> createState() => _AjukanDosenPageState();
}

class _AjukanDosenPageState extends State<AjukanDosenPage> {
  final TextEditingController alasanController = TextEditingController();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  PlatformFile? portofolioFile;

  Future<void> _pickPortofolioFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        portofolioFile = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Header
          Container(
            height: 260,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF88BDF2),
                  Color(0xFF384959),
                ],
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 45),
                const Center(
                  child: Text(
                    "Pengajuan Dosen",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 60),

                // Kontainer isi
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 30,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      // Dosen Pembimbing
                      _label("Dosen Pembimbing"),
                      _dosenBox(),

                      const SizedBox(height: 16),

                      // Alasan
                      _label("Alasan Memilih Dosen"),
                      _buildField(controller: alasanController, maxLines: 4),

                      const SizedBox(height: 16),

                      // Rencana Judul
                      _label("Rencana Judul TA"),
                      _buildField(controller: judulController),

                      const SizedBox(height: 16),

                      // Deskripsi
                      _label("Deskripsi TA"),
                      _buildField(controller: deskripsiController, maxLines: 4),

                      const SizedBox(height: 16),

                      // Upload
                      _label("Upload Portofolio"),
                      const SizedBox(height: 8),
                      _uploadBox(),

                      const SizedBox(height: 24),

                      // Tombol Kirim
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AjukanDosenTerkirimPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF384959),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Kirim",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tombol Back
          Positioned(
            top: 50,
            left: 15,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== WIDGET KECIL ====================

  static Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _dosenBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF88BDF2).withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        "Sukma Evadini, S.T., M.Kom",
        style: TextStyle(
          color: Colors.black87,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _uploadBox() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: const Color(0xFF88BDF2).withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              border: Border.all(
                color: const Color(0xFF88BDF2).withOpacity(0.3),
              ),
            ),
            child: Text(
              portofolioFile?.name ?? 'Belum ada file dipilih',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),

        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: _pickPortofolioFile,
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
    );
  }

  // FIELD INPUT
  static Widget _buildField({
    required TextEditingController controller,
    int maxLines = 1,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF88BDF2).withOpacity(0.2),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: const Color(0xFF88BDF2).withOpacity(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: const Color(0xFF88BDF2).withOpacity(0.3),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(
            color: Color(0xFF88BDF2),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
