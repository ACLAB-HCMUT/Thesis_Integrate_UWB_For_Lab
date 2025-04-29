// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class BorrowRequestManagePage extends StatelessWidget {
//   const BorrowRequestManagePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Quản lý yêu cầu mượn')),
//       body: ListView(
//         children: [
//           BorrowRequestItem(
//             deviceName: 'Laptop Dell XPS 13',
//             borrowerName: 'Nguyễn Văn A',
//             borrowDate: DateTime.now(),
//             expectedReturnDate: DateTime.now().add(const Duration(days: 7)),
//             onBorrowDateChanged: (date) {
//               print('Ngày mượn mới: $date');
//             },
//             onExpectedReturnDateChanged: (date) {
//               print('Ngày trả mới: $date');
//             },
//             onApprove: () {
//               print('Duyệt yêu cầu');
//             },
//             onReject: () {
//               print('Từ chối yêu cầu');
//             },
//           ),
//           BorrowRequestItem(
//             deviceName: 'Máy ảnh Canon EOS',
//             borrowerName: 'Trần Thị B',
//             borrowDate: null,
//             expectedReturnDate: null,
//             onBorrowDateChanged: (date) {
//               print('Ngày mượn mới: $date');
//             },
//             onExpectedReturnDateChanged: (date) {
//               print('Ngày trả mới: $date');
//             },
//             onApprove: () {
//               print('Duyệt yêu cầu');
//             },
//             onReject: () {
//               print('Từ chối yêu cầu');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class BorrowRequestItem extends StatefulWidget {
//   final String deviceName;
//   final String borrowerName;
//   final DateTime? borrowDate;
//   final DateTime? expectedReturnDate;
//   final Function(DateTime) onBorrowDateChanged;
//   final Function(DateTime) onExpectedReturnDateChanged;
//   final VoidCallback onApprove;
//   final VoidCallback onReject;
//
//   const BorrowRequestItem({
//     super.key,
//     required this.deviceName,
//     required this.borrowerName,
//     this.borrowDate,
//     this.expectedReturnDate,
//     required this.onBorrowDateChanged,
//     required this.onExpectedReturnDateChanged,
//     required this.onApprove,
//     required this.onReject,
//   });
//
//   @override
//   State<BorrowRequestItem> createState() => _BorrowRequestItemState();
// }
//
// class _BorrowRequestItemState extends State<BorrowRequestItem> {
//   late TextEditingController _borrowDateCtl;
//   late TextEditingController _expectedReturnCtl;
//   final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
//
//   @override
//   void initState() {
//     super.initState();
//     _borrowDateCtl = TextEditingController(
//       text: widget.borrowDate != null ? _dateFormat.format(widget.borrowDate!) : '',
//     );
//     _expectedReturnCtl = TextEditingController(
//       text: widget.expectedReturnDate != null ? _dateFormat.format(widget.expectedReturnDate!) : '',
//     );
//   }
//
//   @override
//   void dispose() {
//     _borrowDateCtl.dispose();
//     _expectedReturnCtl.dispose();
//     super.dispose();
//   }
//
//   Future<void> _pickDate(TextEditingController controller, Function(DateTime) onDatePicked) async {
//     FocusScope.of(context).requestFocus(FocusNode()); // tránh bật bàn phím
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null) {
//       controller.text = _dateFormat.format(picked);
//       onDatePicked(picked);
//     }
//   }
//
//   Future<bool> _confirmAction(String actionName) async {
//     return await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('$actionName yêu cầu?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: const Text('Hủy'),
//           ),
//           ElevatedButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: const Text('Xác nhận'),
//           ),
//         ],
//       ),
//     ) ??
//         false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Thiết bị: ${widget.deviceName}', style: const TextStyle(fontWeight: FontWeight.bold)),
//             Text('Người mượn: ${widget.borrowerName}'),
//             const SizedBox(height: 8),
//             TextFormField(
//               controller: _borrowDateCtl,
//               decoration: const InputDecoration(labelText: 'Ngày mượn'),
//               readOnly: true,
//               onTap: () => _pickDate(_borrowDateCtl, widget.onBorrowDateChanged),
//             ),
//             const SizedBox(height: 8),
//             TextFormField(
//               controller: _expectedReturnCtl,
//               decoration: const InputDecoration(labelText: 'Ngày trả dự kiến'),
//               readOnly: true,
//               onTap: () => _pickDate(_expectedReturnCtl, widget.onExpectedReturnDateChanged),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 ElevatedButton(
//                   onPressed: () async {
//                     final confirm = await _confirmAction('Duyệt');
//                     if (confirm) widget.onApprove();
//                   },
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                   child: const Text('Duyệt'),
//                 ),
//                 const SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: () async {
//                     final confirm = await _confirmAction('Từ chối');
//                     if (confirm) widget.onReject();
//                   },
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                   child: const Text('Từ chối'),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
// borrow_request_manage_page.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BorrowRequestManagePage extends StatelessWidget {
  const BorrowRequestManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dữ liệu giả
    final List<Map<String, dynamic>> borrowRequests = [
      {
        'id': 1,
        'user': 'Hồ Chí Anh Khôi',
        'device': 'UWB Tag 1',
        'expectedBorrowDate': DateTime(2025, 5, 5),
        'expectedReturnDate': DateTime(2025, 5, 10),
        'actualBorrowDate': null,
        'actualReturnDate': null,
        'status': 'Pending',
        'note': 'Cần dùng cho đồ án',
      },
      {
        'id': 2,
        'user': 'Hồ Chí Anh Khôi',
        'device': 'NodeMCU-BU01',
        'expectedBorrowDate': DateTime(2025, 5, 7),
        'expectedReturnDate': DateTime(2025, 5, 15),
        'actualBorrowDate': null,
        'actualReturnDate': null,
        'status': 'Approved',
        'note': 'Học online',
      },
    ];

    return Scaffold(
      appBar: AppBar(
          title: const Text('Quản lý yêu cầu mượn'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // <-- Nút trở về
            },
          ),
        ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: borrowRequests.length,
        itemBuilder: (context, i) {
          final req = borrowRequests[i];
          return BorrowRequestItem(
            data: req,
            onApprove: () {
              // gọi API duyệt...
            },
            onReject: () {
              // gọi API từ chối...
            },
            onActualBorrowDateChanged: (date) {
              // gọi API cập nhật actualBorrowDate...
            },
            onActualReturnDateChanged: (date) {
              // gọi API cập nhật actualReturnDate...
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
    )) ==
        true;
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Thiết bị: ${d['device']}', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Người mượn: ${d['user']}'),
            // Chi tiết mượn (ghi chú)
            Text('Chi tiết mượn: ${d['note']}'),
            const SizedBox(height: 8),
            Text('Ngày mượn dự kiến: ${_fmt.format(d['expectedBorrowDate'])}'),
            Text('Ngày trả dự kiến: ${_fmt.format(d['expectedReturnDate'])}'),
            const SizedBox(height: 12),
            Text('Trạng thái: ${d['status']}'),
            const SizedBox(height: 12),
          Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () => _pickDate(widget.onActualBorrowDateChanged),
              child: Text(d['actualBorrowDate'] != null
                  ? 'Ngày mượn: ${_fmt.format(d['actualBorrowDate'])}'
                  : 'Cập nhật ngày mượn'),
            ),
            ],
          ),
            const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () => _pickDate(widget.onActualReturnDateChanged),
              child: Text(d['actualReturnDate'] != null
                  ? 'Ngày trả: ${_fmt.format(d['actualReturnDate'])}'
                  : 'Cập nhật ngày trả'),
            ),
          ],
        ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white,),
                  onPressed: d['status'] == 'Pending'
                      ? () async {
                    if (await _confirm('Duyệt')) widget.onApprove();
                  }
                      : null,
                  child: const Text('Duyệt'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white,),
                  onPressed: d['status'] == 'Pending'
                      ? () async {
                    if (await _confirm('Từ chối')) widget.onReject();
                  }
                      : null,
                  child: const Text('Từ chối'),
                ),
              ],
            ),
        ],
            ),
          ],
        ),
      ),
    );
  }
}