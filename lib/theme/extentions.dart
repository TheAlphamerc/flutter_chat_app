import 'package:flutter/material.dart';
import 'package:flutter_chat_app/theme/dark_clolor.dart';

extension TextStyleHelpers on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get white => copyWith(color: Colors.white);
  TextStyle get lighGrey => copyWith(color: DarkColor.lightGrey);
  TextStyle get dimWhite => copyWith(color: DarkColor.dimWhite);
  TextStyle letterSpace(double value) => copyWith(letterSpacing: value);
}

extension PaddingHelper on Widget {
  Padding get p16 => Padding(padding: EdgeInsets.all(16), child: this);

  /// Set padding according to `value`
  Padding p(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Horizontal Padding 16
  Padding get hP16 =>
      Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: this);

  /// Vertical Padding 16
  Padding get vP16 =>
      Padding(padding: EdgeInsets.symmetric(vertical: 16), child: this);
  Padding get vP8 =>
      Padding(padding: EdgeInsets.symmetric(vertical: 8), child: this);
  Padding get vP4 =>
      Padding(padding: EdgeInsets.symmetric(vertical: 8), child: this);
}

extension Extented on Widget {
  Expanded get extended => Expanded(
        child: this,
      );
}
extension CornerRadius on Widget {
  ClipRRect get circular=> ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(1000)),
    child: this,
  );
}
extension OnPressed on Widget {
  Widget  ripple(Function onPressed, {BorderRadiusGeometry borderRadius =const BorderRadius.all(Radius.circular(5))}) => Stack(
      children: <Widget>[
        this,
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius
            ),
              onPressed: () {
                if (onPressed != null) {
                  onPressed();
                }
              },
              child: Container()),
        )
      ],
    );
}