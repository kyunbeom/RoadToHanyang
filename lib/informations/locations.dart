import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:road_to_hanyang/informations/routes.dart';

var ITBT = LatLng(37.555965, 127.049380);
var BUB = LatLng(37.556254, 127.048330); // 법학포탈
var EF = LatLng(37.556599, 127.048039); // 경제금융관
var HP = LatLng(37.557265, 127.048480); // 행파
var IG = LatLng(37.556679, 127.045816); // 1공
var EV = LatLng(37.555838, 127.047244); // 대운동장 엘베
var DU = LatLng(37.555312, 127.048595); // 대운동장 주차장
var EVE = LatLng(37.556240, 127.046767); // 엘베 끝
var P1 = LatLng(37.556450, 127.046675);
var P2 = LatLng(37.556339, 127.046306);
var P3 = LatLng(37.556625, 127.046125);

List<LatLng> route1 = [ITBT, BUB, EF, HP]; // ITBT to HP
List<LatLng> route2 = [ITBT, DU, EV, P1, P2, P3];
List<LatLng> route3 = [ITBT, DU, EV, P1, P2, P3];
List<LatLng> route4 = [ITBT, DU, EV, P1, P2, P3];

class Route {
  final List<LatLng> location;
  final Widget routeInforms; //경로상세
  final int time; //예상소요시간

  Route(this.location, this.routeInforms, this.time);
}

List<Route> routes = [
  Route(route1, RouteInforms(RouteNumber: 1), 10),
  Route(route2, RouteInforms(RouteNumber: 2), 7),
  Route(route3, RouteInforms(RouteNumber: 3), 15)
];

LatLng getlocation(String text) {
  switch (text) {
    case "itbt관":
      return ITBT;
    case "제 1공학관":
      return IG;
    case "제 2공학관":
      return EV;
    case "itbt관":
      return ITBT;
    case "행원파크":
      return HP;
    case "공업센터":
      return EF;
    case "사자가 군것질 할 때":
      return BUB;
    case "대운동장":
      return DU;
    case "백남음악관":
      return EVE;
    case "노천극장":
      return P1;
    // 추가적인 임의의 장소에 대한 정보를 추가할 수 있습니다.
    default:
      // 디폴트로 ITBT 위치를 반환합니다.
      return ITBT;
  }
}
