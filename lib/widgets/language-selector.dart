import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fusewallet/generated/i18n.dart';

class LanguageSelector extends StatefulWidget {
  @override
  _LanguageSelectorState createState() => new _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  int _key;

  @override
  void initState() {
    super.initState();
    _collapse();
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(context);
  }

  List<Widget> _languageItems() {
    List<Widget> list = [];
    final _transl = I18n.of(context);

    I18n.delegate.supportedLocales.forEach((lang) {
      list.add(new ListTile(
        title: new Text(lang.languageCode),
        trailing: Localizations.localeOf(context).languageCode == lang.languageCode
            ? new Icon(Icons.check, color: Colors.green)
            : null,
        selected: false, //_transl.currentLanguage == lang,
        onTap: () {
           //I18n.._locale.locale(new Locale("he"));
          I18n.onLocaleChanged(new Locale(lang.languageCode, lang.countryCode));
            //applic.onLocaleChanged(new Locale(lang.languageCode, ''));
            setState(() {
              _collapse();
            });
        },
      ));
    });

    return list;
  }

  Widget _buildTiles(BuildContext context) {
    return new ExpansionTile(
      key: new Key(_key.toString()),
      initiallyExpanded: false,
      title: new Row(
        children: [new Text("Language", style: TextStyle(fontSize: 16))],
      ),
      children: _languageItems(),
    );
  }

  _collapse() {
    int newKey;
    do {
      _key = new Random().nextInt(10000);
    } while (newKey == _key);
  }
}