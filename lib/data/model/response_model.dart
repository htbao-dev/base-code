import 'dart:typed_data';

class ResponseModel<T> {
  late bool success;
  String? message;
  T? data;
  Paginate? paginate;
  Uint8List? bodyByte;

  ResponseModel({
    this.bodyByte,
    required this.success,
    this.data,
    this.message,
  });

  ResponseModel.fromJson(Map<String, dynamic> json, {this.bodyByte}) {
    success = json["success"] ?? false;
    message = json["message"] ?? "";
    data = json["data"] ?? "";
    paginate =
        json['paginate'] != null ? Paginate.fromJson(json['paginate']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['data'] = this.data;
    data['message'] = message;
    if (paginate != null) {
      data['paginate'] = paginate?.toJson();
    }
    return data;
  }
}

class Paginate {
  int? limit;
  int? _totalPage;
  int? _page;
  int? totalRecord;

  int get totalPage => _totalPage ?? 1;
  int get page => _page ?? 0;

  Paginate({this.limit, int? totalPage, int? page, this.totalRecord})
      : _totalPage = totalPage,
        _page = page;

  Paginate.init()
      : _page = 0,
        _totalPage = 1;

  Paginate.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    _totalPage = json['total_page'] ?? json['totalPages'];
    _page = json['page'];
    totalRecord = json['total_record'] ?? json['totalDocs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['limit'] = limit;
    data['total_page'] = _totalPage;
    data['page'] = _page;
    data['total_record'] = totalRecord;
    return data;
  }
}
