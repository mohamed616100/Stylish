class CanceldResopnse {
  String? message;
  bool? status;

  CanceldResopnse({this.message, this.status});

  CanceldResopnse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
