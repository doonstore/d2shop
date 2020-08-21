import 'package:d2shop/config/firestore_services.dart';
import 'package:d2shop/models/chat_model.dart';
import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController _tec = TextEditingController();

  void sendMessage(BuildContext context) {
    if (_tec.text.isNotEmpty) {
      DoonStoreUser user =
          Provider.of<ApplicationState>(context, listen: false).user;

      SupportMessages supportMessages = SupportMessages(
        id: Uuid().v4(),
        dateTime: DateTime.now().toString(),
        from: user.userId,
        to: 'support',
        isUser: true,
        message: _tec.text,
        userId: user.userId,
      );

      sendMessageToSupport(supportMessages).then((value) {
        Utils.showMessage("Our support team will get back to you shortly.",
            basic: true);
        _tec.text = '';
        _tec.clear();
      });
    } else
      Utils.showMessage("Please write something.", error: true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Support',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        bottomSheet: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          height: 80,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _tec,
                  decoration:
                      Utils.inputDecoration("Type your message...", hint: ""),
                  style: Utils.formTextStyle(),
                ),
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.paperPlane),
                onPressed: () => sendMessage(context),
              )
            ],
          ),
        ),
        body: StreamProvider<List<SupportMessages>>.value(
          value: getMessages(value.user.userId),
          builder: (context, child) {
            List<SupportMessages> chatList =
                Provider.of<List<SupportMessages>>(context);

            if (chatList != null)
              chatList.sort(
                (a, b) => DateTime.parse(b.dateTime)
                    .millisecondsSinceEpoch
                    .compareTo(
                        DateTime.parse(a.dateTime).millisecondsSinceEpoch),
              );

            return chatList != null && chatList.length > 0
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: ListView.builder(
                      itemBuilder: (context, index) =>
                          chatBubble(chatList[index], context),
                      itemCount: chatList.length,
                      reverse: true,
                    ),
                  )
                : Text('');
          },
        ),
      ),
    );
  }

  chatBubble(SupportMessages messages, BuildContext context) {
    bool isUser = messages.isUser;
    DoonStoreUser user = Provider.of<ApplicationState>(context).user;

    return ListTile(
      dense: true,
      leading: !isUser
          ? Material(
              elevation: 5.0,
              shape: CircleBorder(),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/support.png"),
              ),
            )
          : null,
      title: Text(
        messages.message,
        style: GoogleFonts.overpass(fontWeight: FontWeight.w600, fontSize: 16),
        textAlign: isUser ? TextAlign.end : TextAlign.justify,
      ),
      subtitle: Text(
        DateFormat.jms().add_MMMEd().format(DateTime.parse(messages.dateTime)),
        style: GoogleFonts.dmSans(
          color: kPrimaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        textAlign: isUser ? TextAlign.end : TextAlign.justify,
      ),
      trailing: isUser
          ? Material(
              elevation: 5.0,
              shape: CircleBorder(),
              child: CircleAvatar(
                backgroundColor: kPrimaryColor,
                child: Text(
                  getName(user.displayName),
                  style: GoogleFonts.stylish(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            )
          : null,
    );
  }

  getName(String name) {
    var _data = name.split(" ");
    return _data.length > 1
        ? _data[0].substring(0, 1) + _data[1].substring(0, 1)
        : _data[0].substring(0, 1);
  }
}
