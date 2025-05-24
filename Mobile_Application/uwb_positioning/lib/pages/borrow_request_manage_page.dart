import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:uwb_positioning/models/borrow_request.dart';
import 'dart:convert';
import 'package:logging/logging.dart';

import 'package:uwb_positioning/services/borrow_request_service.dart';

final _log = Logger('BorrowRequestItem');

class BorrowRequestManagePage extends StatefulWidget {
  const BorrowRequestManagePage({super.key});
  static const nameRoute = "/borrow_request_manage";

  @override
  State<BorrowRequestManagePage> createState() => _BorrowRequestManagePageState();
}

class _BorrowRequestManagePageState extends State<BorrowRequestManagePage> {
  late Future<List<BorrowRequests>> _borrowRequestsFuture;
  late BorrowRequestService _borrowRequestService;
  // Trạng thái lọc theo status
  String statusFilter = 'all';

  // Hàm lọc theo status
  List<BorrowRequests> _filterRequests(List<BorrowRequests> requests) {
    if (statusFilter == 'all') {
      return requests;
    }
    return requests.where((req) => req.status == statusFilter).toList();
  }

  @override
  void initState() {
    super.initState();
    _borrowRequestService = Provider.of<BorrowRequestService>(context, listen: false);
    _borrowRequestsFuture = _borrowRequestService.fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý yêu cầu mượn'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Thêm dropdown để chọn trạng thái lọc
          // PopupMenuButton<String>(
          //   onSelected: (value) {
          //     setState(() {
          //       statusFilter = value;
          //     });
          //   },
          //   itemBuilder: (context) => [
          //     const PopupMenuItem(value: 'all', child: Text('Tất cả')),
          //     const PopupMenuItem(value: 'pending', child: Text('Chờ duyệt')),
          //     const PopupMenuItem(value: 'approved', child: Text('Đã duyệt')),
          //     const PopupMenuItem(value: 'declined', child: Text('Đã từ chối')),
          //     const PopupMenuItem(value: 'received', child: Text('Đang mượn')),
          //     const PopupMenuItem(value: 'returned', child: Text('Đã trả')),
          //   ],
          // ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () async {
              final result = await showDialog<String>(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title: const Text('Chọn trạng thái lọc'),
                    children: <Widget>[
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, 'all');
                        },
                        child: const Text('Tất cả'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, 'pending');
                        },
                        child: const Text('Chờ duyệt'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, 'approved');
                        },
                        child: const Text('Đã duyệt'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, 'declined');
                        },
                        child: const Text('Đã từ chối'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, 'received');
                        },
                        child: const Text('Đang mượn'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, 'returned');
                        },
                        child: const Text('Đã trả'),
                      ),
                    ],
                  );
                },
              );
              if (result != null) {
                setState(() {
                  statusFilter = result;
                });
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<BorrowRequests>>(
        future: _borrowRequestsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }

          final borrowRequests = snapshot.data!;
          final filteredRequests = _filterRequests(borrowRequests);

          if (filteredRequests.isEmpty) {
            return const Center(child: Text('Không có yêu cầu mượn nào.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredRequests.length,
            itemBuilder: (context, i) {
              final req = filteredRequests[i];
              return BorrowRequestItem(
                data: req.toJson(),  // Convert BorrowRequests model to Map
                onApprove: () async {
                  try {
                    await _borrowRequestService.updateRequestStatus(req.requestId, 'approved');
                    setState(() {
                      _borrowRequestsFuture = _borrowRequestService.fetchRequests();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đã duyệt yêu cầu')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Lỗi: $e')),
                    );
                  }
                },
                onReject: () async {
                  try {
                    await _borrowRequestService.updateRequestStatus(req.requestId, 'declined');
                    setState(() {
                      _borrowRequestsFuture = _borrowRequestService.fetchRequests();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đã từ chối yêu cầu')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Lỗi: $e')),
                    );
                  }
                },
                onActualBorrowDateChanged: (date) async {
                  // try {
                  //   await _borrowRequestService.changeBorrowDate(req.requestId, date);
                  //   setState(() {
                  //     req.borrowDate = date;
                  //   });
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('Đã cập nhật ngày mượn')),
                  //   );
                  // }
                  // catch (e) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('Lỗi khi cập nhật ngày mượn')),
                  //   );
                  // }
                  _borrowRequestService.changeBorrowDate(req.requestId, date).then((_) {
                    setState(() {
                      _borrowRequestsFuture = _borrowRequestService.fetchRequests();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Đã cập nhật ngày mượn')),
                    );
                  }).catchError((e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Lỗi khi cập nhật ngày mượn')),
                    );
                  });
                },
                onActualReturnDateChanged: (date) async {
                  // try {
                  //   await _borrowRequestService.changeReturnDate(req.requestId, date);
                  //   setState(() {
                  //     req.returnDate = date;
                  //   });
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('Đã cập nhật ngày trả')),
                  //   );
                  // } catch (e) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('Lỗi khi cập nhật ngày trả')),
                  //   );
                  // }
                  _borrowRequestService.changeReturnDate(req.requestId, date).then((_) {
                    setState(() {
                      _borrowRequestsFuture = _borrowRequestService.fetchRequests();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Đã cập nhật ngày trả')),
                    );
                  }).catchError((e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Lỗi khi cập nhật ngày trả')),
                    );
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}

class BorrowRequestItem extends StatefulWidget {
  final Map<String, dynamic> data;
  final VoidCallback onApprove;
  final VoidCallback onReject;
  final Function(DateTime) onActualBorrowDateChanged;
  final Function(DateTime) onActualReturnDateChanged;

  const BorrowRequestItem({
    super.key,
    required this.data,
    required this.onApprove,
    required this.onReject,
    required this.onActualBorrowDateChanged,
    required this.onActualReturnDateChanged,
  });

  @override
  State<BorrowRequestItem> createState() => _BorrowRequestItemState();
}

class _BorrowRequestItemState extends State<BorrowRequestItem> {
  final DateFormat _fmt = DateFormat('dd/MM/yyyy');

  Widget _buildDeviceStatusRow(String label, bool? status, Color activeColor, Color inactiveColor) {
    return Row(
      children: [
        Icon(
          status == true ? Icons.check_circle : Icons.cancel,
          color: status == true ? activeColor : inactiveColor,
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(
          '$label: ${status == true ? 'Có' : 'Không'}',
          style: TextStyle(
            color: status == true ? activeColor : inactiveColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow({
    required String status,
    required Color activeColor,
    required Color inactiveColor,
    String activeText = 'Hoạt động',
    String inactiveText = 'Không hoạt động',
  }) {
    return Row(
      children: [
        Icon(
          status == "active" ? Icons.check_circle : Icons.cancel,
          color: status == "active" ? activeColor : inactiveColor,
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(
          '${status == "active" ? activeText : inactiveText}',
          style: TextStyle(
            color: status == "active" ? activeColor : inactiveColor,
          ),
        ),
      ],
    );
  }

  Future<void> _pickDate(Function(DateTime) onChanged) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (d != null) onChanged(d);
  }

  Future<bool> _confirm(String action) async {
    return (await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('$action yêu cầu mượn?'),
        content: const SizedBox.shrink(),
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Huỷ'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Xác nhận'),
                ),
              ),
            ],
          ),
        ],
      ),
    )) == true;
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    _log.info('Data: ${d}');
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${d['request_id']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16,)),
            const SizedBox(height: 4),
            Text('Thiết bị: ${d['device_name']} (ID: ${d['device_id']})', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Trạng thái thiết bị:'),
            const SizedBox(height: 4),
            Row(
              children: [
                _buildDeviceStatusRow('Active', d['is_active'], Colors.green, Colors.red),
                const SizedBox(width: 16),
                _buildDeviceStatusRow('Available', d['is_available'], Colors.blue, Colors.grey),
              ],
            ),
            if (d['received_expected_return'] != null) ...[
              const SizedBox(height: 4),
              Text('Thiết bị được hẹn trả vào ngày: ${_fmt.format(DateTime.parse(d['received_expected_return']).toLocal())}'),
            ],
            const SizedBox(height: 8),
            Text('Người mượn: ${d['full_name']}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('Trạng thái người mượn:'),
                const SizedBox(width: 16),
                _buildStatusRow(
                  status: d['user_status'],
                  activeColor: Colors.green,
                  inactiveColor: Colors.grey,
                  activeText: 'Hoạt động',
                  inactiveText: 'Bị khóa',
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Chi tiết mượn: ${d['detail']}'),
            const SizedBox(height: 8),
            Text('Ngày mượn dự kiến: ${_fmt.format(DateTime.parse(d['appointment_date']).toLocal())}'),
            Text('Ngày trả dự kiến: ${_fmt.format(DateTime.parse(d['expected_return']).toLocal())}'),
            const SizedBox(height: 12),
            Text('Trạng thái yêu cầu: ${d['status']}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     ElevatedButton(
            //       onPressed: d['status'] == 'approved'
            //           ? () => _pickDate(widget.onActualBorrowDateChanged)
            //           : null, // Vô hiệu hóa nếu không phải 'approved'
            //       child: Text(d['borrow_date'] != null
            //           ? 'Ngày mượn: ${_fmt.format(DateTime.parse(d['borrow_date']))}'
            //           : 'Cập nhật ngày mượn'),
            //     ),
            //   ],
            // ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: d['status'] == 'approved'
                    ? () => _pickDate(widget.onActualBorrowDateChanged)
                    : null,
                child: Text(d['borrow_date'] != null
                    ? 'Ngày mượn: ${_fmt.format(DateTime.parse(d['borrow_date']).toLocal())}'
                    : 'Cập nhật ngày mượn'),
              ),
            ),
            const SizedBox(height: 8),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     ElevatedButton(
            //       onPressed: d['status'] == 'approved' ||  d['status'] == 'received'
            //           ? () => _pickDate(widget.onActualReturnDateChanged)
            //           : null, // Vô hiệu hóa nếu không phải 'approved'
            //       child: Text(d['return_date'] != null
            //           ? 'Ngày trả: ${_fmt.format(DateTime.parse(d['return_date']))}'
            //           : 'Cập nhật ngày trả'),
            //     ),
            //   ],
            // ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: d['status'] == 'received'
                    ? () => _pickDate(widget.onActualReturnDateChanged)
                    : null,
                child: Text(d['return_date'] != null
                    ? 'Ngày trả: ${_fmt.format(DateTime.parse(d['return_date']).toLocal())}'
                    : 'Cập nhật ngày trả'),
              ),
            ),
            const SizedBox(height: 8),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Wrap(
            //       spacing: 8,
            //       runSpacing: 8,
            //       children: [
            //         ElevatedButton(
            //           style: ElevatedButton.styleFrom(
            //             backgroundColor: Colors.green,
            //             foregroundColor: Colors.white,
            //           ),
            //           onPressed: d['status'] == 'pending'
            //               ? () async {
            //             if (await _confirm('Duyệt')) widget.onApprove();
            //           }
            //               : null,
            //           child: const Text('Duyệt'),
            //         ),
            //         ElevatedButton(
            //           style: ElevatedButton.styleFrom(
            //             backgroundColor: Colors.red,
            //             foregroundColor: Colors.white,
            //           ),
            //           onPressed: d['status'] == 'pending'
            //               ? () async {
            //             if (await _confirm('Từ chối')) widget.onReject();
            //           }
            //               : null,
            //           child: const Text('Từ chối'),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: d['status'] == 'pending'
                        ? () async {
                      if (await _confirm('Duyệt')) widget.onApprove();
                    }
                        : null,
                    child: const Text('Duyệt'),
                  ),
                ),
                const SizedBox(width: 8), // Khoảng cách giữa 2 nút
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: d['status'] == 'pending'
                        ? () async {
                      if (await _confirm('Từ chối')) widget.onReject();
                    }
                        : null,
                    child: const Text('Từ chối'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
