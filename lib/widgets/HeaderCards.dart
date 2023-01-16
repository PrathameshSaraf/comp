import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {

  final CloudStorageInfo info;
   HeaderCard({
    Key? key,
required this.info,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Color(0xFFFFC39C),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(16.0 * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: info.color!.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child:Icon(info.next),
              ),
              Icon(Icons.more_vert, color: Colors.white54)
            ],
          ),
          Text(
            info.title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${info.total} Items",
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.white70),
              ),
            ],
          )
        ],
      ),
    );
  }
}



class CloudStorageInfo {
  final String? title, total;
  final Color? color;
  final IconData? next;

  CloudStorageInfo({
    this.title,
    this.total,
    this.next,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Google Drive",
    total: "8",
    next: Icons.add_alarm,
    color: Color(0xFFFFA113),

  ),
  CloudStorageInfo(
    title: "Google Drive",
    total: "8",
    next: Icons.add_alarm,
    color: Color(0xFFFFA113),

  ),
  CloudStorageInfo(
    title: "Google Drive",
    total: "8",
    next: Icons.add_alarm,
    color: Color(0xFFFFA113),

  ),

];
