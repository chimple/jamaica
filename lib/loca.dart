import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'l10n/messages_all.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Loca {
  static Future<Loca> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return Loca();
    });
  }

  static Loca of(BuildContext context) {
    return Localizations.of<Loca>(context, Loca);
  }

  String intl(String name) => Intl.message(name, name: name);
  String get zero => Intl.message('Zero', name: 'zero');
  String get one => Intl.message('One', name: 'one');
  String get two => Intl.message('Two', name: 'two');
  String get three => Intl.message('Three', name: 'three');
  String get four => Intl.message('Four', name: 'four');
  String get five => Intl.message('Five', name: 'five');
  String get six => Intl.message('Six', name: 'six');
  String get seven => Intl.message('Seven', name: 'seven');
  String get eight => Intl.message('Eight', name: 'eight');
  String get nine => Intl.message('Nine', name: 'nine');
  String get ten => Intl.message('Ten', name: 'ten');
  String get eleven => Intl.message('Eleven', name: 'eleven');
  String get twelve => Intl.message('Twelve', name: 'twelve');
  String get thirteen => Intl.message('Thirteen', name: 'thirteen');
  String get fourteen => Intl.message('Fourteen', name: 'fourteen');
  String get fifteen => Intl.message('Fifteen', name: 'fifteen');
  String get sixteen => Intl.message('Sixteen', name: 'sixteen');
  String get seventeen => Intl.message('Seventeen', name: 'seventeen');
  String get eighteen => Intl.message('Eighteen', name: 'eighteen');
  String get nineteen => Intl.message('Nineteen', name: 'nineteen');
  String get twenty => Intl.message('Twenty', name: 'twenty');
  String get twentyOne => Intl.message('Twenty One', name: 'twentyOne');
  String get twentyTwo => Intl.message('Twenty Two', name: 'twentyTwo');
  String get twentyThree => Intl.message('Twenty Three', name: 'twentyThree');
  String get twentyFour => Intl.message('Twenty Four', name: 'twentyFour');
  String get twentyFive => Intl.message('Twenty Five', name: 'twentyFive');
  String get twentySix => Intl.message('Twenty Six', name: 'twentySix');
  String get twentySeven => Intl.message('Twenty Seven', name: 'twentySeven');
  String get twentyEight => Intl.message('Twenty Eight', name: 'twentyEight');
  String get twentyNine => Intl.message('Twenty Nine', name: 'twentyNine');
  String get d0 => Intl.message('0', name: 'd0');
  String get d1 => Intl.message('1', name: 'd1');
  String get d2 => Intl.message('2', name: 'd2');
  String get d3 => Intl.message('3', name: 'd3');
  String get d4 => Intl.message('4', name: 'd4');
  String get d5 => Intl.message('5', name: 'd5');
  String get d6 => Intl.message('6', name: 'd6');
  String get d7 => Intl.message('7', name: 'd7');
  String get d8 => Intl.message('8', name: 'd8');
  String get d9 => Intl.message('9', name: 'd9');
  String get plus => Intl.message('plus', name: 'plus');
  String get minus => Intl.message('minus', name: 'minus');
  String get forParents => Intl.message('For Parents', name: 'forParents');
  String get submit => Intl.message('Submit', name: 'submit');
  String get whatWillBe => Intl.message('What will be', name: 'whatWillBe');
}

class LocaDelegate extends LocalizationsDelegate<Loca> {
  const LocaDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi'].contains(locale.languageCode);

  @override
  Future<Loca> load(Locale locale) => Loca.load(locale);

  @override
  bool shouldReload(LocaDelegate old) => false;
}

class FallbackMaterialLocalisationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      DefaultMaterialLocalizations.load(locale);

  @override
  bool shouldReload(FallbackMaterialLocalisationsDelegate old) => false;
}
