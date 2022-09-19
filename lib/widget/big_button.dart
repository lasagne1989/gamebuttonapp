import 'package:flutter/material.dart';
import '../page/final_settings.dart' as settings;

class BigButton extends StatelessWidget {
  const BigButton ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child:ElevatedButton(
          child: const Text(
            'Beep',
            style: TextStyle(fontSize: 24),
          ),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 200),
              shape: const CircleBorder(),
            primary: Colors.red,
        ),
      ),
      )

    );
  }

}


