import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sertidrive/Models/user.dart';
import 'package:sertidrive/Screens/Home/userFoldersList.dart';
import 'package:sertidrive/Screens/Others/audios.dart';
import 'package:sertidrive/Screens/Others/documents.dart';
import 'package:sertidrive/Screens/Others/uploads.dart';
import 'package:sertidrive/Services/auth.dart';
import 'package:sertidrive/Shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:sertidrive/Services/database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollPhysics homeStateListViewScrollPhysics = NeverScrollableScrollPhysics();
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
  List imagesFolderContent = [];
  List videosFolderContent = [];
  List documentsFolderContent = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String email = Provider.of<MyUserModel>(context).email;

    setLists() async {
      rootFolders = await _foldersObject.listRootFolders(email: email);
      /* imagesFolderContent =
          await _foldersObject.listImagesFolderContent(email: email); */
    }

    setState(() {
      setLists();
    });

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
                        print("BOTTOM SHEET ITEM CLICKED");
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => Upload(index: index),
                        ));
                        print(index);
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

  Widget curve() {
    return Container(
        child: Stack(
      children: <Widget>[
        //stack overlaps widgets
        Opacity(
          //semi red clipPath with more height and with 0.5 opacity
          opacity: 0.5,
          child: ClipPath(
            clipper: WaveClipper(), //set our custom wave clipper
            child: Container(
              color: Theme.of(context).primaryColor,
              height: 100,
            ),
          ),
        ),

        ClipPath(
          //upper clipPath with less height
          clipper: WaveClipper(), //set our custom wave clipper.
          child: Container(
            color: Colors.blue[800],
            height: 90,
            alignment: Alignment.center,
          ),
        ),
      ],
    ));
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
            print("$index WAS TAPPED !!!");
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
                  builder: (_) => getAudiosList(),
                ));
                break;
              case "Videos":
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => getAudiosList(),
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
}

//Custom CLipper class with Path
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}
