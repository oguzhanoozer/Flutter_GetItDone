import 'package:flutter/material.dart';
import 'package:getitdone/models/colorThemeData.dart';
import 'package:getitdone/models/item_data.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

import './screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ColorThemeData().createPrefObject();
  await ItemData().createPrefeObje();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ItemData>(
        create: (BuildContext context) => ItemData()),
    ChangeNotifierProvider<ColorThemeData>(
        create: (context) => ColorThemeData())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Provider.of<ColorThemeData>(context).loadThemeFromSharePref();
    //Provider.of<ItemData>(context).loadItemsFromSharePref();

    return Consumer2<ItemData, ColorThemeData>(
        builder: (context, itemData, colorThemeData, child) {
      itemData.loadItemsFromSharePref();
      colorThemeData.loadThemeFromSharePref();

      return MaterialApp(
        title: 'Flutter Demo',
        theme: Provider.of<ColorThemeData>(context).selectedTheme,
        home: _SplashWidget(),
      );
    });
  }
}

class _SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new HomePage(),
        title: new Text('Get It Done'),
        image: new Image.asset('assets/ok.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader:
            new TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        photoSize: 100.0,
        loaderColor: Colors.green);
  }
}
