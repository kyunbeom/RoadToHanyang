import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late FToast fToast;

  toastMessage() {
    Widget toast = Container(
        margin: EdgeInsets.only(bottom: 380),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Color(0xff898C8E).withOpacity(0.5),
        ),
        child: Text(
          "등록되었습니다. 감사합니다:)",
          style: TextStyle(color: Colors.white),
        ));

    fToast.showToast(child: toast, toastDuration: Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          SizedBox(
            height: 80, // 제일 위 공백
          ),
          Container(
            child: Text(
              '지름길 제보',
              style: TextStyle(
                letterSpacing: 1.0,
                color: Color(0xff898C8E),
                fontSize: 30.0,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xff0E4A84),
                )),
                hintText: '경로를 상세히 입력해주세요.',
              ),
              maxLines: 10,
              style: TextStyle(fontSize: 13.0),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: TextButton(
              onPressed: () {
                toastMessage();
              },
              child: Text(
                '등록',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff0E4A84),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
