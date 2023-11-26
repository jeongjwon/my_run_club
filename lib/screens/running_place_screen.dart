import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_run_club/provider/task_provider.dart';
import 'package:provider/provider.dart';

class RunningPlaceScreen extends StatefulWidget {
  final String icon;
  final Function(String) onIconChanged;
  final String documentId;
  const RunningPlaceScreen({
    super.key,
    required this.icon,
    required this.onIconChanged,
    required this.documentId,
  });

  @override
  State<RunningPlaceScreen> createState() => _RunningPlaceScreenState();
}

class _RunningPlaceScreenState extends State<RunningPlaceScreen> {
  late bool isRoad, isTrack, isMountain;

  late String _currentIcon;
  double iconSize = 40;

  @override
  void initState() {
    _currentIcon = widget.icon;
    isRoad = widget.icon == 'road' ? true : false;
    isTrack = widget.icon == 'roadSpikes' ? true : false;
    isMountain = widget.icon == 'mountain' ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            '러닝 장소',
            style: TextStyle(
              letterSpacing: 2,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            '어느 곳에서 달리셨나요?',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 50,
                height: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isRoad = true;
                          isTrack = false;
                          isMountain = false;
                        });
                        widget.onIconChanged(getSelectedIcon());
                        _delayedPop(context);
                      },
                      child: FaIcon(
                        FontAwesomeIcons.road,
                        size: isRoad ? 45 : 40,
                        color: isRoad ? Colors.black : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text('도로')
                  ],
                ),
              ),
              SizedBox(
                width: 50,
                height: 70,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isTrack = true;
                          isRoad = false;
                          isMountain = false;
                        });
                        widget.onIconChanged(getSelectedIcon());
                        _delayedPop(context);
                        // _delayedPop(context, getSelectedIcon());
                      },
                      child: FaIcon(
                        FontAwesomeIcons.roadSpikes,
                        size: isTrack ? 45 : 40,
                        color: isTrack ? Colors.black : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text('트랙')
                  ],
                ),
              ),
              SizedBox(
                width: 50,
                height: 70,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isMountain = true;
                          isRoad = false;
                          isTrack = false;
                        });
                        widget.onIconChanged(getSelectedIcon());
                        Provider.of<TaskProvider>(context, listen: false)
                            .updateTask(widget.documentId,
                                {'place': getSelectedIcon()});

                        _delayedPop(context);
                      },
                      child: FaIcon(
                        FontAwesomeIcons.mountain,
                        size: isMountain ? 45 : 40,
                        color: isMountain ? Colors.black : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text('산길')
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }

  String getSelectedIcon() {
    if (isRoad) {
      return 'road';
    } else if (isTrack) {
      return 'roadSpikes';
    } else if (isMountain) {
      return 'mountain';
    } else {
      return '';
    }
  }

  void _delayedPop(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pop(context);
    });
  }
}
