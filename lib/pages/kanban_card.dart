import 'package:flutter/material.dart';
import 'kanban_controller.dart';

class KanbanCard extends StatelessWidget {
  final KanbanTask task;

  const KanbanCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8), // 🔹 jarak antar card pas
      decoration: BoxDecoration(
        color: Colors.white, // 🔹 putih bersih
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), // 🔹 bayangan lembut tapi tegas
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔸 Judul / Bab
            Text(
              task.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black, // teks hitam tegas
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 4),

            // 🔸 Keterangan (opsional)
            if (task.description.isNotEmpty) ...[
              Text(
                "Keterangan: ${task.description}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 4),
            ],

            // 🔸 Tanggal Due
            Text(
              "Due: ${task.dueDate}",
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
