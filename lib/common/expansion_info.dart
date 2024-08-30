// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';

// import '../third-party/expansion_tile_copied.dart';

// class ExpansionInfo extends StatelessWidget {
//   final String title;
//   final bool expand;
//   final List<Widget> children;
//   final Widget shownWidget;

//   ExpansionInfo({
//     required this.title,
//     required this.children,
//     this.expand = false,
//     required this.shownWidget,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ConfigurableExpansionTile(
//       initiallyExpanded: expand,
//       headerExpanded: Flexible(
//         child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 20.0),
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   AutoSizeText(title,
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                   Icon(
//                     Icons.keyboard_arrow_up,
//                     color: Theme.of(context).colorScheme.secondary,
//                     size: 20,
//                   )
//                 ])),
//       ),
//       header: Flexible(
//         child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 17.0),
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   shownWidget,
//                   Icon(
//                     Icons.keyboard_arrow_right,
//                     color: Theme.of(context).colorScheme.secondary,
//                     size: 20,
//                   )
//                 ])),
//       ),
//       children: children,
//     );
//   }
// }
