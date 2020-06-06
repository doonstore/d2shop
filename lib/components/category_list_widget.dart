import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryList extends StatefulWidget {
  final ApplicationState state;

  const CategoryList({Key key, this.state}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState(state);
}

class _CategoryListState extends State<CategoryList> {
  ApplicationState state;

  _CategoryListState(this.state);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: getCategoryGridItems(),
    );
  }

  List<Widget> getCategoryGridItems() {
    List<Widget> categoryWidgetList = List();
    if (state.categoryList != null) {
      for (Category category in state.categoryList) {
        categoryWidgetList.add(GestureDetector(
          onTap: () {
            Fluttertoast.showToast(msg: 'Clicked on ${category.name}');
          },
          child: Card(
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 115,
                  child: Image(
                    image: AssetImage(category.photoUrl),
                  ),
                ),
                ListTile(
                  title: Text(category.name),
                  subtitle: Text(category.isFeatured
                      ? 'Featured Category'
                      : 'Popular Category'),
                )
              ],
            ),
          ),
        ));
      }
    }
    return categoryWidgetList;
  }
}
