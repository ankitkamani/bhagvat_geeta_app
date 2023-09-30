import 'package:bhagvat_geeta_mobile_app/Controllers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Modals/Details Modal.dart';

class ChapterDetailsScreen extends StatefulWidget {
  final int index;
  final String title;
  final int verses;
  final List<DetailsModal> chapterDetails;

  const ChapterDetailsScreen(
      {super.key,
      required this.index,
      required this.title,
      required this.verses,
      required this.chapterDetails});

  @override
  State<ChapterDetailsScreen> createState() => _ChapterDetailsScreenState();
}

class _ChapterDetailsScreenState extends State<ChapterDetailsScreen> {
  @override
  void initState() {
    Provider.of<DataProvider>(context, listen: false)
        .loadVerse(widget.index, 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return DefaultTabController(
      length: widget.verses + 1,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: (value) {
              if (value != 0) {
                Provider.of<DataProvider>(context, listen: false)
                    .loadVerse(widget.index, value);
              }
            },
            isScrollable: true,
            tabs: List.generate(widget.verses + 1, (index) {
              return Tab(text: index == 0 ? 'Summary' : 'verse $index');
            }),
          ),
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Tab(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                    child: Text(
                        dataProvider.slokType == 3
                            ? dataProvider.chapterDetails[widget.index - 1]
                                    .meaning?.en ??
                                ''
                            : dataProvider.chapterDetails[widget.index - 1]
                                    .meaning?.hi ??
                                '',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        dataProvider.slokType == 3
                            ? dataProvider.chapterDetails[widget.index - 1]
                                    .summary?.en ??
                                ''
                            : dataProvider.chapterDetails[widget.index - 1]
                                    .summary?.hi ??
                                '',
                        style: const TextStyle(fontSize: 16)),
                  ),
                ],
              )),
              ...List.generate(widget.verses, (index) {
                String slokTranslate = dataProvider.slokType == 1
                    ? dataProvider.fullChapter.venkat?.sc ?? ''
                    : dataProvider.slokType == 2
                        ? dataProvider.fullChapter.chinmay?.hc ?? ''
                        : dataProvider.fullChapter.siva?.et ?? '';
                return Tab(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  dataProvider.fullChapter.slok ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0)
                                    .copyWith(bottom: 20),
                                child: Text(slokTranslate,
                                    style: const TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          left: 0,
                          child: IconButton(
                              onPressed: () {
                                Provider.of<DataProvider>(context,
                                        listen: false)
                                    .addToFav(
                                        dataProvider.fullChapter.slok ?? '');
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Slok Added to Favourite list'),));
                              },
                              icon: const Icon(Icons.favorite)))
                    ],
                  ),
                );
              }),
            ]),
      ),
    );
  }
}
