class BasePageResponse {
  int? pageIndex;
  int? pageSize;
  int? totalPage;
  int? recordTotal;
  List<dynamic>? data;

  BasePageResponse(
      {this.pageIndex,
      this.pageSize,
      this.totalPage,
      this.recordTotal,
      this.data});

  BasePageResponse.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalPage = json['totalPage'];
    recordTotal = json['recordTotal'];

    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['totalPage'] = totalPage;
    data['recordTotal'] = recordTotal;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
