import 'package:flutter/material.dart';
import 'package:sertidrive/Models/user.dart';
import 'package:sertidrive/Screens/Home/userFoldersList.dart';
import 'package:sertidrive/Shared/constants.dart';
import 'package:provider/provider.dart';

class Videos extends StatefulWidget {
  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  final _foldersObject = Folders();
  List videosFolderContent = [];

  @override
  void didChangeDependencies() async {
    String email = Provider.of<MyUserModel>(context).email;

    var items = await _foldersObject.listVideosFolderContent(email: email);

    if (items != null) {
      setState(() {
        items.forEach((element) {
          videosFolderContent.add(element);
        });
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sertidrive"),
      ),
      body: Column(
        children: <Widget>[
          curve(),
          Expanded(
            child:
                videosList(buildContext: context, folders: videosFolderContent),
          ),
        ],
      ),
    );
  }

  Widget videosList({BuildContext buildContext, List folders}) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Theme.of(context).primaryColor,
        indent: 70.0,
        thickness: 2,
        height: 8.0,
      ),
      itemCount: folders == null ? 0 : folders.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.all(10.0),
          leading: Icon(
            Icons.video_library_sharp,
            size: 40.0,
          ),
          title: Text(
              folders
                  .elementAt(index)
                  .toString()
                  .split("/")
                  .last
                  .replaceAll(")", ""),
              style: homePageTextStyle),
          onTap: () {
            print("$index WAS TAPPED !!!");
          },
        );
      },
    );
  }
}
