import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class DetailLesson extends StatefulWidget {
  DetailLesson({
    Key? key,
    required this.data,
    required this.allData,
    this.no = "00",
  }) : super(key: key);

  Map<String, dynamic> data;
  String no;
  final List<Map<String, dynamic>> allData;
  @override
  State<DetailLesson> createState() => _DetailLessonState();
}

class _DetailLessonState extends State<DetailLesson> {
  double _value = 0.0;
  bool played = false;
  Timer playAudio = Timer(const Duration(seconds: 0), () {
    log("Run once for initialized");
  });

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: ((context, constraints) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Text(
                    widget.no,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),

                Center(
                  child: Container(
                    width: constraints.maxWidth < 750 ? 240 : 140,
                    height: constraints.maxHeight < 550
                        ? 80
                        : constraints.maxHeight < 650
                            ? 185
                            : constraints.maxHeight < 750
                                ? 240
                                : 140,
                    decoration: BoxDecoration(
                      // color: Colors.black,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 5,
                        color: primaryColor,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 8,
                          color: Colors.white,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/images/breathe.png",
                          width: 80,
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                // const Spacer(),
                SizedBox(
                  height: constraints.maxHeight < 750
                      ? constraints.maxHeight * 0.1
                      : constraints.maxHeight * 0.35,
                ),
                Center(
                  child: Text(
                    widget.data['title'],
                    style: TextStyle(
                      fontSize: constraints.maxWidth < 400
                          ? 18
                          : constraints.maxWidth < 600
                              ? 24
                              : 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: constraints.maxWidth < 400
                      ? 8
                      : constraints.maxWidth < 600
                          ? 16
                          : 24,
                ),
                Center(
                  child: Text(
                    widget.data['subtitle'],
                    style: TextStyle(
                      fontSize: constraints.maxWidth < 400
                          ? 8
                          : constraints.maxWidth < 600
                              ? 12
                              : 20,
                      color: Colors.black38,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  // flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: 150,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: constraints.maxWidth < 600 ? 16 : 24,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "00:00",
                              style: TextStyle(
                                color: Colors.black12.withOpacity(0.7),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              widget.data['time'],
                              style: TextStyle(
                                color: Colors.black12.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                        SliderTheme(
                          data: SliderThemeData(
                            thumbColor: primaryColor,
                            activeTrackColor: primaryColor,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 10,
                            ),
                          ),
                          child: Slider(
                            value: _value,
                            onChanged: (val) {
                              _value = val;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxWidth < 600 ? 16 : 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  log("previouse ");
                                  int index =
                                      widget.allData.indexOf(widget.data);
                                  if (index == 0) {
                                    var snackbar = const SnackBar(
                                        content:
                                            Text("Have a minimum of lessons"));

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackbar);
                                    return;
                                  }

                                  Map<String, dynamic> willPlay =
                                      widget.allData[index - 1];

                                  setState(() {
                                    widget.data = willPlay;
                                    widget.no = "0$index";
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.zero,
                                  child: Icon(
                                    Icons.skip_previous,
                                    size: constraints.maxWidth < 600 ? 50 : 85,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    played = !played;
                                  });
                                  if (played) {
                                    playAudio = Timer.periodic(
                                        const Duration(seconds: 1), (timer) {
                                      double amountAdded = _value + 0.01;
                                      if (amountAdded > 1) {
                                        var snackbar = const SnackBar(
                                          content: Text(
                                              "Player is done, and play again."),
                                        );

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar);
                                        _value = 0.0;
                                        return;
                                      }
                                      setState(() {
                                        _value = amountAdded;
                                      });
                                    });
                                  } else {
                                    playAudio.cancel();
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    played ? Icons.pause : Icons.play_arrow,
                                    size: constraints.maxWidth < 600 ? 30 : 100,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    int index =
                                        widget.allData.indexOf(widget.data);
                                    if (index == widget.allData.length) {
                                      var snackbar = const SnackBar(
                                          content: Text("Max content"));

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackbar);
                                      return;
                                    }

                                    Map<String, dynamic> willPlay =
                                        widget.allData[index + 1];

                                    if (willPlay['locked'] == true) {
                                      var snackbar = const SnackBar(
                                          content:
                                              Text("Can't play locked lesson"));

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackbar);
                                      return;
                                    }

                                    setState(() {
                                      widget.data = willPlay;
                                      widget.no = widget.no = index < 10
                                          ? "0${index + 2}"
                                          : "$index";
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.zero,
                                    // decoration: BoxDecoration(),
                                    child: Icon(
                                      Icons.skip_next,
                                      size:
                                          constraints.maxWidth < 600 ? 50 : 85,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              // Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
