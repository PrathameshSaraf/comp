import 'package:flutter/material.dart';

import '../Admin/Dashbord.dart';
import '../widgets/Responsive.dart';



class DashbordPage extends StatelessWidget {
  const DashbordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Expanded(
        // It takes 5/6 part of the screen
        flex: 5,
        child: SafeArea(
        child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(16.0),
    child: Column(children: [
    SizedBox(height: 16.0),
    Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Expanded(
    flex: 5,
    child: Column(children: [

    Responsive(
    mobile: FileInfoCardGridView(
    crossAxisCount:
    _size.width < 650 ? 2 : 4,
    childAspectRatio:
    _size.width < 650 ? 1.3 : 1,
    ),
    tablet: FileInfoCardGridView(),
    desktop: FileInfoCardGridView(
    childAspectRatio:
    _size.width < 1400 ? 1.1 : 1.4,
    ),
    ),
    ])
// ])
//   ])
//     );
    )
        ]
    )
    ]    )
        )
    ));

    }
}