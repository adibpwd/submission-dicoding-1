import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import '../components/list_tile_custom.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Timer _timer = Timer(const Duration(microseconds: 2000), () {});
  List<Map<String, dynamic>> listLesson = [
    {
      "title": "Intro",
      "subtitle": "Cara bernafas",
      "time": "2:20",
      "locked": false,
    },
    {
      "title": "Short",
      "subtitle": "Pernafasan untuk amatir",
      "time": "4:00",
      "locked": false,
    },
    {
      "title": "Medium",
      "subtitle": "8 menit pernafasan",
      "time": "8:00",
      "locked": false,
    },
    {
      "title": "long",
      "subtitle": "Pernafasan jangka panjang",
      "time": "11:00",
      "locked": false,
    },
    {
      "title": "Extended",
      "subtitle": "Coming soon!",
      "time": "15:00",
      "locked": true,
    },
    {
      "title": "Mastery",
      "subtitle": "Coming soon!",
      "time": "18:00",
      "locked": true,
    },
  ];

  List<Map<String, dynamic>> resultSearch = [];

  @override
  void initState() {
    resultSearch = listLesson;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: LayoutBuilder(
        builder: ((context, constraints) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth < 600 ? 4 : 12,
                vertical: 6,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: TextField(
                          onChanged: (value) {
                            if (value.isNotEmpty) _timer.cancel();
                            _timer =
                                Timer(const Duration(milliseconds: 500), () {
                              resultSearch = [];
                              for (var lesson in listLesson) {
                                log(lesson['title'].toLowerCase() +
                                    " == " +
                                    value.toLowerCase());
                                if (lesson['title']
                                    .toLowerCase()
                                    .contains(value.toLowerCase())) {
                                  setState(() {
                                    resultSearch.add(lesson);
                                  });
                                }
                              }
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black12,
                            prefixIcon: const Icon(
                              Icons.search,
                              // color: Colors.red,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.tune,
                          size: 24,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: constraints.maxWidth < 600 ? 12 : 24,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "4 Sesi pernafasan tersedia",
                                style: TextStyle(
                                  fontSize:
                                      constraints.maxWidth < 600 ? 20 : 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Sesi baru akan tersedia sebentar lagi",
                                style: TextStyle(
                                  fontSize:
                                      constraints.maxWidth < 600 ? 12 : 24,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            primary: Colors.white,
                            padding: const EdgeInsets.all(8),
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            size: 40,
                            color: Color.fromRGBO(39, 174, 96, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxWidth < 600 ? 8 : 24,
                  ),
                  Expanded(
                    flex: 8,
                    child: ListView(
                      children: resultSearch.map((e) {
                        int index = listLesson.indexOf(e);
                        String no = index < 10 ? "0${index + 1}" : "$index";
                        return ListTileCustom(
                          data: e,
                          allData: listLesson,
                          no: no,
                        );
                      }).toList(),
                    ),
                  )
                  // const ListTileCustom(
                  //   locked: false,
                  // )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// class Debouncer {
//   final int milliseconds;
//   VoidCallback action;
//   Timer _timer;

//   Debouncer({this.milliseconds = 60});

//   run(VoidCallback action) {
//     if (null != _timer) {
//       _timer.cancel();
//     }
//     _timer = Timer(Duration(milliseconds: milliseconds), action);
//   }
// }
