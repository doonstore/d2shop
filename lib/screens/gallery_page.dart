import 'package:d2shop/components/calender_widget.dart';
import 'package:d2shop/components/category_explorer.dart';
import 'package:d2shop/models/featured_model.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/repository/shopping_repository.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/utils.dart';
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

  ScrollController scrollController;
  double _value = 0.0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      double value = scrollController.offset;

      setState(() {
        _value = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.bars,
                size: 25,
              ),
              onPressed: () => widget.globalKey.currentState.openDrawer(),
            ),
            centerTitle: true,
            title: _value > 95
                ? Utils.searchCard(kPrimaryColor, context)
                : Text('Home'),
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            controller: scrollController,
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

  StreamBuilder<List<Category>> categoriesSection() {
    return StreamBuilder<List<Category>>(
      stream: listOfCategories,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return FractionallySizedBox(
            widthFactor: 1.0,
            child: Center(
              child: SpinKitCubeGrid(color: kPrimaryColor),
            ),
          );

        final List<Category> dataList = snapshot.data;

        double size = getSize(dataList.length);

        return Container(
          height: size,
          child: Builder(
            builder: (context) => DataList(dataList: dataList),
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

  FutureBuilder<List<FeaturedModel>> featuredWidget() {
    return FutureBuilder<List<FeaturedModel>>(
      future: getFeaturedHeader(),
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
}
