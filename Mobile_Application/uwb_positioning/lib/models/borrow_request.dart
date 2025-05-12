class BorrowRequest {
  final String deviceId;
  final String detail;
  final String status;
  final String appointmentDate;
  final String expectedReturn;

  BorrowRequest({
    required this.deviceId,
    required this.detail,
    required this.status,
    required this.appointmentDate,
    required this.expectedReturn,
  });

  factory BorrowRequest.fromJson(Map<String, dynamic> json) {
    return BorrowRequest(
      deviceId: json['device_id'],
      detail: json['detail'],
      status: json['status'],
      appointmentDate: json['appointment_date'],
      expectedReturn: json['expected_return'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'device_id': deviceId,
      'detail': detail,
      'status': status,
      'appointment_date': appointmentDate,
      'expected_return': expectedReturn,
    };
  }
}


class BorrowRequests {
  final int requestId;
  final String detail;
  final String? status;
  final DateTime appointmentDate;
  final DateTime expectedReturn;
  DateTime? borrowDate;
  DateTime? returnDate;
  final int clientId;
  final int deviceId;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String role;
  final String userStatus;

  BorrowRequests({
    required this.requestId,
    required this.detail,
    required this.status,
    required this.appointmentDate,
    required this.expectedReturn,
    this.borrowDate,
    this.returnDate,
    required this.clientId,
    required this.deviceId,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.userStatus,
  });

  factory BorrowRequests.fromJson(Map<String, dynamic> json) {
    return BorrowRequests(
      requestId: json['request_id'],
      detail: json['detail'],
      status: json['status'],
      appointmentDate: DateTime.parse(json['appointment_date']),
      expectedReturn: DateTime.parse(json['expected_return']),
      borrowDate: json['borrow_date'] != null ? DateTime.parse(json['borrow_date']) : null,
      returnDate: json['return_date'] != null ? DateTime.parse(json['return_date']) : null,
      clientId: json['client_id'],
      deviceId: json['device_id'],
      fullName: json['full_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      role: json['role'],
      userStatus: json['user_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      'detail': detail,
      'status': status,
      'appointment_date': appointmentDate.toIso8601String(),
      'expected_return': expectedReturn.toIso8601String(),
      'borrow_date': borrowDate?.toIso8601String(),
      'return_date': returnDate?.toIso8601String(),
      'client_id': clientId,
      'device_id': deviceId,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'role': role,
      'user_status': userStatus,
    };
  }
}