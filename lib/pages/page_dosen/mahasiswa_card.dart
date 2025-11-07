import 'package:flutter/material.dart';
import 'package:inta301/shared/shared.dart';
import 'package:inta301/pages/page_dosen/ajukan_bimbingan_modal.dart';

class MahasiswaCard extends StatelessWidget {
  final String nama;
  final String nim;
  final String prodi;
  final VoidCallback? onAjukanBimbingan;

  const MahasiswaCard({
    Key? key,
    required this.nama,
    required this.nim,
    required this.prodi,
    this.onAjukanBimbingan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white, // ubah jadi putih
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25), // shadow lebih jelas
            blurRadius: 10, // lebih tegas
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
        CircleAvatar(
  radius: 25,
  backgroundColor: primaryColor.withOpacity(0.1),
  child: Icon(Icons.person, color: primaryColor, size: 30),
),

          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  "$nim - $prodi",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          if (onAjukanBimbingan != null)
            IconButton(
              icon: const Icon(Icons.add_circle_outline, color: primaryColor),
              onPressed: onAjukanBimbingan,
              tooltip: "Ajukan Bimbingan",
            ),
        ],
      ),
    );
  }
}
