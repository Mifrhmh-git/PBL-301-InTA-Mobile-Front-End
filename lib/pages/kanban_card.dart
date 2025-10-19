import 'package:flutter/material.dart';
import 'kanban_controller.dart';

class KanbanCard extends StatelessWidget {
  final KanbanTask task;

  const KanbanCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul / Bab
            Text(
              task.title,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 6),
            // Keterangan
            if (task.description.isNotEmpty)
              Text(
                "Keterangan: ${task.description}",
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            if (task.description.isNotEmpty) const SizedBox(height: 6),
            // Due Date
            Text(
              "Due: ${task.dueDate}",
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
