class ServerResponse {
  int code;
  String message;
  String data;

  ServerResponse.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        message = json['message'],
        data = json['data'];
}
