import 'package:flutter/material.dart';
import 'package:aapka_sathi/screens/home/dashboard_screen.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  // --- State Variables ---
  int _selectedDateIndex = -1;
  int _selectedTimeIndex = -1;
  int _selectedServiceIndex = -1;
  String _selectedMode = "";

  DateTime _currentMonth = DateTime(2026, 1);

  final List<String> _timeSlots = [
    "10:00 AM", "10:30 AM", "11:00 AM",
    "11:30 AM", "12:00 PM", "12:30 PM",
    "01:00 PM", "01:30 PM", "02:00 PM",
    "03:00 PM", "03:30 PM", "04:00 PM",
    "04:30 PM", "05:00 PM", "05:30 PM",
  ];

  final List<String> _services = ["License", "Policies", "Doctor", "Advocate"];

  // --- Colors ---
  final Color _headerYellow = const Color(0xFFFDD835);
  final Color _selectedColor = Colors.orange;
  final Color _unselectedColor = const Color(0xFFFFF9C4);
  final Color _backgroundColor = const Color(0xFFFFFDE7);
  final Color _buttonNavy = const Color(0xFF1A237E);

  // --- Helper Methods ---
  String _getMonthName(int month) {
    const List<String> months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return months[month - 1];
  }

  String _getWeekdayName(int weekday) {
    const List<String> days = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
    return days[weekday - 1];
  }

  int _getDaysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  void _changeMonth(int offset) {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + offset);
      _selectedDateIndex = -1;
    });
  }

  // --- NAVIGATION LOGIC ---
  void _handleBackButton() {
    if (Navigator.canPop(context)) {
      // If there is a previous screen, go back
      Navigator.pop(context);
    } else {
      // If NO previous screen, go to Dashboard/Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final int daysInMonth = _getDaysInMonth(_currentMonth);
    double screenWidth = MediaQuery.of(context).size.width;
    double gridAspectRatio = (screenWidth - 40) / 3 / 45;
    
    // Safety Padding
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 28),
            onPressed: _handleBackButton, 
          ),
        ),
        title: const Text(
          "Appointment",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Calendar Box ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _headerYellow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black87),
                        onPressed: () => _changeMonth(-1),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      Text(
                        "${_getMonthName(_currentMonth.month)}, ${_currentMonth.year}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black87),
                        onPressed: () => _changeMonth(1),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 70,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: daysInMonth,
                      separatorBuilder: (context, index) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final DateTime date = DateTime(_currentMonth.year, _currentMonth.month, index + 1);
                        final bool isSelected = index == _selectedDateIndex;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedDateIndex = index),
                          child: Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.orange : _unselectedColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _getWeekdayName(date.weekday),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.white : Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "${index + 1}".padLeft(2, '0'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.white : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 25),
            
            // --- Slots ---
            const Text("Available Slots", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _timeSlots.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: gridAspectRatio,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final bool isSelected = index == _selectedTimeIndex;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTimeIndex = index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? _selectedColor : _unselectedColor,
                      borderRadius: BorderRadius.circular(15),
                      border: isSelected ? Border.all(color: Colors.orange, width: 2) : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _timeSlots[index],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 25),

            // --- Services ---
            const Text("Choose Service", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.spaceBetween,
              children: List.generate(_services.length, (index) {
                final bool isSelected = index == _selectedServiceIndex;
                double itemWidth = (screenWidth - 60) / 4;
                return GestureDetector(
                  onTap: () => setState(() => _selectedServiceIndex = index),
                  child: Container(
                    width: itemWidth < 70 ? 70 : itemWidth,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? _selectedColor : _unselectedColor,
                      borderRadius: BorderRadius.circular(15),
                      border: isSelected ? Border.all(color: Colors.orange, width: 2) : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _services[index],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),
            const Text("Other Services", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: _unselectedColor,
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    hintText: "Enter reason...",
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 25),
            
            // --- Radio Buttons ---
            Row(
              children: [
                _buildRadioOption("In-Person"),
                const SizedBox(width: 30),
                _buildRadioOption("On-Call"),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // --- Submit ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedDateIndex == -1 || _selectedTimeIndex == -1) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select a Date and Time")));
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Appointment Requested!")));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _buttonNavy,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: const Text("Submit", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),

            // Navigation Bar Spacer
            SizedBox(height: bottomPadding + 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String label) {
    bool isSelected = _selectedMode == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedMode = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(color: _unselectedColor, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              height: 20, width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.white,
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: isSelected ? Padding(padding: const EdgeInsets.all(3.0), child: Container(decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.orange))) : null,
            ),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}