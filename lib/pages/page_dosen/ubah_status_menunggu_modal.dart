import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:inta301/shared/shared.dart';

class UbahStatusMenungguModal extends StatefulWidget {
  final String judulDokumen;
  final String currentStatus;
  final ValueChanged<String>? onSave;

  const UbahStatusMenungguModal({
    super.key,
    required this.judulDokumen,
    this.currentStatus = "Menunggu",
    this.onSave,
  });

  @override
  State<UbahStatusMenungguModal> createState() =>
      _UbahStatusMenungguModalState();
}

class _UbahStatusMenungguModalState extends State<UbahStatusMenungguModal> {
  String? selectedStatus;

  final List<String> statusList = ["Menunggu", "Revisi", "Disetujui"];

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.currentStatus;
  }

  void saveStatus() {
    if (widget.onSave != null && selectedStatus != null) {
      widget.onSave!(selectedStatus!);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.50, // awal muncul 70%
      minChildSize: 0.50,     // boleh diperkecil sampai 50%
      maxChildSize: 0.90,     // bisa ditarik sampai 90%
      expand: false,

      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                // Title
                Center(
                  child: Text(
                    "Ubah Status: ${widget.judulDokumen}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),

                // Dropdown Status
                const Text(
                  "Pilih Status",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),

                DropdownButton2<String>(
                  isExpanded: true,
                  underline: SizedBox(),
                  value: selectedStatus,
                  items: statusList
                      .map((status) => DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value!;
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDDEEFF),  
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: primaryColor.withAlpha(76)),
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xFFDDEEFF),
                      border: Border.all(color: primaryColor.withAlpha(76)),
                    ),
                    offset: const Offset(0, 0),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.keyboard_arrow_down),
                  ),
                ),

                const SizedBox(height: 30),

                // Tombol Simpan
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: saveStatus,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: dangerColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "SIMPAN",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
