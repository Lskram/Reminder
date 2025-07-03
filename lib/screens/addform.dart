import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:myapp/models/person.dart';

class Addform extends StatefulWidget {
  const Addform({super.key});

  @override
  State<Addform> createState() => _AddformState();
}

class _AddformState extends State<Addform> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  int _age = 20;
  Job _job = Job.police;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My app",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("ฟอร์มบันทึกข้อมูล"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 20,
                  decoration: InputDecoration(
                    label: Text("ชื่อ", style: TextStyle(fontSize: 20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "ช่วยกรอกชื่อด้วยครับลูกค้า";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text("อายุ", style: TextStyle(fontSize: 20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรอกอายุให้หน่อยครับผม";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _age = int.parse(value.toString());
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  value: _job,
                  decoration: const InputDecoration(
                    label: Text("อาชีพ", style: TextStyle(fontSize: 20)),
                  ),
                  items: Job.values.map((Key) {
                    return DropdownMenuItem(value: Key, child: Text(Key.title));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _job = value!;
                    });
                  },
                ),
                FilledButton(
                  onPressed: () {
                    _formKey.currentState!.validate();
                    _formKey.currentState!.save();
                    data.add(Person(name: _name, age: _age, job: _job));
                    _formKey.currentState!.reset();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (ctx) => const MyApp()),
                    );
                  },
                  style: FilledButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text("บันทึก", style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
