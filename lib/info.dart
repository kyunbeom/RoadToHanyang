import 'package:flutter/material.dart';
import 'package:road_to_hanyang/report.dart';
import 'package:road_to_hanyang/toggle.dart';
import 'package:road_to_hanyang/watch.dart';

informations(BuildContext context) {
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
              height: 30.0,
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
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff0E4A84),
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 23.0),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 30.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StopwatchApp()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.timer,
                          color: Colors.white,
                          size: 23.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text('시간 측정'),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff0E4A84),
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 23.0),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 30.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0))),
                    onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ReportPage()))
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.drive_file_rename_outline,
                          color: Colors.white,
                          size: 23.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text('지름길 제보'),
                      ],
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
