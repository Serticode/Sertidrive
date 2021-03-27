import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class DownloadList extends StatefulWidget {
  @override
  _DownloadListState createState() => _DownloadListState();
}

class _DownloadListState extends State<DownloadList> {
  @override
  Widget build(BuildContext context) {
    final list = Provider.of<QuerySnapshot>(context);
    for (var doc in list.docs) {
      print(doc.data());
    }
    return Container();
  }
}
