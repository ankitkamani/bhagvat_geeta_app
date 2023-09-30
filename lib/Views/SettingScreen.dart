import 'package:bhagvat_geeta_mobile_app/Controllers/DataProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'),centerTitle: true,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                const Expanded(child: Text('Selected Language',style: TextStyle(fontSize: 18),)),
                SizedBox(
                  child: DropdownButton(
                    value: Provider.of<DataProvider>(context,listen: true).slokType,
                    items: const [
                      DropdownMenuItem(value: 1,child: Text('Sanskrit')),
                      DropdownMenuItem(value: 2,child: Text('Hindi')),
                      DropdownMenuItem(value: 3,child: Text('English')),
                  ], onChanged: (value) {
                    Provider.of<DataProvider>(context,listen: false).changeLang(value as int);
                  },),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                const Expanded(child: Text('Selected Theme Mode',style: TextStyle(fontSize: 18),)),
                SizedBox(
                  child: DropdownButton(
                    value: Provider.of<DataProvider>(context).themeMode,
                    items: const [
                      DropdownMenuItem(value: ThemeMode.light,child: Text('Light Mode')),
                      DropdownMenuItem(value: ThemeMode.dark,child: Text('Dark Mode')),
                      DropdownMenuItem(value: ThemeMode.system,child: Text('System Default')),
                  ], onChanged: (value) {
                    Provider.of<DataProvider>(context,listen: false).changeTheme(value as ThemeMode);
                  },),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
