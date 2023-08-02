import 'package:flutter/material.dart';
import 'package:road_to_hanyang/toggle.dart';

informations() {
  return Scaffold(
    body: Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Icon(
                  Icons.directions_walk,
                  color: Colors.black,
                  size: 18.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '예상 소요 시간: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.directions_walk,
                  color: Colors.black,
                  size: 18.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '평균 소요 시간: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            PathToggle(
              title: '경로 상세',
              content: Text(
                '상세한 경로들\n경로들\n경로들..',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
            Container(
              color: Colors.blue,
              child: SizedBox(
                height: 15.0,
              ),
            ),
            Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff0E4A84)),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                          TextStyle(color: Colors.white, fontSize: 23.0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)))),
                  child: const Text(
                    '시간 측정',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23.0,
                    ),
                  ),
                  onPressed: () {},
                )),
            SizedBox(
              height: 10.0,
            ),
            Container(
              alignment: Alignment.center,
              child: Container(
                  width: 250.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Color(0xff0E4A84)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.drive_file_rename_outline,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            '지름길 제보',
                            style:
                                TextStyle(color: Colors.white, fontSize: 23.0),
                            textAlign: TextAlign.center,
                            //textAlignVertical: TextAlignVertical.center,
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    ),
  );
}
/*class Informations extends StatefulWidget {
  const Informations({Key? key}) : super(key: key);

  @override
  State<Informations> createState() => _InformationsState();
}

class _InformationsState extends State<Informations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.directions_walk,
                    color: Colors.black,
                    size: 18.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    '예상 소요 시간: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.directions_walk,
                    color: Colors.black,
                    size: 18.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    '평균 소요 시간: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              PathToggle(
                title: '경로 상세',
                content: Text(
                  '상세한 경로들\n경로들\n경로들..',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
