import 'package:flutter/material.dart';
import 'package:myapp/models/person.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/addform.dart';

class Item extends StatefulWidget {
  const Item({super.key});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: data[index].job.color,
                ),
                margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                padding: EdgeInsets.all(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[index].name,
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          "อายุ ${data[index].age} ปี , อาชีพ : ${data[index].job.title}",
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Image.asset(data[index].job.image, width: 75, height: 75),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(
          width: 100,
          height: 100,
          child: IconButton(
            icon: const Icon(Icons.add, size: 40, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => const Addform()),
              );
            },
          ),
        ),
      ],
    );
  }
}
