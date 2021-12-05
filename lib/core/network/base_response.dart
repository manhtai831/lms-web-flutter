class BaseResponse {
  String? time;
  Error? error;
  dynamic data;

  BaseResponse({this.time, this.error, this.data});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    if (error != null) {
      data['error'] = error!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Error {
  int? code;
  String? message;

  Error({this.code, this.message});

  Error.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}
