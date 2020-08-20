import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:d2shop/components/category_explorer.dart';
import 'package:d2shop/components/delivery_date_card.dart';
import 'package:d2shop/config/firestore_services.dart';
import 'package:d2shop/helper/side_item_info.dart';
import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isShowingPrevious = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              !isShowingPrevious ? 'Orders' : 'Previous Orders',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
            actions: [
              SizedBox(width: 10),
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.retweet,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    isShowingPrevious = !isShowingPrevious;
                  });
                },
                tooltip: 'Previous Orders',
              )
            ],
          ),
          body: isShowingPrevious
              ? StreamProvider<List<OrderModel>>.value(
                  value: getOrders,
                  builder: (context, child) => PrevoiusOrder(value.user),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    DateTime dateTime =
                        DateTime.now().add(Duration(days: index));
                    bool isToday = dateTime.day == DateTime.now().day;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DeliveryDate(
                          dateTime: dateTime,
                          desc: isToday ? 'No orders for this day' : '',
                          backroundColor: isToday,
                        ),
                        if (!isToday)
                          GestureDetector(
                            onTap: () =>
                                MyRoute.push(context, CategoryExplorer()),
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.plus,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    backgroundColor: kPrimaryColor,
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        'ADD PRODUCT',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                      ],
                    );
                  },
                ),
        );
      },
    );
  }
}

class PrevoiusOrder extends StatelessWidget {
  final DoonStoreUser user;
  const PrevoiusOrder(this.user);

  @override
  Widget build(BuildContext context) {
    List<OrderModel> _dataList = Provider.of<List<OrderModel>>(context);

    if (_dataList != null)
      _dataList = _dataList
          .where((element) => element.id.contains(user.displayName))
          .toList();

    return _dataList != null && _dataList.length > 0
        ? ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: _dataList.length,
            itemBuilder: (context, index) {
              OrderModel orderModel = _dataList[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DeliveryDate(
                    dateTime: DateTime.parse(orderModel.deliveryDate),
                    desc: 'Order Placed!',
                  ),
                  SizedBox(height: 10),
                  SideItemInfo("PENDING"),
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${orderModel.itemList.length} item(s).'),
                        SizedBox(height: 10),
                        ...orderModel.itemList.map(
                          (e) {
                            Item item = Item.fromJson(e);

                            return ListTile(
                              leading: CircleAvatar(
                                child:
                                    CachedNetworkImage(imageUrl: item.photoUrl),
                              ),
                              title:
                                  Text("${item.name} (${item.quantityUnit})"),
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          )
        : Center(child: Text(""));
  }
}
