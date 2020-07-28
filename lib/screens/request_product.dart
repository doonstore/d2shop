import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestProduct extends StatefulWidget {
  @override
  _RequestProductState createState() => _RequestProductState();
}

class _RequestProductState extends State<RequestProduct> {
  TextEditingController textEditingController;

  bool enabled = false;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    textEditingController.addListener(() {
      if (textEditingController.text.isNotEmpty)
        setState(() => enabled = true);
      else
        setState(() => enabled = false);
    });
  }

  submit() {
    String userId = Provider.of<ApplicationState>(context).user.userId;
    Map<String, dynamic> data = {
      'user': userId,
      'date': DateTime.now().toString(),
      'info': textEditingController.text.trim()
    };

    requestRef.add(data).then((value) {
      Utils.showMessage('Your request has been successfully submitted');
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.appBar(
        context,
        title: 'Request a product(s)',
        backgroudColor: Colors.white,
        color: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Give us some details of the product(s) you want on {APP NAME}',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            SizedBox(height: 15),
            Text(
              'Describe the product(s)',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              height: 200,
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type here',
                ),
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.words,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Example: Amul Butter',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.black38,
              ),
            ),
            SizedBox(height: 10),
            Utils.basicBtn(
              context,
              text: 'Submit',
              onTap: enabled ? submit : null,
            )
          ],
        ),
      ),
    );
  }
}
