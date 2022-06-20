import 'package:flutter/material.dart';
import 'package:test_dicoding/screens/detail_lesson.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/widgets.dart';

class ListTileCustom extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ListTileCustom({
    Key? key,
    required this.data,
    required this.allData,
    this.no = "00",
  }) : super(key: key);

  final String no;
  final Map<String, dynamic> data;
  final List<Map<String, dynamic>> allData;

  @override
  State<ListTileCustom> createState() => _ListTileCustomState();
}

class _ListTileCustomState extends State<ListTileCustom> {
  bool played = false;

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Opacity(
      opacity: widget.data['locked'] ? 0.3 : 1,
      child: InkWell(
        onTap: () {
          if (widget.data['locked']) {
            const snackbar = SnackBar(
              content: Text(
                "Coming soon",
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailLesson(
                no: widget.no,
                data: widget.data,
                allData: widget.allData,
              ),
            ),
          );
        },
        child: LayoutBuilder(
          builder: ((context, constraints) {
            return Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: played ? primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: constraints.maxWidth < 600 ? 48 : 60,
                    height: constraints.maxWidth < 600 ? 40 : 60,
                    decoration: BoxDecoration(
                      color: played
                          ? Colors.white
                          : widget.data['locked']
                              ? Colors.black26
                              : primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        widget.no,
                        style: TextStyle(
                          fontSize: constraints.maxWidth < 600 ? 16 : 24,
                          fontWeight: FontWeight.w600,
                          color: played ? primaryColor : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data['title'],
                        style: TextStyle(
                          fontSize: constraints.maxWidth < 600 ? 20 : 24,
                          color: played ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        widget.data['subtitle'],
                        style: TextStyle(
                          fontSize: constraints.maxWidth < 600 ? 12 : 16,
                          color: played
                              ? Colors.white.withOpacity(0.95)
                              : Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.data['time'] + " m",
                          style: TextStyle(
                            color: played
                                ? Colors.white.withOpacity(0.8)
                                : Colors.black.withOpacity(0.3),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        widget.data['locked']
                            ? const Icon(
                                Icons.lock_rounded,
                                color: Colors.red,
                                size: 36,
                              )
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    played = !played;
                                  });
                                },
                                icon: Icon(
                                  played ? Icons.pause : Icons.play_arrow,
                                  size: constraints.maxWidth < 600 ? 32 : 40,
                                  color: played ? Colors.white : primaryColor,
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
