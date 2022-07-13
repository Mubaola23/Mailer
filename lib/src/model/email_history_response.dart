class EmailHistoryResponse {
  EmailHistoryResponse({
    required this.isLastPage,
    required this.rows,
  });
  late final bool isLastPage;
  late final List<Rows> rows;

  EmailHistoryResponse.fromJson(Map<String, dynamic> json) {
    isLastPage = json['is_last_page'];
    rows = List.from(json['rows']).map((e) => Rows.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['is_last_page'] = isLastPage;
    _data['rows'] = rows.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Rows {
  Rows({
    required this.id,
    required this.userId,
    required this.result,
    this.error,
    required this.provider,
    required this.serviceId,
    required this.originalServiceId,
    required this.templateId,
    this.templateParams,
    required this.files,
    required this.retryCount,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String userId;
  late final int result;
  late final String? error;
  late final String provider;
  late final String serviceId;
  late final String originalServiceId;
  late final String templateId;
  late final String? templateParams;
  late final String files;
  late final int retryCount;
  late final String createdAt;
  late final String updatedAt;

  Rows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    result = json['result'];
    error = null;
    provider = json['provider'];
    serviceId = json['service_id'];
    originalServiceId = json['original_service_id'];
    templateId = json['template_id'];
    templateParams =
        json['template_params'] != null ? json['template_params'] : "";
    files = json['files'];
    retryCount = json['retry_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['result'] = result;
    _data['error'] = error;
    _data['provider'] = provider;
    _data['service_id'] = serviceId;
    _data['original_service_id'] = originalServiceId;
    _data['template_id'] = templateId;
    _data['template_params'] = templateParams;
    _data['files'] = files;
    _data['retry_count'] = retryCount;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
