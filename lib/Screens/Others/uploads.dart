import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sertidrive/Models/user.dart';
import 'package:sertidrive/Services/database.dart';
import 'package:sertidrive/Services/storage.dart';
import 'package:sertidrive/Shared/constants.dart';
import 'package:provider/provider.dart';

class Upload extends StatefulWidget {
  final int index;
  Upload({this.index});
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  Set<String> selectedFileNames;
  List<File> _selectedFiles = [];
  List<int> fileSizesInBytes = [];
  StorageService _storage = StorageService();
  FileType fileType;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Upload oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUserModel>(context);
    TextStyle textStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    );

    var snackBar = SnackBar(
      content: Text(
        "${_selectedFiles.length} item(s) Uploaded",
        textAlign: TextAlign.center,
        style: scaffoldMessengerTextStyle,
      ),
      padding: EdgeInsets.all(5.0),
      backgroundColor: Theme.of(context).primaryColor,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sertidrive",
          style: textStyle.copyWith(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () async {
              if (fileType == FileType.image) {
                _storage
                    .uploadImage(email: user.email, files: _selectedFiles)
                    .whenComplete(() async {
                  try {
                    await DatabaseService(email: user.email)
                        .updateUserData(noOfImages: _selectedFiles.length);
                  } catch (e) {
                    print("$e from UPLOAD ICON !!");
                  }
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              } else if (fileType == FileType.video) {
                _storage
                    .uploadVideos(email: user.email, files: _selectedFiles)
                    .whenComplete(() async {
                  try {
                    await DatabaseService(email: user.email)
                        .updateUserData(noOfVideos: _selectedFiles.length);
                  } catch (e) {
                    print("$e from UPLOAD ICON !!");
                  }
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              } else if (fileType == FileType.audio) {
                _storage
                    .uploadAudios(email: user.email, files: _selectedFiles)
                    .whenComplete(() async {
                  try {
                    await DatabaseService(email: user.email)
                        .updateUserData(noOfAudios: _selectedFiles.length);
                  } catch (e) {
                    print("$e from UPLOAD ICON !!");
                  }
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              } else if (fileType == FileType.custom) {
                _storage
                    .uploadDocuments(email: user.email, files: _selectedFiles)
                    .whenComplete(() async {
                  try {
                    await DatabaseService(email: user.email)
                        .updateUserData(noOfFiles: _selectedFiles.length);
                  } catch (e) {
                    print("$e from UPLOAD ICON !!");
                  }
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              } else {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "No Valid Item Selected",
                    textAlign: TextAlign.center,
                    style: scaffoldMessengerTextStyle,
                  ),
                  padding: EdgeInsets.all(5.0),
                  backgroundColor: Theme.of(context).primaryColor,
                ));
              }
            },
            icon: Icon(
              Icons.cloud_upload_sharp,
              color: Theme.of(context).iconTheme.color,
            ),
            label: Text(
              "Upload",
              style: textStyle.copyWith(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
      body: (widget.index == 0)
          ? GridView.builder(
              itemCount: (selectedFileNames == null)
                  ? 1
                  : (selectedFileNames.length +
                      1), //1 + selectedFileNames.length,
              /*USING +1 ABOVE ^ BECAUSE INDEX 0 IS ALREADY
        RESERVED BY THE ADD ICON; HENCE "_IMAGES" CONTENT
        STARTS FROM NEXT INDEX */
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (_, index) {
                return index == 0
                    ? Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Theme.of(context).primaryColor,
                            size: 30.0,
                          ),
                          onPressed: () {
                            setState(() {
                              fileType = FileType.image;
                            });
                            _selectFile(type: FileType.image);
                            print(selectedFileNames);
                          },
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.all(3.0),
                        decoration: (fileType == FileType.image)
                            ? BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(
                                    File(_selectedFiles
                                        .elementAt(index - 1)
                                        .path),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : BoxDecoration(color: Colors.white),
                      );
              },
            )
          : ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Theme.of(context).primaryColor,
                indent: 40.0,
                endIndent: 40.0,
                thickness: 2,
                height: 10.0,
              ),
              itemCount: (selectedFileNames == null)
                  ? 1
                  : (selectedFileNames.length + 1),
              itemBuilder: (_, index) {
                return index == 0
                    ? Container(
                        color: Colors.blue[200],
                        padding: EdgeInsets.all(20.0),
                        child: GestureDetector(
                          child: Row(
                            children: [
                              IconButton(
                                  alignment: Alignment.center,
                                  icon: Icon(
                                    Icons.add,
                                    color: Theme.of(context).primaryColor,
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    switch (widget.index) {
                                      case 1:
                                        setState(() {
                                          fileType = FileType.video;
                                        });
                                        break;
                                      case 2:
                                        setState(() {
                                          fileType = FileType.audio;
                                        });
                                        break;
                                      case 3:
                                        setState(() {
                                          fileType = FileType.custom;
                                        });
                                        break;
                                      default:
                                        print("NO VALID FILE TYPE");
                                    }
                                  }),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                "Select Files",
                                style: textStyle,
                              ),
                            ],
                          ),
                          onTap: () {
                            print("OTHER FILES ADD ICON PRESSED");
                            switch (widget.index) {
                              case 1:
                                _selectFile(type: FileType.video);
                                break;
                              case 2:
                                _selectFile(type: FileType.audio);
                                break;
                              case 3:
                                _selectFile(type: FileType.custom);
                                break;
                              default:
                                print("NO VALID FILE TYPE");
                            }
                          },
                        ),
                      )
                    : ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 30.0),
                        onTap: () {
                          //DO SOMETHING !!
                        },
                        title: Text(
                          selectedFileNames.elementAt(index - 1),
                          style: textStyle.copyWith(color: Colors.black87),
                        ),
                        subtitle: Text(
                          formatBytes(
                              bytes: fileSizesInBytes.elementAt(index - 1),
                              toDecimalPlaces: 2),
                          style: textStyle.copyWith(
                            fontSize: 15.0,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                          ),
                          onPressed: () {
                            print("ELEMENT DELETE BUTTON PRESSED !");
                            setState(() {
                              selectedFileNames.remove(
                                  selectedFileNames.elementAt(index - 1));
                              _selectedFiles.removeAt(index - 1);
                            });
                          },
                        ),
                      );
              },
            ),
    );
  }

  void _selectFile({FileType type}) async {
    FilePickerResult result = type != FileType.custom
        ? await FilePicker.platform.pickFiles(
            allowMultiple: true,
            type: type,
          )
        : await FilePicker.platform.pickFiles(
            allowMultiple: true,
            type: type,
            allowedExtensions: [
              'doc',
              'docx',
              'xls',
              'xlsx',
              'ppt',
              'pptx',
              'pdf',
              'txt',
              'zip',
              'rar',
              'apk',
              'rtf',
            ],
          );
    if (result != null) {
      setState(() {
        fileType = type;
        try {
          _selectedFiles = result.paths.map((path) => File(path)).toList();
          selectedFileNames = result.names.toSet();

          result.files.forEach((element) {
            fileSizesInBytes.add(element.size);
          });
        } catch (e) {
          print(e);
        }
      });
    } else {
      // User canceled the picker
    }
  }
}
