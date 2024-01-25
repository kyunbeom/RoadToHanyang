import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:road_to_hanyang/informations/routes.dart';

var ITBT = LatLng(37.555965, 127.049380);
var BUB = LatLng(37.556254, 127.048330); // 법학포탈
var B_H1 = LatLng(37.556998, 127.048356);
var B_H2 = LatLng(37.556993, 127.048346);

var EF = LatLng(37.556599, 127.048039); // 경제금융관
var HP = LatLng(37.557265, 127.048480); // 행파
var IG = LatLng(37.556679, 127.045816); // 1공
var EV = LatLng(37.555838, 127.047244); // 대운동장 엘베
var DU = LatLng(37.555312, 127.048595); // 대운동장 주차장
var EVE = LatLng(37.556240, 127.046767); // 엘베 끝
var P1 = LatLng(37.556450, 127.046675);
var P2 = LatLng(37.556339, 127.046306);
var P3 = LatLng(37.556625, 127.046125);

var AZ = LatLng(37.556008, 127.043850); // 애지문
var SG = LatLng(37.557367, 127.044626); // 사과대
var BGD = LatLng(37.556333, 127.044630); // 본관 옆 계단 아래
var BGU = LatLng(37.556344, 127.044928); // 본관 옆 계단 위
var IM = LatLng(37.558161, 127.043583);
var ERR = LatLng(100, 100);

List<LatLng> route1 = [ITBT, DU, EV, P1, P2, P3, IG]; // ITBT to IG
List<LatLng> route2 = [ITBT, BUB, B_H1, B_H2, HP]; // ITBT to HP
List<LatLng> route3 = [AZ, BGD, BGU, SG, IM]; // AZ to IM
List<LatLng> route0 = [AZ, ERR]; // 에러발생

class Route {
  final List<LatLng> location;
  final Widget routeInforms; // 경로상세
  final int time; // 예상소요시간

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
    case "애지문":
      return AZ;
    case "인문대학":
      return IM;
    case "사회과학대학":
      return SG;

    default:
    // 디폴트로 ITBT 위치를 반환합니다.
      return ITBT;
  }
}
  List<LatLng> getroute(String startText, String destText){
    if(startText == "itbt관" && destText == "제 1공학관")
      return route1;
    else if(startText == "itbt관" && destText == "행원파크")
      return route2;
    else if(startText == "애지문" && destText == "인문대학")
      return route3;
    else
      return route0;
  }

