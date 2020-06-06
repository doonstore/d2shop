import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      body: GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.fromLTRB(10,125,10,0),
        crossAxisCount: 3,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: getCategoryGridItems(),
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
              color: Color(color), borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                category.photoUrl,
                width: 42,
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                category.name,
                style: TextStyle(
                    fontSize: 15
                ),
              )
            ],
          ),
        ));
      }
    }
    return categoryWidgetList;
  }
}
