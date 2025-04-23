class BorrowRequest {
  final String deviceId;
  final String detail;
  final String status;
  final String appointmentDate;
  final String expectedReturn;
  final String clientId;
  // New optional fields
  String borrowDate = '';
  String returnDate = '';

  BorrowRequest({
    required this.deviceId,
    required this.detail,
    required this.status,
    required this.appointmentDate,
    required this.expectedReturn,
    required this.clientId,
    this.borrowDate = '',
    this.returnDate = '',
  });

  factory BorrowRequest.fromJson(Map<String, dynamic> json) {
    return BorrowRequest(
      deviceId: json['device_id'],
      detail: json['detail'],
      status: json['status'],
      appointmentDate: json['appointment_date'],
      expectedReturn: json['expected_return'],
      clientId: json['client_id'],
      borrowDate: json['borrow_date'] ?? '',
      returnDate: json['return_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'device_id': deviceId,
      'detail': detail,
      'status': status,
      'appointment_date': appointmentDate,
      'expected_return': expectedReturn,
      'client_id': clientId,
      // Include empty borrow/return dates on creation
      'borrow_date': borrowDate,
      'return_date': returnDate,
    };
  }
}
