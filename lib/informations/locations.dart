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
var IM = LatLng(37.558161, 127.043583); // 인문관
var ERR = LatLng(100, 100);

var HF = LatLng(37.556570, 127.043927); //한플
var BN = LatLng(37.557325, 127.045706); //백남학술정보관
var ME = LatLng(37.558948, 127.042687); // 의과대학본관
var TC = LatLng(37.554745, 127.046128); // 공업센터
var MES = LatLng(37.559410, 127.045985); // 의대계단강의동
var SSJ = LatLng(37.554489, 127.045257); // 신소재공학관

var DOM1 = LatLng(37.559182, 127.046853); // 1생
var DOM2 = LatLng(37.559795, 127.049817); // 2생
var SH = LatLng(37.556703, 127.046779); // 생활과학관
var HIT = LatLng(37.557722, 127.046948);

var SSG = LatLng(37.556590, 127.045920); //싸군
var OL = LatLng(37.556509, 127.049958); //올체
var HI = LatLng(37.556271, 127.044832); // 역사관
var STU = LatLng(37.557589, 127.044182); // 학생회관
var TTI = LatLng(37.556687, 127045754); //중도띠아모
var ST = LatLng(37.554279, 127.044786); // 과학기술관
var FTC = LatLng(37.554655, 127.047289);
var NF = LatLng(37.558543, 127.046293); // 간호학부 미래교육관
var NC = LatLng(37.555892, 127.045466); // 노천

List<LatLng> route1 = [ITBT, DU, EV, P1, P2, P3, IG]; // ITBT to IG
List<LatLng> route2 = [ITBT, BUB, B_H1, B_H2, HP]; // ITBT to HP
List<LatLng> route3 = [AZ, BGD, BGU, SG, IM]; // AZ to IM
List<LatLng> route0 = [AZ, ERR]; // 에러발생

class Route {
  final int num;
  final List<LatLng> location;
  final Widget routeInforms; // 경로상세
  final int time; // 예상소요시간

  Route(this.num, this.location, this.routeInforms, this.time);
}

List<Route> routes = [
  Route(0, route0, RouteInforms(RouteNumber: 0), 0),
  Route(1, route1, RouteInforms(RouteNumber: 1), 10),
  Route(2, route2, RouteInforms(RouteNumber: 2), 7),
  Route(3, route3, RouteInforms(RouteNumber: 3), 15)
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
    case "경제금융대학":
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
    case "한양플라자":
      return HF;
    case "백남학술정보관":
      return BN;
    case "의과대학 본관":
      return ME;
    case "공업센터":
      return TC;
    case "의대계단강의동":
      return MES;
    case "신소재공학관":
      return SSJ;

    default:
      // 디폴트로 ITBT 위치를 반환합니다.
      return ITBT;
  }
}

Route getroute(String startText, String destText) {
  if (startText == "itbt관" && destText == "제 1공학관")
    return routes[1];
  else if (startText == "itbt관" && destText == "행원파크")
    return routes[2];
  else if (startText == "애지문" && destText == "인문대학")
    return routes[3];
  else
    return routes[0];
}

List<String> suggestions = [
  "제 1공학관",
  "제 2공학관",
  "itbt관",
  "행원파크",
  "경제금융대학",
  "사자가 군것질 할 때",
  "대운동장",
  "백남음악관",
  "노천극장",
  "애지문",
  "사회과학대학",
  "인문대학",
  "한양플라자",
  "백남학술정보관",
  "의과대학 본관",
  "공업센터",
  "의대계단강의동",
  "신소재공학관"
      "에러발생"
];

List<String> printSuggestions = [
  "itbt관",
  "한양플라자",
  "백남학술정보관",
  "제 1공학관",
  "인문대학",
  "의과대학 본관",
  "경제금융대학",
  "공업센터",
  "의대계단강의동",
  "신소재공학관"
];
