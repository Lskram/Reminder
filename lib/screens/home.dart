import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/exercises.dart';
import 'package:myapp/screens/myProfile.dart';
import 'package:myapp/screens/tips.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class HomeTask {
  final String title;
  final String subtitle;
  final String time;
  final Color color;
  bool isEnabled;
  HomeTask({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.color,
    this.isEnabled = true,
  });
}

class _HomeState extends State<Home> {
  late Timer _timer;
  late DateTime _now;

  int _selectedIndex = 0;

  // List of tasks (initial demo data)
  List<HomeTask> _tasks = [
    HomeTask(
      title: "At Work",
      subtitle: "Stand up and stretch for 2 minutes",
      time: "8:30-16:30",
      color: Colors.green.shade400,
      isEnabled: false,
    ),
    HomeTask(
      title: "Freelance",
      subtitle: "Stand up and stretch for 2 minutes",
      time: "-",
      color: Colors.blue.shade400,
      isEnabled: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _buildHomeContent(),
      _buildTipsContent(),
      _buildExerciseContent(),
      _buildProfileContent(),
    ];
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          _getAppBarTitle(_selectedIndex),
          style: GoogleFonts.kanit(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.green.shade400,
        centerTitle: true,
        elevation: 0,
      ),
      body: _pages[_selectedIndex],
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                _showAddTaskDialog();
              },
              backgroundColor: Colors.green.shade400,
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            )
          : null,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHomeContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // นาฬิกาตรงกลางเท่ห์ๆ
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Colors.green.shade400, width: 2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.green.shade400,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _now.hour.toString().padLeft(2, '0') +
                          ':' +
                          _now.minute.toString().padLeft(2, '0') +
                          ':' +
                          _now.second.toString().padLeft(2, '0'),
                      style: GoogleFonts.kanit(
                        textStyle: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _tasks.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return _buildTaskCard(
                  number: (index + 1).toString(),
                  title: task.title,
                  subtitle: task.subtitle,
                  time: task.time,
                  color: task.color,
                  isEnabled: task.isEnabled,
                  onToggle: (value) {
                    setState(() {
                      task.isEnabled = value;
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 8),
            child: SizedBox(
              width: 120,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/item');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade400,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  "กิจกรรม",
                  style: GoogleFonts.kanit(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsContent() {
    return const TipsPage();
  }

  Widget _buildExerciseContent() {
    return const OfficeExercisesPage();
  }

  Widget _buildProfileContent() {
    return const ProfilePage();
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Tips';
      case 2:
        return 'Exercise';
      case 3:
        return 'Profile';
      default:
        return '';
    }
  }

  Widget _buildTaskCard({
    required String number,
    required String title,
    required String subtitle,
    required String time,
    required Color color,
    required bool isEnabled,
    required Function(bool) onToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Number Circle
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Center(
                child: Text(
                  number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Task Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.kanit(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    time,
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Toggle Switch
            Switch(
              value: isEnabled,
              onChanged: onToggle,
              activeColor: color,
              inactiveThumbColor: Colors.grey[400],
              inactiveTrackColor: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.green.shade400,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      selectedLabelStyle: GoogleFonts.kanit(fontWeight: FontWeight.bold),
      unselectedLabelStyle: GoogleFonts.kanit(),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.lightbulb_outline),
          label: 'Tips',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_walk),
          label: 'Exercise',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }

  void _showAddTaskDialog() {
    final _titleController = TextEditingController();
    final _subtitleController = TextEditingController();
    final _timeController = TextEditingController();
    Color selectedColor = Colors.green.shade400;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('เพิ่มกิจกรรมใหม่', style: GoogleFonts.kanit()),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'ชื่อกิจกรรม',
                    labelStyle: GoogleFonts.kanit(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _subtitleController,
                  decoration: InputDecoration(
                    labelText: 'รายละเอียด',
                    labelStyle: GoogleFonts.kanit(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _timeController,
                  decoration: InputDecoration(
                    labelText: 'เวลา (เช่น 10:00-11:00 หรือ -)',
                    labelStyle: GoogleFonts.kanit(),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text('สี:', style: GoogleFonts.kanit()),
                    const SizedBox(width: 8),
                    _buildColorPicker(Colors.green.shade400, selectedColor, () {
                      selectedColor = Colors.green.shade400;
                      // ignore: invalid_use_of_protected_member
                      (context as Element).markNeedsBuild();
                    }),
                    _buildColorPicker(Colors.blue.shade400, selectedColor, () {
                      selectedColor = Colors.blue.shade400;
                      (context as Element).markNeedsBuild();
                    }),
                    _buildColorPicker(
                      Colors.orange.shade400,
                      selectedColor,
                      () {
                        selectedColor = Colors.orange.shade400;
                        (context as Element).markNeedsBuild();
                      },
                    ),
                    _buildColorPicker(
                      Colors.purple.shade400,
                      selectedColor,
                      () {
                        selectedColor = Colors.purple.shade400;
                        (context as Element).markNeedsBuild();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('ยกเลิก', style: GoogleFonts.kanit()),
            ),
            TextButton(
              onPressed: () {
                if (_titleController.text.trim().isEmpty) return;
                setState(() {
                  _tasks.add(
                    HomeTask(
                      title: _titleController.text.trim(),
                      subtitle: _subtitleController.text.trim(),
                      time: _timeController.text.trim().isEmpty
                          ? '-'
                          : _timeController.text.trim(),
                      color: selectedColor,
                      isEnabled: true,
                    ),
                  );
                });
                Navigator.of(context).pop();
              },
              child: Text('เพิ่ม', style: GoogleFonts.kanit()),
            ),
          ],
        );
      },
    );
  }

  Widget _buildColorPicker(Color color, Color selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected == color ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }
}
