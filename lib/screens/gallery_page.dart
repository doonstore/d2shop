import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d2shop/components/calender_widget.dart';
import 'package:d2shop/components/category_explorer.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../components/search_widget.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  _GalleryPageState();

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, state, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchWidget(),
              CalenderWidget(),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  'Featured',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              featuredWidget(),
              SizedBox(height: 5),
              FutureBuilder<QuerySnapshot>(
                future: categoryRef.getDocuments(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return FractionallySizedBox(
                      widthFactor: 1.0,
                      child: Center(
                        child: SpinKitCubeGrid(color: kPrimaryColor),
                      ),
                    );
                  final List<DocumentSnapshot> docs = snapshot.data.documents;

                  double size = getSize(docs.length);

                  return Container(
                    height: size,
                    child: Builder(
                      builder: (context) {
                        List<Category> dataList =
                            docs.map((e) => Category.fromJson(e.data)).toList();
                        return DataList(dataList: dataList);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  double getSize(int length) {
    if (length < 3)
      return 150;
    else if (length >= 3 && length < 6)
      return 300;
    else if (length >= 6 && length < 9)
      return 600;
    else if (length >= 9 && length < 12)
      return 800;
    else if (length >= 12 && length < 15)
      return 1200;
    else
      return 150;
  }

  FutureBuilder<QuerySnapshot> featuredWidget() {
    return FutureBuilder<QuerySnapshot>(
      future: featuredRef.getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return FractionallySizedBox(
            widthFactor: 1.0,
            child: Center(
              child: SpinKitCubeGrid(color: kPrimaryColor),
            ),
          );
        final List<DocumentSnapshot> docs = snapshot.data.documents;

        return Container(
          height: 180,
          child: ListView.builder(
            itemBuilder: (context, index) {
              // final FeaturedModel featured =
              //     FeaturedModel.fromJSON(docs[index].data);

              return Container(
                margin: EdgeInsets.only(left: index == 0 ? 15 : 8),
                width: width(context) * 0.60,
                color: Colors.grey[100],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: docs.length == 0
                      ? Placeholder()
                      : Image.network(
                          docs[index].data['photoUrl'],
                          fit: BoxFit.cover,
                        ),
                ),
              );
            },
            itemCount: docs.length == 0 ? 5 : docs.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }
}
