import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../screen/map_sample.dart';

class InquiryBoard extends StatefulWidget {
  const InquiryBoard({Key? key}) : super(key: key);

  @override
  State<InquiryBoard> createState() => _InquiryBoardState();
}

class _InquiryBoardState extends State<InquiryBoard> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController inquiryController = TextEditingController();
  final CollectionReference _inquiriesCollection =
      FirebaseFirestore.instance.collection('inquiries');

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xff0E4A84),
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Center(
                child: Text('문의', style: TextStyle(color: Colors.white))),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MapSample()),
                      (route) => false, // 모든 이전 화면 흔적을 제거
                    );
                  },
                  icon: Icon(Icons.home))
            ]),
        body: Stack(children: [
          Column(children: [
            //SizedBox(height: 20),
            // Expanded(
            //     child: StreamBuilder<QuerySnapshot>(
            //   stream: _inquiriesCollection.snapshots(),
            //   builder: (context, snapshot) {
            //     if (!snapshot.hasData) {
            //       return CircularProgressIndicator();
            //     }
            //     var inquiries = snapshot.data!.docs;
            //     List<Widget> inquiryWidgets = [];
            //     for (var inquiry in inquiries) {
            //       var inquiryText = inquiry['text'];
            //       var inquiryWidget = ListTile(
            //         title: Text(inquiryText),
            //       );
            //       inquiryWidgets.add(inquiryWidget);
            //     }
            //     return ListView(
            //       children: inquiryWidgets,
            //     );
            //   },
            // )),
            Container(
              padding: const EdgeInsets.all(15),
              child: Expanded(
                child: TextFormField(
                  controller: inquiryController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText: '문의사항을 입력하세요',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff0E4A84)))),
                  maxLines: 10,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ),
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff0E4A84)),
                onPressed: () {
                  toastMessage();
                  addInquiry();
                },
                child: const Text('등록',
                    style: TextStyle(color: Colors.white, fontSize: 14)))
          ]),
        ]));
  }

  void addInquiry() {
    if (inquiryController.text.isNotEmpty) {
      _inquiriesCollection.add({'text': inquiryController.text});
      inquiryController.clear();
    }
  }

  toastMessage() {
    Widget toast = Container(
        margin: const EdgeInsets.only(bottom: 520),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color(0xff0E4A84).withOpacity(0.5),
        ),
        child: const Text(
          "등록되었습니다. 감사합니다:)",
          style: TextStyle(color: Colors.white),
        ));

    fToast.showToast(child: toast, toastDuration: const Duration(seconds: 2));
  }
}
