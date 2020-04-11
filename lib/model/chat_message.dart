import 'dart:convert';

class ChatMessage {
    String key;
    String senderId;
    String message;
    bool seen;
    String createdAt;
    String senderName;
    String receiverId;

    ChatMessage({
        this.key,
        this.senderId,
        this.message,
        this.seen,
        this.createdAt,
        this.receiverId,
        this.senderName,
    });

    factory ChatMessage.fromJson(Map<dynamic, dynamic> json) => ChatMessage(
        senderName: json["senderName"] == null ? null : json["senderName"],
        receiverId: json["receiverId"] == null ? null : json["receiverId"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        message: json["message"] == null ? null : json["message"],
        key: json["key"],
        seen: json["seen"] == null ? null : json["seen"],
        senderId: json["sender_id"] == null ? null : json["sender_id"],
    );

    Map<String, dynamic> toJson() => {
        "senderName": senderName == null ? null : senderName,
        "receiverId": receiverId == null ? null : receiverId,
        "created_at": createdAt == null ? null : createdAt,
        "message": message == null ? null : message,
        "key": key,
        "seen": seen == null ? false : seen,
        "sender_id": senderId == null ? null : senderId,
    };
}

class ChatResponse {
    List<ChatMessage> data;

    ChatResponse({
        this.data,
    });

    factory ChatResponse.fromRawJson(String str) => ChatResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ChatResponse.fromJson(Map<String, dynamic> json) => ChatResponse(
        data: json["data"] == null ? null : List<ChatMessage>.from(json["data"].map((x) => ChatMessage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    };
}