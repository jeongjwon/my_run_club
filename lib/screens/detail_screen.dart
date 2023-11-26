import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:my_run_club/screens/running_%20strength_screen.dart';
import 'package:my_run_club/screens/running_memo_screen.dart';
import 'package:my_run_club/screens/running_place_screen.dart';

class DetailScreen extends StatefulWidget {
  Map<String, dynamic> data;

  DetailScreen({
    super.key,
    required this.data,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int strengthValue = 0;
  String icon = 'plus';
  String memoText = '';

  void onStrengthChanged(int newValue) {
    setState(() {
      strengthValue = newValue;
    });
  }

  void onIconChanged(String newValue) {
    setState(() {
      icon = newValue;
    });
  }

  void onMemoChanged(String newValue) {
    setState(() {
      memoText = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.more_horiz_rounded),
            iconSize: 35,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE8E8E8),
                  width: 1.5,
                ),
              ),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '${widget.data['name'].split(" ")[1]} - ${widget.data['name'].split(" ")[2]} ${widget.data['name'].split(" ")[3]}',
                style: const TextStyle(color: Colors.grey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.data['name'].split(" ")[1]} ${widget.data['name'].split(" ")[2]} 러닝',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
                ],
              ),
            ]),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE8E8E8),
                  width: 1.5,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data['distance'].toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 50, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 7),
                Text(
                  widget.data['unit'] == 'km' ? '킬로미터' : '마일',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data['avgPace'],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            '평균 페이스',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 100),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data['workoutTime'],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            '시간',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE8E8E8),
                  width: 1.5,
                ),
              ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('러닝 강도'),
                  TextButton(
                    onPressed: () async {
                      await showModalBottomSheet(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                            child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: RunningStrengthScreen(
                                  strengthValue: strengthValue,
                                  onStrengthChanged: onStrengthChanged,
                                ))),
                        isScrollControlled: true,
                      );
                    },
                    child: buildTextButtonChild(),
                  )
                ]),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE8E8E8),
                  width: 1.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('러닝 장소'),
                TextButton(
                  onPressed: () async {
                    await showModalBottomSheet(
                      context: context,
                      builder: (context) => SingleChildScrollView(
                          child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: RunningPlaceScreen(
                                icon: icon,
                                onIconChanged: onIconChanged,
                              ))),
                      isScrollControlled: true,
                    );
                  },
                  child: FaIcon(
                    getFontAwesomeIcon(icon),
                    color: Colors.black,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE8E8E8),
                  width: 1.5,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('메모'),
                    TextButton(
                      onPressed: () async {
                        await showModalBottomSheet(
                          context: context,
                          builder: (context) => SingleChildScrollView(
                              child: Container(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: RunningMemoScreen(
                                      memoText: memoText,
                                      onMemoChanged: onMemoChanged))),
                          isScrollControlled: true,
                        );
                      },
                      child: FaIcon(
                        memoText == ''
                            ? FontAwesomeIcons.plus
                            : FontAwesomeIcons.fileLines,
                        color: Colors.black,
                        size: 22,
                      ),
                    ),
                  ],
                ),
                if (memoText != '') Text(memoText),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData getFontAwesomeIcon(String icon) {
    switch (icon) {
      case 'road':
        return FontAwesomeIcons.road;
      case 'roadSpikes':
        return FontAwesomeIcons.roadSpikes;
      case 'mountain':
        return FontAwesomeIcons.mountain;
      default:
        return FontAwesomeIcons.plus;
    }
  }

  Widget buildTextButtonChild() {
    return strengthValue == 0
        ? const FaIcon(
            FontAwesomeIcons.plus,
            color: Colors.black,
            size: 22,
          )
        : Text(
            '${strengthValue ~/ 10}/10',
            style: const TextStyle(color: Colors.black),
          );
  }
}
