import 'package:flutter/material.dart';
import 'package:inta301/pages/page_mahasiswa/kanban_controller.dart';
import 'package:inta301/shared/shared.dart';

class KanbanCard extends StatelessWidget {
  final KanbanTask task;

  const KanbanCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Judul
            Text(
              task.title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: dangerColor,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 10),

            //  Keterangan (opsional)
            if (task.description.isNotEmpty) ...[
              Text(
                "Keterangan : ${task.description}",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  height: 1.4,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 8),
            ],

            // Due Date
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 15,
                  color: Colors.black,
                ),
                const SizedBox(width: 6),
                Text(
                  "Due: ${task.dueDate}",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
