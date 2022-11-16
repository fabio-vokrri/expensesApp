// import "package:expenses/data/models/database.dart";
// import "package:expenses/ui/painters/overview_progressbar_painter.dart.dart";
// import "package:flutter/material.dart";

// class OverViewBanner extends StatelessWidget {
//   const OverViewBanner({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final DataBase db = DataBase();
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       padding: const EdgeInsets.all(16.0),
//       height: double.infinity,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(16.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withAlpha(25),
//             blurRadius: 8,
//             offset: const Offset(8, 8),
//           ),
//         ],
//       ),
//       child: FutureBuilder(
//         builder: (context, snapshot) {
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               CustomPaint(
//                 size: const Size(100, 100),
//                 painter: OverviewProgressBar(
//                   percentage:
//                       db.getTotalThisMonth() / db.getTotalThisYear() * 100,
//                   color: Colors.white,
//                   backgroundColor: Colors.white10,
//                 ),
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   RichText(
//                     text: TextSpan(
//                       text: "This month you spent:\n",
//                       style: const TextStyle(color: Colors.white),
//                       children: [
//                         TextSpan(
//                           text: "€${db.getTotalThisMonth.toStringAsFixed(2)}",
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   RichText(
//                     text: TextSpan(
//                       text: "This year you spent:\n",
//                       style: const TextStyle(color: Colors.white),
//                       children: [
//                         TextSpan(
//                           text: "€${db.getTotalThisYear.toStringAsFixed(2)}",
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
