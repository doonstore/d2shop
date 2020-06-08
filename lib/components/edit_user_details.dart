import 'package:flutter/material.dart';

class EditUserDetails {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 25.0),
                Column(
                  children: <Widget>[
                    Text(
                      "Profile Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                ListTile(
                  title: TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                        hintText: "Full name",
                        icon: Icon(Icons.person_outline),
                        border: InputBorder.none),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "The name field cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                ListTile(
                  title: TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                        hintText: "Email",
                        icon: Icon(Icons.alternate_email),
                        border: InputBorder.none),
                  ),
                ),
                ListTile(
                  title: TextFormField(
                    enabled: false,
                    controller: _phoneNumber,
                    decoration: InputDecoration(
                        hintText: "8437166707",
                        icon: Icon(Icons.phone),
                        border: InputBorder.none),
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {},
                  color: Colors.lightBlueAccent,
                  child: Text("Update Details",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0)),
                ),
              ],
            ),
          );
        });
  }
}
