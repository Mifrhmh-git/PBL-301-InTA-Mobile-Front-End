import 'package:flutter/material.dart';
import '../shared/shared.dart'; // pastikan ini sesuai path project kamu

class PilihDosenPage extends StatefulWidget {
  const PilihDosenPage({super.key});

  @override
  State<PilihDosenPage> createState() => _PilihDosenPageState();
}

class _PilihDosenPageState extends State<PilihDosenPage> {
  final TextEditingController searchController = TextEditingController();

  // contoh data dosen
  final List<Map<String, String>> dosenList = [
    {"nama": "Sukma Evadini, S.T., M.Kom", "jabatan": "Dosen"},
    {"nama": "Andi Prasetyo, M.T.", "jabatan": "Dosen"},
    {"nama": "Rina Kusuma, S.Kom., M.Kom", "jabatan": "Dosen"},
  ];

  String query = "";

  @override
  Widget build(BuildContext context) {
    // filter hasil pencarian
    final filteredList = dosenList
        .where((dosen) =>
            dosen["nama"]!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Bagian atas (judul dengan background biru)
          Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.9),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: const Center(
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

          // Bagian isi (search dan list)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Search bar
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (val) {
                        setState(() {
                          query = val;
                        });
                      },
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
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListView.separated(
                        itemCount: filteredList.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final dosen = filteredList[index];
                          return ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            title: Text(
                              dosen["nama"]!,
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(dosen["jabatan"]!),
                            onTap: () {
                              // aksi ketika memilih dosen
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Kamu memilih ${dosen["nama"]!} sebagai pembimbing"),
                                  backgroundColor: primaryColor,
                                ),
                              );
                            },
                          );
                        },
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

