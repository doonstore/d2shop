class SupportMessages {
  String from, to, dateTime, id, userId, message;
  bool isUser;

  SupportMessages(
      {this.from,
      this.to,
      this.dateTime,
      this.isUser,
      this.id,
      this.userId,
      this.message});

  factory SupportMessages.fromJson(Map<String, dynamic> json) {
    return SupportMessages(
      from: json['from'],
      to: json['to'],
      dateTime: json['dateTime'],
      isUser: json['isUser'],
      id: json['id'],
      userId: json['userId'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
      'dateTime': dateTime,
      'isUser': isUser,
      'id': id,
      'userId': userId,
      "message": message,
    };
  }
}
