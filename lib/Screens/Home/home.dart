import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sertidrive/Models/user.dart';
import 'package:sertidrive/Screens/Home/userFoldersList.dart';
import 'package:sertidrive/Screens/Others/audios.dart';
import 'package:sertidrive/Screens/Others/documents.dart';
import 'package:sertidrive/Screens/Others/images.dart';
import 'package:sertidrive/Screens/Others/uploads.dart';
import 'package:sertidrive/Screens/Others/videos.dart';
import 'package:sertidrive/Services/auth.dart';
import 'package:sertidrive/Shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:sertidrive/Services/database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final _foldersObject = Folders();

  final List<String> itemTypes = [
    "Photos",
    "Videos",
    "Audios",
    "Files",
  ];

  final List<Icon> iconTypes = [
    Icon(Icons.photo),
    Icon(Icons.video_label),
    Icon(Icons.audiotrack_sharp),
    Icon(Icons.folder),
  ];

  List rootFolders = [];

  @override
  void didChangeDependencies() async {
    String email = Provider.of<MyUserModel>(context).email;

    var items = await _foldersObject.listRootFolders(email: email);

    if (items != null) {
      setState(() {
        rootFolders.addAll(items);
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    selectFileType() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Select File"),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 30.0,
              ),
              child: ListView.separated(
                itemCount: itemTypes.length,
                separatorBuilder: (context, index) => Divider(
                  color: Theme.of(context).primaryColor,
                  indent: 40.0,
                  endIndent: 40.0,
                  thickness: 2,
                  height: 8.0,
                ),
                itemBuilder: (_, index) {
                  return Card(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 30.0,
                      ),
                      leading: iconTypes.elementAt(index),
                      title: Text(
                        itemTypes.elementAt(index),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => Upload(index: index),
                        ));
                      },
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    }

    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().userData,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sertidrive"),
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.person,
                color: Theme.of(context).iconTheme.color,
              ),
              label: Text(
                "LogOut",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            heroTag: "New Folder Button",
            elevation: 20.0,
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              Icons.create_new_folder,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              //ADD NEW FOLDER
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          FloatingActionButton(
            heroTag: "Cloud Upload Button",
            elevation: 20.0,
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              Icons.cloud_upload,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              selectFileType();
            },
          )
        ]),
        body: Column(
          children: <Widget>[
            curve(),
            Expanded(
              child: baseList(buildContext: context, folders: rootFolders),
            ),
          ],
        ),
      ),
    );
  }

  Widget baseList({BuildContext buildContext, List folders}) {
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
            Icons.folder_sharp,
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
            switch (folders
                .elementAt(index)
                .toString()
                .split("/")
                .last
                .replaceAll(")", "")) {
              case "Audios":
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => getAudiosList(),
                ));
                break;
              case "Documents":
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => getDocumentsList(),
                ));
                break;
              case "Images":
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => getImagesList(),
                ));
                break;
              case "Videos":
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => getVideosList(),
                ));
                break;
              default:
                print("Nothing Important Clicked");
            }
          },
        );
      },
    );
  }

  Widget getAudiosList() => Audios();
  Widget getDocumentsList() => Documents();
  Widget getImagesList() => Images();
  Widget getVideosList() => Videos();
}
