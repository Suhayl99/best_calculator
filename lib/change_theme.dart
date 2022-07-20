import 'package:flutter/material.dart';

Color curAppBarColor = appBarColor;
Color curNotActiveMenuColor = notActiveMenuColor;
Color curActiveMenuColor = activeMenuColor;
Color curBgColor = bgColor;
Color curWorkSpaceColor = workSpaceColor;
Color curOperandsBgColor = operandsBgColor;
Color curNumbersBgColor = numbersBgColor;
Color curOperandsColor = operandsColor;
Color curNumbersColor = numbersColor;
Color curFirstColor = firstColor;
Color curSecondColor = secondColor;

double crAxSize = 1;
double mnAxSize = 1;

Decoration curCalcNumPadDec = calcNumPadDec1;
Decoration curCalcOperPadDec = calcOperPadDec1;

changeThemeColor(int chosenTheme) {
  switch (chosenTheme) {
    case 1:
      curAppBarColor = appBarColor;
      curNotActiveMenuColor = notActiveMenuColor;
      curActiveMenuColor = activeMenuColor;
      curBgColor = bgColor;
      curWorkSpaceColor = workSpaceColor;
      curOperandsBgColor = operandsBgColor;
      curNumbersBgColor = numbersBgColor;
      curOperandsColor = operandsColor;
      curNumbersColor = numbersColor;
      curFirstColor = firstColor;
      curSecondColor = secondColor;
      curCalcNumPadDec = calcNumPadDec1;
      curCalcOperPadDec = calcOperPadDec1;
      crAxSize = 1;
      mnAxSize = 1;
      break;
    case 2:
      curAppBarColor = appBarColor2;
      curNotActiveMenuColor = notActiveMenuColor2;
      curActiveMenuColor = activeMenuColor2;
      curBgColor = bgColor2;
      curWorkSpaceColor = workSpaceColor2;
      curOperandsBgColor = operandsBgColor2;
      curNumbersBgColor = numbersBgColor2;
      curOperandsColor = operandsColor2;
      curNumbersColor = numbersColor2;
      curCalcNumPadDec = calcNumPadDec2;
      curCalcOperPadDec = calcOperPadDec2;
      crAxSize = 1;
      mnAxSize = 1;
      break;
    case 4:
      curAppBarColor = appBarColor4;
      curNotActiveMenuColor = notActiveMenuColor4;
      curActiveMenuColor = activeMenuColor4;
      curBgColor = bgColor4;
      curWorkSpaceColor = workSpaceColor4;
      curOperandsBgColor = operandsBgColor4;
      curNumbersBgColor = numbersBgColor4;
      curOperandsColor = operandsColor4;
      curNumbersColor = numbersColor4;
      curCalcNumPadDec = calcNumPadDec4;
      curCalcOperPadDec = calcOperPadDec4;
      crAxSize = 1;
      mnAxSize = 1;
      break;
    case 5:
      curAppBarColor = appBarColor5;
      curNotActiveMenuColor = notActiveMenuColor5;
      curActiveMenuColor = activeMenuColor5;
      curBgColor = bgColor5;
      curWorkSpaceColor = workSpaceColor5;
      curOperandsBgColor = operandsBgColor5;
      curNumbersBgColor = numbersBgColor5;
      curOperandsColor = operandsColor5;
      curNumbersColor = numbersColor5;
      curCalcNumPadDec = calcNumPadDec5;
      curCalcOperPadDec = calcOperPadDec5;
      crAxSize = 1;
      mnAxSize = 1;
      break;
    case 6:
      curAppBarColor = appBarColor6;
      curNotActiveMenuColor = notActiveMenuColor6;
      curActiveMenuColor = activeMenuColor6;
      curBgColor = bgColor6;
      curWorkSpaceColor = workSpaceColor6;
      curOperandsBgColor = operandsBgColor6;
      curNumbersBgColor = operandsColor6;
      curOperandsColor = operandsColor6;
      curNumbersColor = numbersColor6;
      curCalcNumPadDec = calcNumPadDec6;
      curCalcOperPadDec = calcOperPadDec6;
      crAxSize = 1;
      mnAxSize = 1;
      break;
    case 7:
      curAppBarColor = appBarColor7;
      curNotActiveMenuColor = notActiveMenuColor7;
      curActiveMenuColor = activeMenuColor7;
      curBgColor = bgColor7;
      curWorkSpaceColor = workSpaceColor7;
      curOperandsBgColor = operandsBgColor7;
      curNumbersBgColor = numbersBgColor7;
      curOperandsColor = operandsColor7;
      curNumbersColor = numbersColor7;
      curCalcNumPadDec = calcNumPadDec7;
      curCalcOperPadDec = calcOperPadDec7;
      crAxSize = 15;
      mnAxSize = 15;
      break;
  }
}

// Theme One

Color appBarColor = const Color(0xFF262626);
Color notActiveMenuColor = const Color(0xFF2B99A8);
Color activeMenuColor = const Color(0xFF00E0FF);
Color bgColor = const Color(0xFF000000);
Color workSpaceColor = const Color(0xFF454545);

Color operandsBgColor = const Color(0xFF262626);
Color numbersBgColor = const Color(0xFF454545);
Color operandsColor = const Color(0xFF00E0FF);
Color numbersColor = const Color(0xFFFFFFFF);

Color firstColor = const Color(0xFF454545);
Color secondColor = const Color(0xFF555454);

Decoration calcNumPadDec1 = BoxDecoration(
  color: workSpaceColor,
);
Decoration calcOperPadDec1 = BoxDecoration(
  color: appBarColor,
);

// Theme Two

Color appBarColor2 = const Color(0xFF1F2229);
Color notActiveMenuColor2 = const Color(0xFF9D6600);
Color activeMenuColor2 = const Color(0xFFFCA300);
Color bgColor2 = const Color(0xFF000000);
Color workSpaceColor2 = const Color(0xFF22262F);

Color operandsBgColor2 = const Color(0xFF1F2229);
Color numbersBgColor2 = const Color(0xFF32363F);
Color operandsColor2 = const Color(0xFFFCA300);
Color numbersColor2 = const Color(0xFFBBBBBB);

Decoration calcNumPadDec2 = BoxDecoration(
  color: workSpaceColor2,
);
Decoration calcOperPadDec2 = BoxDecoration(
  color: appBarColor2,
);

// Theme Three

Color appBarColor3 = const Color(0xFF1F2229);
Color notActiveMenuColor3 = const Color(0xFF9D6600);
Color activeMenuColor3 = const Color(0xFFFCA300);
Color bgColor3 = const Color(0xFF000000);
Color workSpaceColor3 = const Color(0xFF22262F);

Color operandsBgColor3 = const Color(0xFF1F2229);
Color numbersBgColor3 = const Color(0xFF32363F);
Color operandsColor3 = const Color(0xFFFCA300);
Color numbersColor3 = const Color(0xFFBBBBBB);

Decoration calcNumPadDec3 = BoxDecoration(
  color: workSpaceColor2,
);
Decoration calcOperPadDec3 = BoxDecoration(
  color: appBarColor2,
);

// Theme Four

Color appBarColor4 = const Color(0xFF023744);
Color notActiveMenuColor4 = const Color(0xFF5CC6CA);
Color activeMenuColor4 = const Color(0xFFC6FDFF);
Color bgColor4 = const Color(0xFF034652);
Color workSpaceColor4 = const Color(0xFF05535C);

Color operandsBgColor4 = const Color(0xFF023744);
Color numbersBgColor4 = const Color(0xFF05525D);
Color operandsColor4 = const Color(0xFFC6FDFF);
Color numbersColor4 = const Color(0xFF9EFEFF);

Decoration calcNumPadDec4 = BoxDecoration(
  color: workSpaceColor4,
);
Decoration calcOperPadDec4 = BoxDecoration(
  color: appBarColor4,
);

// Theme Five

Color appBarColor5 = const Color(0xFF161616);
Color notActiveMenuColor5 = const Color(0xFFAD0505);
Color activeMenuColor5 = const Color(0xFFFF0000);
Color bgColor5 = const Color(0xFF000000);
Color workSpaceColor5 = const Color(0xFF262626);

Color operandsBgColor5 = const Color(0xFF161616);
Color numbersBgColor5 = const Color(0xFF262626);
Color operandsColor5 = const Color(0xFFFF0000);
Color numbersColor5 = const Color(0xFFDADADA);

Decoration calcNumPadDec5 = BoxDecoration(
  color: workSpaceColor5,
);
Decoration calcOperPadDec5 = BoxDecoration(
  color: appBarColor5,
);

// Theme Six

Color appBarColor6 = const Color(0xFFCDCDCD);
Color notActiveMenuColor6 = const Color(0xFF686868);
Color activeMenuColor6 = const Color(0xFF333333);
Color bgColor6 = const Color(0xFF000000);
Color workSpaceColor6 = const Color(0xFFCDCDCD);

Color operandsBgColor6 = const Color(0xFFDCDCDC);
Color numbersBgColor6 = const Color(0xFFF1EFED);
Color operandsColor6 = const Color(0xFF333333);
Color numbersColor6 = const Color(0xFF656565);

Decoration calcNumPadDec6 = BoxDecoration(
  color: numbersBgColor6,
);
Decoration calcOperPadDec6 = BoxDecoration(
  color: operandsBgColor6,
);

// Theme Seven

Color appBarColor7 = const Color(0xFF000000);
Color notActiveMenuColor7 = const Color(0xFF959595);
Color activeMenuColor7 = const Color(0xFFFFFFFF);
Color bgColor7 = const Color(0xFF000000);
Color workSpaceColor7 = const Color(0xFF000000);

Color operandsBgColor7 = const Color(0xFF000000);
Color numbersBgColor7 = const Color(0xFF000000);
Color operandsColor7 = const Color(0xFFFFFFFF);
Color numbersColor7 = const Color(0xFFFFFFFF);

Decoration calcNumPadDec7 = BoxDecoration(
  color: workSpaceColor7,
  border: Border.all(color: Colors.white, width: 1),
  borderRadius: BorderRadius.circular(5),
  boxShadow: const [
    BoxShadow(
      color: Colors.white,
      spreadRadius: 5,
      blurRadius: 7,
    )
  ],
);
Decoration calcOperPadDec7 = BoxDecoration(
  color: appBarColor7,
  border: Border.all(color: Colors.white, width: 1),
  borderRadius: BorderRadius.circular(5),
  boxShadow: const [
    BoxShadow(
      color: Colors.white,
      spreadRadius: 5,
      blurRadius: 7,
    )
  ],
);
