import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/components/edit_address.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'edit_user_details.dart';

class AccountScreen extends StatefulWidget {
  final ApplicationState state;

  AccountScreen({this.state});

  @override
  State<StatefulWidget> createState() => Account(state: state);
}

class Account extends State<AccountScreen> {
  final ApplicationState state;

  EditUserDetails editUserDetails = new EditUserDetails();

  Account({this.state});

  @override
  Widget build(BuildContext context) {
    //List<address> addresLst = loadAddress() as List<address> ;
    return new Scaffold(
      appBar: new AppBar(
        title: Text(
          'My Account',
        ),
      ),
      body: new Container(
          child: SingleChildScrollView(
              child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: <Widget>[
          const SizedBox(height: 30.0),
          Row(
            children: <Widget>[
              /*Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: new ExactAssetImage('assets/iconsPerson.png'),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(color: Colors.grey,width: 1.0,),
                        ),
                      ), */
              const SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      state.user != null ? state.user.displayName : "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          ListTile(
            title: Text("Address"),
            subtitle: Text(
                state.user != null && state.user.getAddressList().length > 0
                    ? state.user.getAddressList()[0]
                    : "No address on record"),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey.shade400,
            ),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> AddressScreen())),
          ),
          ListTile(
            title: Text("Profile Settings"),
            subtitle: Text(state.user != null ? state.user.email : ""),
            isThreeLine: true,
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey.shade400,
            ),
            onTap: () => editUserDetails.mainBottomSheet(context),
          ),
          SwitchListTile(
            title: Text("Doorbell Settings"),
            subtitle: Text(state.user != null && state.user.doorBellStatus
                ? "Ring door bell"
                : "Don't ring door bell"),
            value: state.user != null ? state.user.doorBellStatus : false,
            onChanged: (val) {
              setState(() {
                state.user.doorBellStatus = val;
              });
            },
          ),
          ListTile(
            title: Text("Privacy Policy"),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey.shade400,
            ),
            onTap: () {
              Fluttertoast.showToast(
                  msg:
                      "We respect your privacy. We don't store any data that is not essential for our working.",
                  toastLength: Toast.LENGTH_LONG);
            },
          ),
          ListTile(
            title: Text("Cookie Policy"),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey.shade400,
            ),
            onTap: () {
              Fluttertoast.showToast(
                  msg:
                      "We don't use tracking cookies. We don't share usage data with anyone.",
                  toastLength: Toast.LENGTH_LONG);
            },
          ),
        ],
      ))),
    );
  }
}
