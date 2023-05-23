import 'package:flutter/material.dart';

class OrdersTiles extends StatelessWidget {
  OrdersTiles({
    super.key,
  });

  final _dummyOrdersTitles = [
    "Order 1581581",
    "Order 7845123",
    "Order 2468024",
    "Order 3334445",
    "Order 7779990",
  ];

  final _dummyOrdersStatus = [
    "Pending",
    "Processing",
    "Shipping",
    "Delivered",
    "Cancelled",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
        (index) => GestureDetector(
          // onTap: () => Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => const OrderDetails(),
          //     )),
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      _dummyOrdersTitles[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    _dummyOrdersStatus[index],
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
