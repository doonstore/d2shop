import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemListWidget extends StatefulWidget {
  final ApplicationState state;

  const ItemListWidget({Key key, this.state}) : super(key: key);

  @override
  _ItemListWidget createState() => _ItemListWidget(state);
}

class _ItemListWidget extends State<ItemListWidget> {
  final ApplicationState state;

  _ItemListWidget(this.state);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getListItems(),
    );
  }

  List<Widget> getListItems() {
    List<Widget> itemList = List();
    if (state.itemList != null) {
      for (Item item in state.itemList) {
        itemList.add(ListTile(
          leading: Image(image: AssetImage(item.photoUrl)),
          title: Text(item.name),
          trailing: getQuantityScale(item.id),
        ));
      }
    }
    return itemList;
  }

  Widget getQuantityScale(String itemId) {
    return SizedBox(
      width: 116,
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              if (state.cart[itemId] != null && state.cart[itemId] != 0) {
                setState(() {
                  state.cart[itemId] -= 1;
                });
              }
            },
            icon: Icon(Icons.remove_circle_outline),
          ),
          Text(
              state.cart[itemId] == null ? '0' : state.cart[itemId].toString()),
          IconButton(
            onPressed: () {
              if (state.cart[itemId] != null && state.cart[itemId] < 13) {
                setState(() {
                  state.cart[itemId] += 1;
                });
              } else if (state.cart[itemId] == null) {
                setState(() {
                  state.cart[itemId] = 1;
                });
              }
            },
            icon: Icon(Icons.add_circle_outline),
          )
        ],
      ),
    );
  }
}
