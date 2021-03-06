import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:d2shop/components/category_explorer.dart';
import 'package:d2shop/components/delivery_date_card.dart';
import 'package:d2shop/config/firestore_services.dart';
import 'package:d2shop/helper/side_item_info.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/route.dart';
import 'package:d2shop/utils/strings.dart';
import 'package:d2shop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isShowingPrevious = false;

  OrderModel _orderModel;

  @override
  void initState() {
    super.initState();
  }

  init() async {
    var list = await FirestoreServices().getOrdersDocument();

    OrderModel orderModel = list
        .where((element) =>
            DateTime.parse(element.deliveryDate).day ==
            DateTime.now().add(Duration(days: 1)).day)
        .first;
    setState(() {
      _orderModel = orderModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: Utils.appBar(
            context,
            title: !isShowingPrevious ? 'Orders' : 'Previous Orders',
            actions: [
              SizedBox(width: 10),
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.history,
                  color: Colors.black87,
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
          body: !isShowingPrevious
              ? Column(
                  children: [
                    if (_orderModel != null) ShowOrder(_orderModel),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: 30,
                        itemBuilder: (context, index) {
                          DateTime dateTime =
                              DateTime.now().add(Duration(days: index));
                          bool isToday = dateTime.day == DateTime.now().day;

                          if (_orderModel != null) if (index == 1)
                            return SizedBox();

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DeliveryDate(
                                dateTime: dateTime,
                                desc: isToday ? Strings.noOrders : '',
                                backroundColor: isToday,
                              ),
                              if (!isToday)
                                GestureDetector(
                                  onTap: () =>
                                      MyRoute.push(context, CategoryExplorer()),
                                  child: Container(
                                    color: Colors.white,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Row(
                                      children: [
                                        Material(
                                          shape: CircleBorder(),
                                          color: kPrimaryColor,
                                          elevation: 4.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: FaIcon(
                                              FontAwesomeIcons.plus,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: ListTile(
                                            title: Text(
                                              'ADD PRODUCT',
                                              style: GoogleFonts.ptSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: kPrimaryColor,
                                                letterSpacing: 1.1,
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
                    ),
                  ],
                )
              : StreamProvider<List<OrderModel>>.value(
                  value: FirestoreServices().getOrders,
                  builder: (context, child) {
                    List<OrderModel> _dataList =
                        Provider.of<List<OrderModel>>(context);

                    if (_dataList != null)
                      _dataList = _dataList
                          .where((element) =>
                              element.id.contains(value.user.displayName))
                          .toList();

                    return _dataList != null && _dataList.length > 0
                        ? ListView.separated(
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: _dataList.length,
                            itemBuilder: (context, index) =>
                                ShowOrder(_dataList[index]))
                        : SizedBox();
                  },
                ),
        );
      },
    );
  }
}

class ShowOrder extends StatelessWidget {
  final OrderModel orderModel;
  const ShowOrder(this.orderModel);

  @override
  Widget build(BuildContext context) {
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
                      child: CachedNetworkImage(imageUrl: item.photoUrl),
                    ),
                    title: Text("${item.name} (${item.quantityUnit})"),
                  );
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
