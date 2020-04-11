class ServerResponse {
  final int code;
  final String message;
  final String data;

  ServerResponse.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        message = json['message'],
        data = json['data'];
}
