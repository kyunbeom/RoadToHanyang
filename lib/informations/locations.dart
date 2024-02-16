import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:road_to_hanyang/informations/routes.dart';

var JM = LatLng(37.557630, 127.041974); //정문
var HM = LatLng(37.555732, 127.049868); // 후문
var BWHM = LatLng(37.560112, 127.041757); // 병원후문
var SGD = LatLng(37.559756, 127.045564); // 사근동출입로
var GCG = LatLng(37.554009, 127.044151); // 건축관출입로

var HIS = LatLng(37.556030, 127.044768); // 역사관
var BG = LatLng(37.556637, 127.044545); // 본관
var AZ = LatLng(37.556001, 127.043843); // 애지문
var HF = LatLng(37.556588, 127.043913); // 한양플라자
var POS = LatLng(37.556913, 12.043881); // 우체국
var HSH = LatLng(37.557589, 127.044166); // 학생회관
var GJ = LatLng(37.555317, 127.044309); // 국제관
var BM = LatLng(37.555161, 127.044710); // 박물관

var JS = LatLng(37.554425, 127.044145); // 재성토목관
var GC = LatLng(37.554124, 127.044437); // 건축관
var GH = LatLng(37.554263, 127.044793); // 과학기술관
var SSJ = LatLng(37.554557, 127.045113); // 신소재공학관
var TC = LatLng(37.554801, 127.046124); // 공업센터 본관
var TCB = LatLng(37.554723, 127.046502); // 공업센터 별관
var FTC = LatLng(37.554640, 127.047347); // FTC
var NC = LatLng(37.555509, 127.045250); // 노천
var MC = LatLng(37.556247, 127.045410); // 정몽구 미래자동차 연구소
var TC2 = LatLng(37.555607, 127.046247); // 제2공학관
var TC1 = LatLng(37.556603, 127.045660); // 제1공학관

var DU = LatLng(37.555504, 127.047647); // 대운동장
var SHT = LatLng(37.555540, 127.049228); // 산학기술관
var ITBT = LatLng(37.555910, 127.049326); // IT/BT관
var OLP = LatLng(37.556522, 127.049981); // 올림픽체육관

var SH = LatLng(37.556702, 127.046762); // 생활과학관
var MU1 = LatLng(37.556597, 127.047423); // 제1음악관
var MU2 = LatLng(37.556723, 127.047213); // 제2음악관
var BNMU = LatLng(37.556302, 127.046964); // 백남음악관
var HGD = LatLng(37.556147, 127.046521); // 학군단
var BH1 = LatLng(37.556629, 127.047850); // 제1법학관
var BH2 = LatLng(37.556330, 127.047882); // 제2법학관
var BH3 = LatLng(37.556340, 127.048404); // 제3법학관
var GG = LatLng(37.556660, 127.048428); // 경제금융관
var BHH = LatLng(37.556553, 127.048126); // 법학학술정보관

var BN = LatLng(37.557399, 127.045758); // 백남학술정보관
var SSG = LatLng(37.556596, 127.045917); // 사자가 군것질 할 때
var SG = LatLng(37.557352, 127.044578); // 사회과학관
var GGJ = LatLng(37.557792, 127.044672); // 공공정책대학원
var SB = LatLng(37.558170, 127.045140); // 사범대학 본관
var SBB = LatLng(37.558369, 127.044710); // 사범대학 별관
var JY = LatLng(37.558776, 127.044324); // 자연과학대학
var IM = LatLng(37.558226, 127.043551); // 인문관

var MED1 = LatLng(37.558181, 127.042261); // 제1의학관
var MED2 = LatLng(37.558975, 127.042147); // 제2의학관
var MED = LatLng(37.558938, 127.042697); // 의과대학 본관
var DM = LatLng(37.559492, 127.041561); // 동문회관
var BWW = LatLng(37.559673, 127.043358); // 병원서관(국제병원, 장례식장)
var BW = LatLng(37.559642, 127.044001); // 병원본관
var UG = LatLng(37.559424, 127.044173); // 권역응급의료센터
var BWE = LatLng(37.559926, 127.044865); // 병원동관(류마티스병원)/신한플라자
var MR = LatLng(37.558498, 127.046344); // 미래교육관
var MEDS = LatLng(37.559409, 127.045983); // 의대계단강의동

var HIT = LatLng(37.557860, 127.046887); // HIT
var CMX = LatLng(37.557902, 127.046190); // 코맥스 스타트업타운
var CYB1 = LatLng(37.557294, 127.047177); // 한양사이버대학교 1관
var CYB2 = LatLng(37.557158, 127.047627); // 한양사이버대학교 2관
var YH = LatLng(37.558028, 127.047369); // 융합교육관
var GY = LatLng(37.558181, 127.048289); // 경영관
var HW = LatLng(37.557620, 127.048604); // 행원파크

var DOM1 = LatLng(37.559177, 127.046863); // 제1학생생활관
var DOM3 = LatLng(37.559658, 127.046748); // 제3학생생활관
var DOM5 = LatLng(37.559596, 127.045740); // 제5학생생활관
var DOM2 = LatLng(37.559749, 127.049842); // 제2학생생활관
var DOMT = LatLng(37.559451, 127.049981); // 한양테크노숙사
var GNR = LatLng(37.560023, 127.049660); // 개나리관
var HNR = LatLng(37.559638, 127.049483); // 한누리관
var GST = LatLng(37.560099, 127.049405); // 게스트하우스

var TTI = LatLng(37.556693, 127.045746); // 중도띠아모

var BUB = LatLng(37.556254, 127.048330); // 법학포탈
var B_H1 = LatLng(37.556998, 127.048356);
var B_H2 = LatLng(37.556993, 127.048346);

var EV = LatLng(37.555838, 127.047244); // 대운동장 엘베
var DUP = LatLng(37.555312, 127.048595); // 대운동장 주차장
var EVE = LatLng(37.556240, 127.046767); // 엘베 끝
var P1 = LatLng(37.556450, 127.046675);
var P2 = LatLng(37.556339, 127.046306);
var P3 = LatLng(37.556625, 127.046125);

var BGD = LatLng(37.556333, 127.044630); // 본관 옆 계단 아래
var BGU = LatLng(37.556344, 127.044928); // 본관 옆 계단 위
var ERR = LatLng(100, 100);

List<LatLng> route1 = [ITBT, DUP, EV, P1, P2, P3, TC1]; // ITBT to IG
List<LatLng> route2 = [ITBT, BUB, B_H1, B_H2, HW]; // ITBT to HW
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
      return TC1;
    case "제 2공학관":
      return EV;
    case "itbt관":
      return ITBT;
    case "행원파크":
      return HF;
    case "경제금융대학":
      return GG;
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
      return MED;
    case "공업센터":
      return TC;
    case "의대계단강의동":
      return MEDS;
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
