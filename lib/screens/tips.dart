import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'เคล็ดลับเพื่อสุขภาพ',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 20),
            _buildTipCard(
              icon: Icons.remove_red_eye,
              title: "Eye Tips",
              onTap: () {
                _navigateToTipDetail(context, "Eye Tips", _getEyeTips());
              },
            ),
            const SizedBox(height: 12),
            _buildTipCard(
              icon: Icons.support,
              title: "Back Pain Tips",
              onTap: () {
                _navigateToTipDetail(
                  context,
                  "Back Pain Tips",
                  _getBackPainTips(),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildTipCard(
              icon: Icons.support,
              title: "Neck Pain Tips",
              onTap: () {
                _navigateToTipDetail(
                  context,
                  "Neck Pain Tips",
                  _getNeckPainTips(),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildTipCard(
              icon: Icons.back_hand,
              title: "Wrist Pain Tips",
              onTap: () {
                _navigateToTipDetail(
                  context,
                  "Wrist Pain Tips",
                  _getWristPainTips(),
                );
              },
            ),
            const Spacer(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
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
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black87,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: GoogleFonts.kanit(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
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
            Navigator.pushNamed(context, '/tips');
          }),
          _buildBottomNavItem(Icons.directions_walk, false, () {
            // Navigate to exercise page
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

  void _navigateToTipDetail(
    BuildContext context,
    String title,
    List<String> tips,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TipDetailPage(title: title, tips: tips),
      ),
    );
  }

  List<String> _getEyeTips() {
    return [
      "ปฏิบัติตามกฎ 20-20-20: ทุก 20 นาที มองสิ่งที่อยู่ห่าง 20 ฟุต เป็นเวลา 20 วินาที",
      "กะพริบตาบ่อยๆ เพื่อป้องกันตาแห้ง",
      "ปรับความสว่างของหน้าจอให้เหมาะสม",
      "ใช้แว่นป้องกันแสงสีน้ำเงิน",
      "วางหน้าจอให้ห่างจากตาอย่างน้อย 60 ซม.",
      "หลับให้เพียงพอ 7-8 ชั่วโมงต่อวัน",
    ];
  }

  List<String> _getBackPainTips() {
    return [
      "นั่งให้หลังตรง เท้าแนบพื้น",
      "ใช้เก้าอี้ที่มีพนักพิงรองรับหลัง",
      "ลุกยืนยืดเส้นยืดสายทุก 30-45 นาที",
      "วางหน้าจอในระดับสายตา",
      "ออกกำลังกายเสริมสร้างกล้ามเนื้อหลัง",
      "หลีกเลี่ยงการนั่งนานเกิน 2 ชั่วโมง",
    ];
  }

  List<String> _getNeckPainTips() {
    return [
      "วางหน้าจอในระดับสายตาหรือต่ำกว่าเล็กน้อย",
      "หลีกเลี่ยงการเอียงคอมองหน้าจอ",
      "ใช้หมอนรองคอเมื่อทำงาน",
      "ยืดกล้ามเนื้อคอเป็นประจำ",
      "หมุนไหล่และคอเป็นครั้งคราว",
      "พักดวงตาและคอทุก 15-20 นาที",
    ];
  }

  List<String> _getWristPainTips() {
    return [
      "วางข้อมือในแนวตรงเมื่อพิมพ์",
      "ใช้ที่รองข้อมือ (wrist rest)",
      "หลีกเลี่ยงการวางข้อมือบนขอบโต๊ะ",
      "ยืดข้อมือและนิ้วเป็นประจำ",
      "พักการพิมพ์ทุก 15-20 นาที",
      "ใช้แป้นพิมพ์และเมาส์ที่เหมาะสม",
    ];
  }
}

// Tip Detail Page
class TipDetailPage extends StatelessWidget {
  final String title;
  final List<String> tips;

  const TipDetailPage({super.key, required this.title, required this.tips});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          title,
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: tips.length,
          itemBuilder: (context, index) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      tips[index],
                      style: GoogleFonts.kanit(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
