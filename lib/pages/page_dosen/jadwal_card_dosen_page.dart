import 'package:flutter/material.dart';
import 'package:inta301/shared/shared.dart';

class JadwalCard extends StatelessWidget {
  final String title; // judul jadwal
  final String time; // waktu jadwal
  final String? description; // keterangan tambahan (opsional)
  final IconData icon; // ikon di sebelah kiri
  final VoidCallback? onTap; // aksi saat card ditekan

  const JadwalCard({
    super.key,
    required this.title,
    required this.time,
    this.description,
    this.icon = Icons.schedule,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: primaryColor.withOpacity(0.1),
          child: Icon(icon, color: primaryColor),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: const TextStyle(color: Colors.black87),
            ),
            if (description != null) ...[
              const SizedBox(height: 4),
              Text(
                description!,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
