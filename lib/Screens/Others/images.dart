import 'package:flutter/material.dart';
import 'package:sertidrive/Models/user.dart';
import 'package:sertidrive/Screens/Home/userFoldersList.dart';
import 'package:sertidrive/Shared/constants.dart';
import 'package:provider/provider.dart';

class Images extends StatefulWidget {
  @override
  _ImagesState createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  final _foldersObject = Folders();
  List imagesFolderContent = [];

  @override
  void initState() {
    imagesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String email = Provider.of<MyUserModel>(context).email;

    setLists() async {
      imagesFolderContent =
          await _foldersObject.listImagesFolderContent(email: email);
    }

    setState(() {
      setLists();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Sertidrive"),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: imagesList(context: context, folders: imagesFolderContent),
      ),
    );
  }

  Widget imagesList({BuildContext context, List folders}) {
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
            Icons.photo_sharp,
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
