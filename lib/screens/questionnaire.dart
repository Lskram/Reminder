import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({super.key});

  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  final List<String> questions = [
    'คุณมีอาการปวดคอ/ไหล่/หลังหรือไม่?',
    'คุณมีอาการปวดข้อมือ/นิ้วมือหรือไม่?',
    'คุณมีอาการปวดตา/ล้าตาเวลาทำงานหน้าคอมหรือไม่?',
    'คุณมีอาการชา/ยิบๆ ตามแขนหรือขาหรือไม่?',
    'คุณมีอาการปวดศีรษะบ่อยหรือไม่?',
    'คุณมีอาการปวดกล้ามเนื้อหลังเลิกงานหรือไม่?',
    'คุณมีอาการเหนื่อยง่าย/อ่อนเพลียระหว่างวันหรือไม่?',
    'คุณมีอาการนอนไม่หลับ/หลับไม่สนิทหรือไม่?',
    'คุณมีอาการเครียด/วิตกกังวลจากงานหรือไม่?',
    'คุณเคยได้รับบาดเจ็บจากการทำงานออฟฟิศหรือไม่?',
  ];
  late List<bool> answers;

  @override
  void initState() {
    super.initState();
    answers = List.filled(questions.length, false);
  }

  // ไม่ต้องเช็ค allAnswered อีกต่อไป (submit ได้เสมอ)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แบบสอบถามออฟฟิศซินโดรม', style: GoogleFonts.kanit()),
        backgroundColor: Colors.green.shade400,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'กรุณาตอบแบบสอบถามเพื่อรับคำแนะนำการดูแลสุขภาพที่เหมาะสม',
              style: GoogleFonts.kanit(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(questions[index], style: GoogleFonts.kanit()),
                    value: answers[index],
                    onChanged: (val) {
                      setState(() {
                        answers[index] = val ?? false;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade400,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 40,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text('Submit', style: GoogleFonts.kanit(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
