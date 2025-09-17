import 'package:flutter/material.dart';

class EnquiryFormPage extends StatefulWidget {
  final String serviceName;

  const EnquiryFormPage({super.key, required this.serviceName});

  @override
  State<EnquiryFormPage> createState() => _EnquiryFormPageState();
}

class _EnquiryFormPageState extends State<EnquiryFormPage> {
  bool orderInspection = false;
  String? selectedService;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final List<String> services = [
    "Choose Service",
    "Bungalows Cleaning",
    "Offices Cleaning",
    "Societies Cleaning",
    "Restaurant Cleaning",
    "Shops Cleaning",
    "School/College Cleaning"
  ];

  @override
  void initState() {
    super.initState();
    // ✅ Default service handling
    if (services.contains(widget.serviceName)) {
      selectedService = widget.serviceName;
    } else {
      selectedService = "Choose Service";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        title: const Text("Submit an Enquiry"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Name fields
            Row(
              children: [
                Expanded(child: _buildTextField("First Name")),
                const SizedBox(width: 10),
                Expanded(child: _buildTextField("Last Name")),
              ],
            ),
            const SizedBox(height: 12),
            _buildTextField("Email"),
            const SizedBox(height: 12),
            _buildTextField("Mobile (10 digits)"),
            const SizedBox(height: 12),
            _buildTextField("Address"),
            const SizedBox(height: 12),

            // 🔹 State & City
            Row(
              children: [
                Expanded(child: _buildTextField("State")),
                const SizedBox(width: 10),
                Expanded(child: _buildTextField("City")),
              ],
            ),
            const SizedBox(height: 12),

            // 🔹 Service Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedService,
                  isExpanded: true,
                  items: services.map((service) {
                    return DropdownMenuItem(
                      value: service,
                      child: Text(service),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedService = val;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),

            _buildTextField("Total Area in Sq. Ft. (if known)"),
            const SizedBox(height: 12),

            // 🔹 Date Picker
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Select Date"),
              subtitle: Text(
                selectedDate == null
                    ? "No date selected"
                    : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
              ),
              trailing: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 12),

            // 🔹 Time Picker
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Select Time"),
              subtitle: Text(
                selectedTime == null
                    ? "No time selected"
                    : selectedTime!.format(context),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.access_time),
                onPressed: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedTime = picked;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 12),

            // 🔹 Checkbox
            CheckboxListTile(
              value: orderInspection,
              onChanged: (val) {
                setState(() {
                  orderInspection = val ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: const Text("Order inspection at just Rs 200/- *"),
            ),
            const SizedBox(height: 20),

            // 🔹 Only Payment Button
            if (orderInspection)
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // TODO: Add payment navigation logic
                  },
                  child: const Text(
                    "Proceed to Payment (Rs 200)",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // 🔹 Reusable TextField
  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}
