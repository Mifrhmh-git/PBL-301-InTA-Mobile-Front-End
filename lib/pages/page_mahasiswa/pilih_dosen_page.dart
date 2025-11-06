import 'package:flutter/material.dart';
import 'package:inta301/shared/shared.dart';
import 'package:inta301/pages/page_mahasiswa/ajukan_dosen_page.dart';


class PilihDosenPage extends StatefulWidget {
  const PilihDosenPage({super.key});

  @override
  State<PilihDosenPage> createState() => _PilihDosenPageState();
}

class _PilihDosenPageState extends State<PilihDosenPage> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> dosenList = [
    {
      "nama": "Sukma Evadini, S.T., M.Kom",
      "prodi": "Dosen Teknik Informatika",
      "bimbingan": "5 dari 10 Mahasiswa",
    },
    {
      "nama": "Andi Prasetyo, M.T.",
      "prodi": "Dosen Teknik Informatika",
      "bimbingan": "2 dari 10 Mahasiswa",
    },
    {
      "nama": "Rina Kusuma, S.Kom., M.Kom",
      "prodi": "Dosen Teknik Informatika",
      "bimbingan": "6 dari 10 Mahasiswa",
    },
  ];

  String query = "";

  @override
  Widget build(BuildContext context) {
    final filteredList = dosenList
        .where((dosen) =>
            dosen["nama"].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //  HEADER GRADIENT
          Container(
            height: 300,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF88BDF2),
                  Color(0xFF384959),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 40),

                //  Header
                Column(
                  children: const [
                    Text(
                      "Daftar Dosen Pembimbing",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Pilih dosen untuk pengajuan bimbingan",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                const SizedBox(height: 60), 

                // Container putih bawah
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 35), 
                  child: Column(
                    children: [
                      // 🔍 Search Bar
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.3),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                          controller: searchController,
                          onChanged: (val) => setState(() => query = val),
                          decoration: const InputDecoration(
                            hintText: "Cari dosen pembimbing...",
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25), 

                      // 📋 List Dosen
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final dosen = filteredList[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: primaryColor,
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dosen["nama"],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        dosen["prodi"],
                                        style: const TextStyle(
                                          color:Color(0xFF616161),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        dosen["bimbingan"],
                                        style: const TextStyle(
                                          color:Color(0xFF616161),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.black87,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AjukanDosenPage(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
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
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
