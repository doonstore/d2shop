import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  TextEditingController amountTEC;

  static const String rupeeUniCode = '\u20b9';

  final List<String> suggestionList = [
    '$rupeeUniCode 500',
    '$rupeeUniCode 1000',
    '$rupeeUniCode 2000'
  ];

  bool upi = true, card = false;

  @override
  void initState() {
    super.initState();
    amountTEC = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallet',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.chevronLeft,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomSheet: Container(
        height: 60,
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Center(
          child: Utils.basicBtn(
            context,
            text: 'ADD MONEY',
            onTap: () => Utils.showMessage('ADD MONEY', basic: true),
          ),
        ),
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
                  '\u20b90.0',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
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
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
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
                      hintText: '1000',
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
            paymentMode(
              title: 'Preferred payment',
              desc: 'Easy checkout',
              cartTitle: 'UPI',
              cartDesc: 'Instant payment using UPI app',
              first: true,
              oTap: () => this.setState(() => upi = !upi),
            ),
            paymentMode(
              title: 'Other payment modes',
              desc: 'Cards, Wallets and Netbanking',
              cartTitle: 'Credit / Debit / ATM Cards',
              cartDesc: 'Visa, Masterpay, RuPay & more',
              oTap: () => this.setState(() => card = !card),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Material paymentMode(
      {String title,
      String desc,
      String cartTitle,
      String cartDesc,
      Function oTap,
      bool first = false}) {
    return Material(
      color: Colors.grey[100],
      child: ExpansionTile(
        initiallyExpanded: true,
        leading: FaIcon(FontAwesomeIcons.star),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          desc,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
        children: [
          Material(
            color: Colors.white,
            child: ListTile(
              onTap: oTap,
              leading: first
                  ? FaIcon(
                      upi
                          ? FontAwesomeIcons.solidCheckCircle
                          : FontAwesomeIcons.checkCircle,
                      color: kPrimaryColor,
                    )
                  : FaIcon(
                      card
                          ? FontAwesomeIcons.solidCheckCircle
                          : FontAwesomeIcons.checkCircle,
                      color: kPrimaryColor,
                    ),
              title: Text(
                cartTitle,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                cartDesc,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
