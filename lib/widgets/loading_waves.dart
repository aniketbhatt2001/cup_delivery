import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utilities/constanst.dart';

class LoadingWaves extends StatelessWidget {
  const LoadingWaves({super.key});

  @override
  Widget build(BuildContext context, {bool pop = T}) {
    return WillPopScope(
      onWillPop: () async {
        return pop;
      },
      child: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
        color: primary,
        size: 55,
      )),
    );
  }
}

class LoadingOverlay extends StatefulWidget {
  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 10)).then((_) {
      if (_isLoading) {
        // Dismiss the loading overlay if it's still visible after 10 seconds
        _dismissLoadingOverlay();
      }
    });
  }

  void _dismissLoadingOverlay() {
    setState(() {
      _isLoading = false;
    });
    // You can add your own logic here to handle the dismissal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading Preview'),
      ),
      body: Stack(
        children: [
          // Your regular app content
          // ...

          // Loading overlay
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
