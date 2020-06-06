import 'package:d2shop/components/gallery_page.dart';
import 'package:flutter/material.dart';
void main() => runApp(DoonStoreApp());

class DoonStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DoonStore',
      home: GalleryPage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
