import 'package:flutter/material.dart';
import '../shared/shared.dart';
import 'detail_dosen_page.dart'; // ⬅️ tambahkan import ini

class PilihDosenPage extends StatefulWidget {
  const PilihDosenPage({super.key});

  @override
  State<PilihDosenPage> createState() => _PilihDosenPageState();
}

class _PilihDosenPageState extends State<PilihDosenPage> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> dosenList = [
    {
      "nama": "Sukma Evadini, S.T., M.Kom",
      "jabatan": "Dosen",
      "email": "gmail@gmail.com",
      "nik": "1234556789",
      "keahlian": "Bidang Keahlian"
    },
    {
      "nama": "Andi Prasetyo, M.T.",
      "jabatan": "Dosen",
      "email": "andi@gmail.com",
      "nik": "9876543210",
      "keahlian": "Sistem Informasi"
    },
    {
      "nama": "Rina Kusuma, S.Kom., M.Kom",
      "jabatan": "Dosen",
      "email": "rina@gmail.com",
      "nik": "1122334455",
      "keahlian": "Rekayasa Perangkat Lunak"
    },
  ];

  String query = "";

  @override
  Widget build(BuildContext context) {
    final filteredList = dosenList
        .where((dosen) =>
            dosen["nama"]!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header gradient
          Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, dangerColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Center(
                child: Text(
                  "Pengajuan Dosen",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Isi halaman
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Search bar
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (val) => setState(() => query = val),
                      decoration: const InputDecoration(
                        hintText: "Cari dosen pembimbing",
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // List dosen
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          for (int i = 0; i < filteredList.length; i++) ...[
                            InkWell(
                              onTap: () {
                                // ⬅️ navigasi ke halaman detail
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailDosenPage(
                                      dosen: filteredList[i],
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      child: Icon(Icons.person,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          filteredList[i]["nama"]!,
                                          style: TextStyle(
                                            color: dangerColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        const Text(
                                          "Dosen",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (i != filteredList.length - 1)
                              const Divider(height: 1, color: Colors.black),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
