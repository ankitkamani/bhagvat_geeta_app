
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../Controllers/DataProvider.dart';
import 'ChapterDetailsScreen.dart';
import 'FavSlocks.dart';
import 'SettingScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Provider.of<DataProvider>(context, listen: false).getThemeMode();
    Provider.of<DataProvider>(context, listen: false).loadHomeData();
    Provider.of<DataProvider>(context, listen: false).getLang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavSlok(),
                    ));
              },
              icon: const Icon(Icons.favorite,color: Colors.red,)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingScreen(),
                    ));
              },
              icon: const Icon(Icons.settings))
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title,
            style: const TextStyle(fontWeight: FontWeight.w500)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Consumer<DataProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.chapterDetails.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: ChapterDetailsScreen(
                                    chapterDetails: value.chapterDetails,
                                    verses: value.chapterDetails[index]
                                        .versesCount ??
                                        0,
                                    title:
                                    value.chapterDetails[index].name ?? '',
                                    index: index + 1,
                                  )));
                        },
                        child: ListTile(
                          title: Text(value.chapterDetails[index].name ?? ''),
                          subtitle: Text(
                              value.chapterDetails[index].translation ?? ''),
                          leading: Text(
                            'अध्याय ${index + 1}',
                            style: const TextStyle(fontSize: 13),
                          ),
                          trailing: const Icon(CupertinoIcons.forward),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
