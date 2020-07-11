import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryList extends StatefulWidget {
  final ApplicationState state;

  CategoryList.name(this.state);

  @override
  _CategoryListState createState() => _CategoryListState(state);
}

class _CategoryListState extends State<CategoryList> {
  ApplicationState state;

  _CategoryListState(this.state);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView(
        children: getCategoryGridItems(),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  List<Widget> getCategoryGridItems() {
    var color = 0xffd4ebf2;
    List<Widget> categoryWidgetList = List();
    if (state.categoryList != null) {
      for (Category category in state.categoryList) {
        categoryWidgetList.add(Container(
          decoration: BoxDecoration(
              color: Color(color), borderRadius: BorderRadius.circular(5)),
          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
          padding: EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () {
              Fluttertoast.showToast(
                msg: category.name + " pressed",
                toastLength: Toast.LENGTH_SHORT,
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  category.photoUrl,
                  height: 110,
                ),
                SizedBox(
                  width: 14,
                ),
                Text(
                  category.name,
                  style: TextStyle(fontSize: 15),
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
