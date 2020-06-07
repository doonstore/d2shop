import 'package:flutter/material.dart';

class Account_Screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => account();
}

class account extends State<Account_Screen> {
  String username = 'Abhishek';
  String mobilenumber = '8437166707';
  String eid = 'abhishekgarg5800@gmail.com';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Icon ofericon = new Icon(
      Icons.edit,
      color: Colors.black38,
    );
    Icon keyloch = new Icon(
      Icons.vpn_key,
      color: Colors.black38,
    );
    Icon bell = new Icon(
      Icons.hearing,
      color: Colors.black38,
    );
    Icon logout = new Icon(
      Icons.do_not_disturb_on,
      color: Colors.black38,
    );
    Icon address = new Icon(
      Icons.location_city,
      color: Colors.black38,
    );

    Icon privacy = new Icon(
      Icons.priority_high,
      color: Colors.black38,
    );
    Icon cookie = new Icon(
      Icons.priority_high,
      color: Colors.black38,
    );

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
                  new Container(
                    margin: EdgeInsets.all(7.0),
                    alignment: Alignment.topCenter,
                    height: 260.0,
                    child: new Card(
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          new Container(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: 100.0,
                                height: 100.0,
                                margin: const EdgeInsets.all(10.0),
                                // padding: const EdgeInsets.all(3.0),
                                child: ClipOval(
                                  child: Image.network(
                                      'https://www.fakenamegenerator.com/images/sil-female.png'),
                                ),
                              )),

                          new FlatButton(
                            onPressed: null,
                            child: Text(
                              'Change',
                              style:
                              TextStyle(fontSize: 13.0, color: Colors.blueAccent),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                                side: BorderSide(color: Colors.blueAccent)),
                          ),

                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.only(
                                    left: 10.0, top: 20.0, right: 5.0, bottom: 5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    new Text(
                                      username,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    _verticalDivider(),
                                    new Text(
                                      mobilenumber,
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5),
                                    ),
                                    _verticalDivider(),
                                    new Text(
                                      eid,
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5),
                                    )
                                  ],
                                ),
                              ),
                              new Container(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                    icon: ofericon,
                                    color: Colors.blueAccent,
                                    onPressed: null),
                              )
                            ],
                          ),
                          // VerticalDivider(),
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.all(7.0),
                    child: Card(
                      elevation: 1.0,
                      child: Row(
                        children: <Widget>[
                          new IconButton(icon: address, onPressed: null),
                          _verticalD(),
                          new Text(
                            'Address',
                            style: TextStyle(fontSize: 15.0, color: Colors.black87),
                          )
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.all(7.0),
                    child: Card(
                      elevation: 1.0,
                      child: Row(
                        children: <Widget>[
                          new IconButton(icon: bell, onPressed: null),
                          _verticalD(),
                          new Text(
                            'Doorbell Settings',
                            style: TextStyle(fontSize: 15.0, color: Colors.black87),
                          )
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.all(7.0),
                    child: Card(
                      elevation: 1.0,
                      child: Row(
                        children: <Widget>[
                          new IconButton(icon: keyloch, onPressed: null),
                          _verticalD(),
                          new Text(
                            'Change Password',
                            style: TextStyle(fontSize: 15.0, color: Colors.black87),
                          )
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.all(7.0),
                    child: Card(
                      elevation: 1.0,
                      child: Row(
                        children: <Widget>[
                          new IconButton(icon: privacy, onPressed: null),
                          _verticalD(),
                          new Text(
                            'Privacy policy',
                            style: TextStyle(fontSize: 15.0, color: Colors.black87),
                          )
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.all(7.0),
                    child: Card(
                      elevation: 1.0,
                      child: Row(
                        children: <Widget>[
                          new IconButton(icon: cookie, onPressed: null),
                          _verticalD(),
                          new Text(
                            'Cookie policy',
                            style: TextStyle(fontSize: 15.0, color: Colors.black87),
                          )
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.all(7.0),
                    child: Card(
                      elevation: 1.0,
                      child: Row(
                        children: <Widget>[
                          new IconButton(icon: logout, onPressed: null),
                          _verticalD(),
                          new Text(
                            'Log out ',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.redAccent,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
          )
      ),
    );
  }

  _verticalDivider() => Container(
    padding: EdgeInsets.all(2.0),
  );

  _verticalD() => Container(
    margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
  );


}
