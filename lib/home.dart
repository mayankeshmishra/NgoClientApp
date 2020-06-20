import 'package:flutter/material.dart';
import './posts.dart';
import './ui_components/bottom_app_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:donations/helpers/constants.dart';

class HomePage extends StatefulWidget {
  HomePage();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Posts> postsList = [];
  BottomAppBarClass appBar = BottomAppBarClass();
  @override
  void initState() {
    super.initState();

    DatabaseReference postsRef =
        FirebaseDatabase.instance.reference().child("Posts");
    postsRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      postsList.clear();

      for (var indivisualKey in KEYS) {
        Posts posts;
        if (DATA[indivisualKey].containsKey('link')) {
          posts = Posts(
            DATA[indivisualKey]['image'],
            DATA[indivisualKey]['description'],
            DATA[indivisualKey]['date'],
            DATA[indivisualKey]['time'],
            DATA[indivisualKey]['link'],
          );
        } else {
          posts = Posts(
            DATA[indivisualKey]['image'],
            DATA[indivisualKey]['description'],
            DATA[indivisualKey]['date'],
            DATA[indivisualKey]['time'],
            '',
          );
        }

        postsList.add(posts);
      }
      setState(() {
        print('Length:$postsList.length');
      });
    });
  }

  Widget PostsUI(
      String image, String description, String date, String time, String link) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            link != ''
                ? Text('EVENT',
                    style: TextStyle(color: Colors.pink,fontSize: 18,fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  )
                : Text('POST',
                    style: TextStyle(color: Colors.pink,fontSize: 18,fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  date,
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  time,
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            SizedBox(height: 10),
            FittedBox(
              child: CachedNetworkImage(
                imageUrl: image,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              fit: BoxFit.fill,
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 13, color:Color(0xFF9e9e9e)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            link != ''
                ? Text('Volunteering link : $link',
                    style: TextStyle(color: Colors.pink,fontSize: 15),
                    textAlign: TextAlign.left,
                  )
                : SizedBox(
                    height: 0,
                  ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: gradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: postsList.length == 0
              ? Center(child: Text("No Posts to show"))
              : ListView.builder(
                  itemCount: postsList.length,
                  itemBuilder: (_, index) {
                    return PostsUI(
                      postsList[index].image,
                      postsList[index].description,
                      postsList[index].date,
                      postsList[index].time,
                      postsList[index].link,
                    );
                  }),
        ),
        bottomNavigationBar: appBar.getAppBar(context: context),
      ),
    );
  }
}
