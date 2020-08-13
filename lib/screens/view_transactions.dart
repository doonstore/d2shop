import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ViewTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'All transactions',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: FaIcon(FontAwesomeIcons.chevronLeft),
            onPressed: () => Navigator.pop(context),
            color: Colors.black,
          ),
        ),
        body: ListView.builder(
          itemCount: value.user.transactions.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data = value.user.transactions[index];

            return Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data['title'],
                          style: GoogleFonts.ptSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '${data['type'] == 'Credited' ? '+' : '-'} $rupeeUniCode${data['amount']}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: data['type'] == 'Credited'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data['desc'],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black45,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(
                          'Updated balance $rupeeUniCode${data['newBalance']}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black45,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    DateFormat.yMMMMEEEEd()
                        .format(DateTime.parse(data['date'])),
                    style: GoogleFonts.ptSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color.fromRGBO(153, 153, 153, 1.0),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
