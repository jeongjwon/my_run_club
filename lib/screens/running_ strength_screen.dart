import 'package:flutter/material.dart';
import 'package:my_run_club/provider/task_provider.dart';
import 'package:my_run_club/widgets/running.dart';
import 'package:provider/provider.dart';

class RunningStrengthScreen extends StatefulWidget {
  final int strengthValue;
  final Function(int) onStrengthChanged;
  final String documentId;
  const RunningStrengthScreen({
    super.key,
    required this.strengthValue,
    required this.onStrengthChanged,
    required this.documentId,
  });

  @override
  State<RunningStrengthScreen> createState() => _RunningStrengthScreenState();
}

class _RunningStrengthScreenState extends State<RunningStrengthScreen> {
  late double _currentSliderValue;

  @override
  void initState() {
    _currentSliderValue = (widget.strengthValue * 10).toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 50),
              const Text(
                '러닝 강도',
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                  onPressed: () {
                    Provider.of<TaskProvider>(context, listen: false)
                        .updateTask(widget.documentId,
                            {'strength': _currentSliderValue.round() ~/ 10});

                    Navigator.pop(context);
                  },
                  child: const Text(
                    '완료',
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            '러닝 강도는 어땠나요?',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Slider(
            value: _currentSliderValue,
            divisions: 10,
            max: 100,
            label: (_currentSliderValue.round() ~/ 10).toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
              widget.onStrengthChanged(_currentSliderValue.round() ~/ 10);
            },
          ),
          const SizedBox(
            height: 30,
          ),
          strengthList(currentSliderValue: _currentSliderValue)
        ],
      ),
    );
  }
}

class strengthList extends StatelessWidget {
  const strengthList({
    super.key,
    required double currentSliderValue,
  }) : _currentSliderValue = currentSliderValue;

  final double _currentSliderValue;

  @override
  Widget build(BuildContext context) {
    List<List<String>> strength = [
      ['극도로 가벼운', '가벼운 스트레칭 수준'],
      ['매우 낮음', '천천히 걷는 수준'],
      ['낮음', '돌아다니면서 편안하게 호흡할 수 있는 수준'],
      ['보통', '대화를 나눌 수 있는 가벼운 운동 수준'],
      ['상당함', '호흡이 거칠어지고 심박수가 증가하는 수준'],
      ['어려움', '대화가 버거우며 호흡이 어려운 수준'],
      ['높음', '대화가 어려우며 운동이 힘든 수준'],
      ['매우 높음', '호흡이 힘들며 전신이 지치는 수준'],
      ['극도로 어려움', '대화가 불가능하며 한계에 다다른 수준'],
      ['최대치', '일을 할 수 없을 정도의 가장 힘든 수준'],
      ['최대치', '일을 할 수 없을 정도의 가장 힘든 수준'],
    ];

    double index = _currentSliderValue / 10.0;

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            index.round().toString(),
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            strength[index.toInt()][0],
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(strength[index.toInt()][1]),
        ],
      ),
    );
  }
}
