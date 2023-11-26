import 'package:flutter/material.dart';

class RunningMemoScreen extends StatefulWidget {
  final String memoText;
  final Function(String) onMemoChanged;
  const RunningMemoScreen({
    super.key,
    required this.memoText,
    required this.onMemoChanged,
  });

  @override
  State<RunningMemoScreen> createState() => _RunningMemoScreenState();
}

class _RunningMemoScreenState extends State<RunningMemoScreen> {
  final TextEditingController _memoController = TextEditingController();

  @override
  void initState() {
    _memoController.text = widget.memoText;
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
                '메모',
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                  onPressed: () {
                    widget.onMemoChanged(_memoController.text);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '완료',
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ),
          TextField(
            controller: _memoController,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: '메모를 입력하세요...',
              border: InputBorder.none, // 테두리 없음
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _memoController.dispose();
    super.dispose();
  }
}
