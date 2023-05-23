// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class ProductsTiles extends StatelessWidget {
//   ProductsTiles({Key? key}) : super(key: key);

//   final Stream<QuerySnapshot> _productsStream =
//       FirebaseFirestore.instance.collection('products').snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _productsStream,
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }

//         return ListView(
//           children: snapshot.data!.docs.map((DocumentSnapshot document) {
//             Map<String, dynamic> data =
//                 document.data()! as Map<String, dynamic>;
//             data.length;
//             return GestureDetector(
//               // onTap: () =>
//               //  Navigator.push(
//               //   context,
//               //   MaterialPageRoute(
//               //     builder: (context) => ProductDetailsScreen(data: data),
//               //   ),
//               // ),
//               onTap: () {},
//               child: Container(
//                 margin:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     data['image'] != null
//                         ? Container(
//                             height: 50,
//                             width: 50,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20)),
//                             child: Image.network(
//                               data['image'][0],
//                             ),
//                           )
//                         : Container(
//                             width: 50,
//                             height: 50,
//                             margin: const EdgeInsets.only(right: 10),
//                             // child: SvgPicture.asset('assets/no_image.svg'),
//                             child: const Icon(Icons.no_photography_outlined),
//                           ),
//                     Expanded(
//                       child: Text(
//                         data['name'] ?? 'Default Name',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         // showDialog(
//                         //   context: context,
//                         //   builder: (BuildContext context) {
//                         //     return AlertDialog(
//                         //       title: const Text('Delete confirmation'),
//                         //       content: const Text(
//                         //           'Are you sure you want to delete this item?'),
//                         //       actions: <Widget>[
//                         //         TextButton(
//                         //           onPressed: () {
//                         //             Navigator.of(context).pop(false);
//                         //           },
//                         //           child: const Text('Cancel'),
//                         //         ),
//                         //         TextButton(
//                         //           onPressed: () {
//                         //             Navigator.of(context).pop(true);
//                         //           },
//                         //           child: const Text('Delete'),
//                         //         ),
//                         //       ],
//                         //     );
//                         //   },
//                         // ).then((value) {
//                         //   if (value != null && value) {
//                         //     deleteProduct(data['id'], context);
//                         //   }
//                         // });
//                       },
//                       icon: const Icon(
//                         Icons.delete,
//                         color: Colors.red,
//                       ),
//                       tooltip: 'Delete',
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
// }
