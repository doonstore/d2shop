import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d2shop/components/calender_widget.dart';
import 'package:d2shop/components/category_data.dart';
import 'package:d2shop/config/firestore_services.dart';
import 'package:d2shop/models/featured_model.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../components/search_widget.dart';

class GalleryPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalKey;
  const GalleryPage({this.globalKey});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  _GalleryPageState();

  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.bars,
                size: 20,
              ),
              onPressed: () => widget.globalKey.currentState.openDrawer(),
            ),
            centerTitle: true,
            title: Text('Home'),
            elevation: 0.0,
          ),
          bottomSheet: state.cart.isNotEmpty ? state.showCart(context) : null,
          body: SingleChildScrollView(
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
                featuredSection(),
                SizedBox(height: 5),
                categoriesSection(),
              ],
            ),
          ),
        );
      },
    );
  }

  StreamBuilder<List<FeaturedModel>> featuredSection() {
    return StreamBuilder<List<FeaturedModel>>(
      stream: listOfFeaturedHeaders,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Container(
            height: 180,
            decoration: BoxDecoration(color: Colors.grey[200]),
          );
        final List<FeaturedModel> docs = snapshot.data;

        return Container(
          height: 180,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(left: index == 0 ? 15 : 8),
                width: width(context) * 0.60,
                color: Colors.grey[100],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: docs.length == 0
                      ? Placeholder()
                      : Image.network(
                          docs[index].photoUrl,
                          fit: BoxFit.cover,
                        ),
                ),
              );
            },
            itemCount: docs.isEmpty ? 5 : docs.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }

  StreamBuilder<QuerySnapshot> categoriesSection() {
    return StreamBuilder<QuerySnapshot>(
      stream: categoryRef.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return FractionallySizedBox(
            widthFactor: 1.0,
            child: Center(
              child: SpinKitCubeGrid(color: kPrimaryColor),
            ),
          );

        final List<Category> dataList = snapshot.data.documents
            .map((e) => Category.fromJson(e.data))
            .toList();

        Provider.of<ApplicationState>(context, listen: false)
            .setCategoryList(dataList);

        double size = getSize(dataList.length);

        return Container(
          height: size,
          child: Builder(
            builder: (context) => CategoryData(dataList: dataList),
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
}
