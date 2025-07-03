import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OfficeExercisesPage extends StatefulWidget {
  const OfficeExercisesPage({super.key});

  @override
  State<OfficeExercisesPage> createState() => _OfficeExercisesPageState();
}

class _OfficeExercisesPageState extends State<OfficeExercisesPage> {
  String selectedCategory = 'ทั้งหมด';

  final List<String> categories = [
    'ทั้งหมด',
    'ตอนเช้า',
    'หลังมื้อเที่ยง',
    'ดึก',
  ];

  final List<ExerciseItem> exercises = [
    ExerciseItem(
      title: 'ท่าดึงกล้ามเนื้อหลัง',
      category: 'ตอนเช้า',
      duration: '30 วินาที x 2 ครั้ง',
      imagePaths: ['assets/images/ex1.png',],
    ),
    ExerciseItem(
      title: 'ท่าหมุนไหล่ตามเครือง',
      category: 'ตอนเช้า',
      duration: '10 ครั้ง x 2 รอบ',
      imagePaths: ['assets/images/ex2.png'],
    ),
    ExerciseItem(
      title: 'ท่าเปิดอก และปลายมือ',
      category: 'หลังมื้อเที่ยง',
      duration: '15 วินาที x 4 ครั้ง',
      imagePaths: ['assets/images/ex3.png'],
    ),
    ExerciseItem(
      title: 'ท่าดึงหน้าตามเครือง',
      category: 'หลังมื้อเที่ยง',
      duration: '30 วินาที x 2 ช่วง',
      imagePaths: ['assets/images/ex4.png'],
    ),
    ExerciseItem(
      title: '20-20-20 พักสายตา',
      category: 'ดึก',
      duration: '20 วินาที',
      imagePaths: ['assets/images/pic6.png'],
      isSpecial: true,
    ),
    ExerciseItem(
      title: 'ท่าดึงคาเหนื่อมือง',
      category: 'ดึก',
      duration: '30 วินาที x 2 ช่วง',
      imagePaths: ['assets/images/ex5.png'],
      icon: Icons.back_hand,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'all exercises',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ),
          ),
          // Category Filter
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.green.shade400
                            : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: isSelected
                              ? Colors.green.shade400
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // Exercise List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: _getFilteredExercises().length,
                itemBuilder: (context, index) {
                  final exercise = _getFilteredExercises()[index];
                  return _buildExerciseCard(exercise);
                },
              ),
            ),
          ),
          // Bottom text
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'ท่าออกกำลังกายจากออกกาย',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<ExerciseItem> _getFilteredExercises() {
    if (selectedCategory == 'ทั้งหมด') {
      return exercises;
    }
    return exercises
        .where((exercise) => exercise.category == selectedCategory)
        .toList();
  }

  Widget _buildExerciseCard(ExerciseItem exercise) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          // Exercise Image(s) or Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: (exercise.imagePaths.isNotEmpty)
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      exercise.imagePaths.first,
                      fit: BoxFit.cover,
                    ),
                  )
                : (exercise.icon != null
                    ? Icon(exercise.icon, color: Colors.grey[600], size: 30)
                    : const SizedBox()),
          ),
          // ถ้ามีหลายรูป แสดง indicator
          if (exercise.imagePaths.length > 1)
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Row(
                children: List.generate(
                  exercise.imagePaths.length,
                  (i) => Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(width: 16),
          // Exercise Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.title,
                  style: GoogleFonts.kanit(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  exercise.category,
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
                const SizedBox(height: 4),
                if (exercise.isSpecial) ...[
                  Text(
                    exercise.duration,
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.orange[700],
                      ),
                    ),
                  ),
                  Text(
                    'ส่วนสายตามากที่',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ] else ...[
                  Text(
                    exercise.duration,
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.green.shade600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Arrow
          Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.green.shade400,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavItem(Icons.home, false, () {
            Navigator.pushReplacementNamed(context, '/home');
          }),
          _buildBottomNavItem(Icons.lightbulb_outline, false, () {
            // Navigate to tips page
          }),
          _buildBottomNavItem(Icons.directions_walk, true, () {
            // Already on exercise page
          }),
          _buildBottomNavItem(Icons.person_outline, false, () {
            // Navigate to profile page
          }),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white70,
          size: 28,
        ),
      ),
    );
  }
}

class ExerciseItem {
  final String title;
  final String category;
  final String duration;
  final IconData? icon;
  final List<String> imagePaths;
  final bool isSpecial;

  ExerciseItem({
    required this.title,
    required this.category,
    required this.duration,
    this.icon,
    this.imagePaths = const [],
    this.isSpecial = false,
  });
}
