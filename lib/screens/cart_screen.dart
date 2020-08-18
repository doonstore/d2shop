import 'package:animations/animations.dart';
import 'package:d2shop/components/delivery_date_card.dart';
import 'package:d2shop/components/item_info.dart';
import 'package:d2shop/config/firestore_services.dart';
import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/screens/my_account.dart';
import 'package:d2shop/screens/wallet_screen.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/route.dart';
import 'package:d2shop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Duration addOneDay = Duration(days: 1);

  num fee = 3,
      cartLength,
      payableAmount,
      amountToAdd = 0,
      walletAvailableBalance;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  openCheckout(ApplicationState state) {
    setState(() {
      loading = true;
    });

    DoonStoreUser user = state.user;
    int newAmount = user.wallet - payableAmount;
    String desc = '';
    List<Map> itemList = [];
    List<num> noOfProducts = [];

    state.cart.forEach((key, value) {
      itemList.add((value['item'] as Item).toJson());
    });

    state.cart.forEach((key, value) {
      Item item = value['item'] as Item;
      desc += '${item.name} (${item.quantityUnit}) * ${value['quantity']}\n';
      noOfProducts.add(value['quantity'] as num);
    });

    Map<String, Object> data = getWalletMap(
        '$cartLength Item${cartLength > 1 ? 's' : ''} - Ordered',
        desc,
        payableAmount,
        newAmount,
        TransactionType.Debited);

    user.transactions.add(data);
    user.wallet -= payableAmount;

    OrderModel orderModel = OrderModel(
      id: "${user.displayName}_${DateTime.now().millisecondsSinceEpoch}",
      user: user.toMap(),
      total: payableAmount,
      itemList: itemList,
      deliveryDate: state.deliveryDate.toString(),
      orderDate: DateTime.now().toString(),
      noOfProducts: noOfProducts,
    );

    placeOrder(orderModel).then((value) {
      userRef.document(user.userId).updateData(user.toMap()).then((value) {
        Provider.of<ApplicationState>(context, listen: false).setUser(user);
        Provider.of<ApplicationState>(context, listen: false).clearCart();
        if (Navigator.canPop(context)) Navigator.pop(context);
        Utils.showMessage("Your order has been successfully placed.");
      });
    });
  }

  init() async {
    fee = await serviceFee;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now().add(addOneDay);
    if (dateTime.hour > 22 && dateTime.hour <= 23) dateTime.add(addOneDay);

    return Consumer<ApplicationState>(builder: (context, value, child) {
      cartLength = value.cart.length;
      payableAmount = value.getCurrentPrice().toInt() + fee;

      walletAvailableBalance = value.getWalletAmount() - fee;
      if (walletAvailableBalance < 0) walletAvailableBalance = 0;

      if (value.getWalletAmount() <= 0)
        amountToAdd = payableAmount.toDouble() - value.user.wallet;
      else
        amountToAdd = 0;

      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            icon: FaIcon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Cart ($cartLength Item${cartLength > 1 ? 's' : ''})',
            style: TextStyle(color: Colors.black),
          ),
        ),
        bottomSheet: Container(
          height: 60,
          color: Colors.white,
          padding: EdgeInsets.all(8),
          child: Center(
            child: loading
                ? SpinKitFadingCircle(color: kPrimaryColor)
                : value.user.address.isEmpty
                    ? Utils.basicBtn(
                        context,
                        text: 'Add Address',
                        onTap: () => MyRoute.push(context, AccountScreen()),
                      )
                    : value.user.wallet >= payableAmount
                        ? Utils.basicBtn(
                            context,
                            text: 'Place Order',
                            onTap: () => openCheckout(value),
                          )
                        : Utils.basicBtn(
                            context,
                            text: 'Add $rupeeUniCode$amountToAdd to Wallet',
                            onTap: () => MyRoute.push(
                              context,
                              WalletScreen(
                                fromCart: true,
                                amount: amountToAdd.toDouble(),
                              ),
                            ),
                          ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NotificationHeader(
                heading:
                    'Earliest delivery date ${DateFormat.MMMEd().format(dateTime)}.',
                desc:
                    'Thank you for choosing Doon Store. We take a day to verify your address on your first delivery to ensure smooth deliveries in the future.',
              ),
              NotificationHeader(
                heading: 'Review delivery date(s)',
                desc:
                    'Due to high demand, some items may not be available earlier',
              ),
              SizedBox(height: 10),
              DeliveryDate(
                dateTime: dateTime,
                desc: 'Nothing scheduled on this date yet',
              ),
              SizedBox(height: 15),
              ArrivingBy(),
              SizedBox(height: 15),
              ...value.cart.values.toList().map(
                (e) {
                  Item item = e['item'];
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[200]),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        ItemInfo(item: item, isCart: true),
                        Container(
                          width: width(context),
                          height: 40,
                          color: kPrimaryColor.withOpacity(0.1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialButton(
                                onPressed: () => deleteDialog(value, item),
                                child: Text('Delete'),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      child: IconButton(
                                        icon: FaIcon(
                                          FontAwesomeIcons.minus,
                                          color: Colors.black54,
                                        ),
                                        onPressed: () =>
                                            value.removeItemFromTheCart(item),
                                      ),
                                    ),
                                    Text(
                                      '${e['quantity'].toInt()}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Flexible(
                                      child: IconButton(
                                        icon: FaIcon(
                                          FontAwesomeIcons.plus,
                                          color: Colors.black54,
                                        ),
                                        onPressed: () =>
                                            value.addItemToTheCart(item),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[200], width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.teal.withOpacity(0.1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Got a coupon card?',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          MaterialButton(
                            elevation: 0.0,
                            onPressed: () {},
                            child: Text('APPLY'),
                            textColor: kPrimaryColor,
                            color: Colors.teal[100].withOpacity(0.1),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    text('Cart amount',
                        '$rupeeUniCode${value.getCurrentPrice()}'),
                    text('Service fee', '$rupeeUniCode$fee'),
                    Divider(height: 5, color: Colors.black54),
                    text('Amount to pay', '$rupeeUniCode$payableAmount'),
                    Divider(height: 5, color: Colors.black54),
                    text('Wallet available balance',
                        '$rupeeUniCode$walletAvailableBalance'),
                    text('Amount to add', '$rupeeUniCode$amountToAdd'),
                    SizedBox(height: 60),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  ListTile text(String title, String desc) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 5),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        desc,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    );
  }

  deleteDialog(ApplicationState value, Item e) {
    showModal(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Are you sure to remove this item?'),
        children: [
          SimpleDialogOption(
            child: Center(
              child: Text(
                'NO',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          SimpleDialogOption(
            child: Center(
              child: Text(
                'YES',
                style: TextStyle(
                    color: Colors.redAccent, fontWeight: FontWeight.w500),
              ),
            ),
            onPressed: () {
              value.removeItemFromTheCart(e, full: true);
              if (value.cart.length > 1)
                Navigator.pop(context);
              else {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }
}

class NotificationHeader extends StatelessWidget {
  const NotificationHeader({Key key, this.heading, this.desc})
      : super(key: key);

  final String heading, desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade100.withOpacity(0.5),
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          SizedBox(height: 4),
          Text(
            desc,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}

class ArrivingBy extends StatelessWidget {
  const ArrivingBy({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: kPrimaryColor, width: 2),
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
      ),
      child: Text(
        'ARRIVING BY 9 AM',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
