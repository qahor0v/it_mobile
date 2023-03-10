import 'package:flutter/material.dart';
import 'package:video_urok/main.dart';
import 'package:video_urok/models/course_classes.dart';
import 'package:video_urok/screens/lessons_screens/lessons.dart';
import '../../screens/lessons_screens/main_screen.dart';

class Dizayn extends StatefulWidget {
  const Dizayn({Key? key}) : super(key: key);

  @override
  State<Dizayn> createState() => _DizaynState();
}

class _DizaynState extends State<Dizayn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass().mainColor(),
      body: CustomScrollView(slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 12,
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500.0,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 2.50,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LessonPage(
                              playListName: Design.playListName[index],
                              playListId: Design.playListId[index],
                              videoCount: Design.videoCount[index],
                          title: Design.names[index],
                            )),
                  );
                },
                child: MainScreen(
                  lessonCount: Design.playListName[index].length,
                  videoCount: totalCount(Design.videoCount[index]),
                  lessonName: Design.names[index],
                  imgUrl: Design.imageUrl[index],
                  navigator: null,
                ),
              );
            },
            childCount: Design.imageUrl.length,
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 120,
          ),
        ),
      ]),
    );
  }
  totalCount(List<int> list) {
    int total = 0;

    for (int i in list) {
      total += i;

    }
    return total;
  }
}
