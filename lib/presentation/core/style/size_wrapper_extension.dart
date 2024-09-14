import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizeWrapperExtension on num {
  ///[ScreenUtil.setWidth]
  double get w => ScreenUtil().setWidth(this);

  ///[ScreenUtil.setHeight]
  double get h => ScreenUtil().setHeight(this);

  ///[ScreenUtil.radius]
  double get r => ScreenUtil().radius(this);

  ///[ScreenUtil.diagonal]
  double get dg => ScreenUtil().diagonal(this);

  ///[ScreenUtil.diameter]
  double get dm => ScreenUtil().diameter(this);

  ///[ScreenUtil.setSp]
  double get sp => ScreenUtil().setSp(this);

  ///屏幕宽度的倍数
  ///Multiple of screen width
  double get sw => ScreenUtil().screenWidth * this;

  ///屏幕高度的倍数
  ///Multiple of screen height
  double get sh => ScreenUtil().screenHeight * this;
}
