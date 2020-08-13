import 'package:d2shop/config/secrets.dart';
import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/screens/view_transactions.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/route.dart';
import 'package:d2shop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class WalletScreen extends StatefulWidget {
  final bool fromCart;
  final double amount;
  const WalletScreen({this.fromCart = false, this.amount});

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  TextEditingController amountTEC;

  Razorpay _razorpay;

  final List<String> suggestionList = [
    '$rupeeUniCode 500',
    '$rupeeUniCode 1000',
    '$rupeeUniCode 2000'
  ];

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    amountTEC = TextEditingController(text: widget.amount?.toString() ?? '');

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    DoonStoreUser doonStoreUser =
        Provider.of<ApplicationState>(context, listen: false).user;

    num amount = int.parse(amountTEC.text);
    num newAmount = doonStoreUser.wallet + amount;

    Map<String, Object> data = getWalletMap(
        'Wallet refill',
        'Payment ID: ' + response.paymentId,
        amount,
        newAmount,
        TransactionType.Credited);

    doonStoreUser.transactions.add(data);
    doonStoreUser.wallet += amount;

    userRef
        .document(doonStoreUser.userId)
        .updateData(doonStoreUser.toMap())
        .then((value) {
      Utils.showMessage("Wallet credited with $rupeeUniCode $amount amount.");
      Provider.of<ApplicationState>(context, listen: false)
          .setUser(doonStoreUser);
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Utils.showMessage('Payment Failed: ${response.message}', error: true);
  }

  openCheckout(int amount) {
    DoonStoreUser doonStoreUser =
        Provider.of<ApplicationState>(context, listen: false).user;

    Map<String, Object> options = {
      'key': RAZOPRPAY_KEY,
      'amount': amount,
      'name': 'Doon Store',
      'description': 'Description',
      'prefill': {'contact': doonStoreUser.phone, 'email': doonStoreUser.email}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      Utils.showMessage(e, basic: true);
      _razorpay.clear();
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Wallet',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: widget.fromCart
              ? IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.times,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                )
              : null,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                color: kPrimaryColor.withOpacity(0.2),
                child: ListTile(
                  title: Text(
                    'Wallet Balance',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  subtitle: Text(
                    '$rupeeUniCode ${value.user.wallet}',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  trailing: value.user.transactions.isNotEmpty
                      ? FlatButton(
                          onPressed: () =>
                              MyRoute.push(context, ViewTransactions()),
                          textColor: kPrimaryColor,
                          child: Text('All transactions'),
                        )
                      : FlatButton(
                          onPressed: null,
                          textColor: kPrimaryColor,
                          child: Text('No transactions'),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add money to Wallet',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    Text(
                      'We suggest an average balance of \u20b91000.0',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: amountTEC,
                      keyboardType: TextInputType.number,
                      style: Utils.formTextStyle(),
                      decoration: InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.rupeeSign),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...suggestionList.map(
                          (e) => MaterialButton(
                            elevation: 0,
                            onPressed: () => this.setState(
                                () => amountTEC.text = e.split(' ').last),
                            textColor: Colors.grey,
                            color: Colors.grey[200],
                            child: Text(e),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                width: width(context),
                color: Colors.white,
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Utils.basicBtn(
                    context,
                    text: 'ADD MONEY',
                    onTap: () {
                      if (amountTEC.text.isNotEmpty) {
                        int amount = int.parse(amountTEC.text) * 100;

                        openCheckout(amount);
                      } else
                        Utils.showMessage(
                            "Please enter some amount to contiue.",
                            error: true);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
