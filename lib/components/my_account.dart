import 'package:flutter/material.dart';

import 'edit_user_details.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Account();
}

class Account extends State<AccountScreen> {
  String username = 'Abhishek Garg';
  String mobileNumber = '8437166707';
  String eid = 'abhishekgarg5800@gmail.com';
  String appartmentName = "XYZ Apartment";

  EditUserDetails editUserDetails = new EditUserDetails();
  
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
                            Text(username, style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  ListTile(
                    title: Text("Address"),
                    subtitle: Text(appartmentName),
                    trailing: Icon(Icons.keyboard_arrow_right,color: Colors.grey.shade400,),
                    onTap: null,
                  ),
                  ListTile(
                    title: Text("Profile Settings"),
                    subtitle: Text(username +", " + mobileNumber + " " + eid ),
                    isThreeLine: true,
                    trailing: Icon(Icons.keyboard_arrow_right,color: Colors.grey.shade400,),
                    onTap: () => editUserDetails.mainBottomSheet(context),
                  ),
                  SwitchListTile(
                    title: Text("Doorbell Settings"),
                    subtitle: Text("off"),
                    value: true,
                    onChanged: (val){},
                  ),
                  ListTile(
                    title: Text("Privacy Policy"),
                    trailing: Icon(Icons.keyboard_arrow_right,color: Colors.grey.shade400,),
                    onTap: (){},
                  ),
                  ListTile(
                    title: Text("Cookie Policy"),
                    trailing: Icon(Icons.keyboard_arrow_right,color: Colors.grey.shade400,),
                    onTap: (){},
                  ),
                  ListTile(
                    title: Text("Logout"),
                    trailing: Icon(Icons.do_not_disturb_on,color: Colors.grey.shade400,),
                    onTap: (){},
                  ),
                ],
              )
          )
      ),
    );
  }
}
