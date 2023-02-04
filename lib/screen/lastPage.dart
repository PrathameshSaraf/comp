import 'package:comp/screen/RecordCustomer.dart';
import 'package:comp/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SuccessPage extends StatefulWidget {
  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  bool _playSuccessSound = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _playSuccessSound = true;
          });
        }
      });
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Center(
             child: SingleChildScrollView(
               child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image:NetworkImage(
                      'https://fcs3pub.s3.amazonaws.com/photo-book/images/payment/success.gif',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),),
                  SizedBox(height: 20),
                  Text(
                    'Task Done',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  FadeTransition(
                    opacity: _animation!,
                    child:Text(
                      'Your salon visit has been completed, thank you for choosing us. We hope you have a great day ahead!',textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18,),
                    ),
                  ),
                  SizedBox(height: 200,),
                  ButtonW100(text: "Back To Home", onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>RecordCostomer(),
                        ));
                  })
                ],
        ),
             ),
           ),
         ),
      ),
    );
  }
}
