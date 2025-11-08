import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inta301/shared/shared.dart';

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

            // Info Mahasiswa
            Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: primaryColor),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.nama,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text("${widget.nim} - ${widget.jurusan}"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // TabBar
            TabBar(
              controller: tabController,
              labelColor: Colors.black,
              indicatorColor: primaryColor,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: "Menunggu"),
                Tab(text: "Disetujui"),
                Tab(text: "Revisi"),
              ],
            ),

            const Divider(height: 1),
            const SizedBox(height: 16),

            // TabBarView
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  _buildDokumenList("Menunggu"),
                  _buildDokumenList("Disetujui"),
                  _buildDokumenList("Revisi"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDokumenList(String status) {
    // contoh data dummy
    final dokumen = [
      {
        "judul": "BAB I: Pendahuluan",
        "tanggal": "3 Juni 2025, 12:00",
        "keterangan": "Pendahuluan sudah sesuai dan bagus",
        "status": "Disetujui",
      }
    ];

    return ListView.builder(
      padding: EdgeInsets.all(defaultMargin),
      itemCount: dokumen.length,
      itemBuilder: (context, index) {
        final d = dokumen[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Judul + Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    d["judul"]!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      d["status"]!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text("Diupload: ${d["tanggal"]}"),
              Text("Keterangan: ${d["keterangan"]}"),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                  icon: const Icon(Icons.download_rounded),
                  onPressed: () {
                    // aksi download
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
