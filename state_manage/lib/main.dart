// import 'package:flutter/material.dart';
// // import 'package:state_management/bloc/view/count_page.dart';
// // import 'package:state_management/getx/view/count_page.dart';
// // import 'package:state_management/provider/view/count_page.dart';
// // import 'package:state_management/riverpod/count_app.dart';

// void main() {
//   runApp(const CountApp());
// }

// class CountApp extends StatelessWidget {
//   const CountApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'State Manager - Plain',
//       home: CountPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class CountPage extends StatefulWidget {
//   const CountPage({Key? key}) : super(key: key);

//   @override
//   _CountPageState createState() => _CountPageState();
// }

// class _CountPageState extends State<CountPage> {
//   int _count = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('State Manager - Plain')),
//       body: Center(
//         child: Text(
//           '$_count',
//           style: const TextStyle(
//             fontSize: 40,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: () => setState(() {
//               _count++;
//             }),
//             child: const Icon(Icons.add),
//           ),
//           const SizedBox(height: 8),
//           FloatingActionButton(
//             onPressed: () => setState(() {
//               _count--;
//             }),
//             child: const Icon(Icons.remove),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/bloc/count_app.dart';
import 'package:state_management/bloc/count_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const CountApp()),
    blocObserver: CountObserver(),
  );
}
