import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';

// Import modal revisi
import 'package:inta301/pages/page_dosen/revisi_dokumen_modal.dart';

// Import modal status menunggu (pastikan sudah buat file ini)
import 'package:inta301/pages/page_dosen/ubah_status_menunggu_modal.dart';

class DokumenMahasiswaPage extends StatefulWidget {
  final String nama;
  final String nim;
  final String jurusan;

  const DokumenMahasiswaPage({
    super.key,
    required this.nama,
    required this.nim,
    required this.jurusan,
  });

  @override
  State<DokumenMahasiswaPage> createState() => _DokumenMahasiswaPageState();
}

class _DokumenMahasiswaPageState extends State<DokumenMahasiswaPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Menunggu":
        return Colors.orange;
      case "Revisi":
        return Colors.red;
      case "Disetujui":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, dangerColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Dokumen Tugas Akhir',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back + title
            Padding(
              padding: EdgeInsets.all(defaultMargin),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () => Get.back(),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "Dokumen Mahasiswa",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // CARD IDENTITAS
            Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white.withOpacity(0.8),
                    child: const Icon(
                      Icons.person,
                      color: primaryColor,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.nama,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "${widget.nim} - ${widget.jurusan}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // TABBAR
            TabBar(
              controller: tabController,
              indicatorColor: primaryColor,
              labelColor: Colors.black,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: "Menunggu"),
                Tab(text: "Revisi"),
                Tab(text: "Disetujui"),
              ],
            ),

            const Divider(height: 1),
            const SizedBox(height: 12),

            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  _buildDokumenList("Menunggu"),
                  _buildDokumenList("Revisi"),
                  _buildDokumenList("Disetujui"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDokumenList(String status) {
    final dokumen = [
      {
        "judul": "BAB I: Pendahuluan",
        "tanggal": "3 Juni 2025, 12:00",
        "keterangan": "Pendahuluan sudah sesuai dan bagus",
        "status": status,
        "catatanRevisi": status == "Revisi" ? "Perbaiki referensi bab 1" : null,
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      itemCount: dokumen.length,
      itemBuilder: (context, index) {
        final d = dokumen[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    d["judul"]!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: getStatusColor(d["status"]!),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      d["status"]!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              Text("Diupload: ${d["tanggal"]}", style: const TextStyle(color: Colors.black87)),
              Text("Keterangan: ${d["keterangan"]}", style: const TextStyle(color: Colors.black87)),

              const SizedBox(height: 8),

              if (d["status"] == "Revisi" && d["catatanRevisi"] != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "Catatan revisi: ${d["catatanRevisi"]}",
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              Row(
                children: [
                  // EDIT untuk Menunggu → modal UbahStatusMenungguModal
                  if (d["status"] == "Menunggu")
                    IconButton(
                      icon: const Icon(Icons.edit_rounded, color: primaryColor),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => UbahStatusMenungguModal(
                            judulDokumen: d["judul"]!,
                            onSave: (newStatus) {
                              setState(() {
                                d["status"] = newStatus;
                              });
                            },
                          ),
                        );
                      },
                    ),

                  // EDIT untuk Revisi → modal RevisiDokumenModal
                  if (d["status"] == "Revisi")
                    IconButton(
                      icon: const Icon(Icons.edit_rounded, color: primaryColor),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => RevisiDokumenModal(
                            judulDokumen: d["judul"]!,
                            onSave: (String newStatus) {
                              setState(() {
                                d["status"] = newStatus;
                              });
                            },
                          ),
                        );
                      },
                    ),

                  IconButton(
                    icon: const Icon(Icons.download_rounded, color: Colors.black87),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
