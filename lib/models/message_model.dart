class Message {
  final String title, body;

  const Message({this.title, this.body});

  factory Message.getMessage(Map<String, dynamic> message) {
    return Message(
      title: message['notification']['title'],
      body: message['notification']['body'],
    );
  }
}
