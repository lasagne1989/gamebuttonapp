import 'package:arp_scanner/arp_scanner.dart';
import 'package:arp_scanner/device.dart';
import 'package:flutter/material.dart';
import '../model/player.dart';
import 'package:web_socket_channel/io.dart';
import 'package:numberpicker/numberpicker.dart';


class GameSettings extends StatefulWidget {
  GameSettings({Key? key, required this.playing}) : super(key: key);
  final List<Player> playing;


  @override
  _GameSettingsState createState() => _GameSettingsState();
}

class _GameSettingsState extends State<GameSettings> {
  String _result = '';

  @override
  void initState() {
    super.initState();

    ArpScanner.onScanning.listen((Device device) {
      var hostName = device.hostname;
      if (hostName == "gamebutton.lan" || hostName == "gamebutton") {
      ///if (hostName == "DESKTOP-JNKQ9HF") {
        setState(() {
          _result =
          "${device.ip}";
        }); }
    });
    ArpScanner.scan();
  }

  late final _channel = IOWebSocketChannel.connect(
    ///Uri.parse('ws://192.168.86.58:8765'),
    Uri.parse('ws://${_result}:8765'),
  );
  late var namePlaying = widget.playing.map((player) => '"${player.name}"').toList();
  late var dobPlaying = widget.playing.map((player) => '"${player.dob}"').toList();
  late var strPlaying = namePlaying.toString();
  late var strDob = dobPlaying.toString();
  List<String> modes = <String>['Standard', 'Nameless'];
  String selectedMode= "Standard";
  int _valueMin = 0;
  int _valueSec = 30;
  int currentStep = 0;
  bool isCompleted = false;

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text('Game Mode', style: TextStyle(fontSize: 20)),
          content: DropdownButton<String>(
            value: selectedMode,
            style: TextStyle(color: Colors.black, fontSize: 20),
            elevation: 16,
            isExpanded: true,
            dropdownColor: Colors.white,
            iconEnabledColor: Colors.red,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                selectedMode = value!;
              });
            },
            items: modes.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        Step(
            isActive: currentStep >= 1,
            title: Text('Time limit', style: TextStyle(fontSize: 20)),
            content: Row(
              children: <Widget>[
                Column(children: <Widget>[
                  Center(child: Text("Mins", style: TextStyle(fontSize: 20))),
                  Center(
                      child: NumberPicker(
                        value: selectedMode == "Chess"?
                        5: _valueMin,
                        minValue: 0,
                        maxValue: 10,
                        textStyle: TextStyle(fontSize: 20),
                        selectedTextStyle: TextStyle(fontSize: 28,color: Colors.red),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.black26),
                        ),
                        onChanged: (value) => setState(() => _valueMin = value),
                      ),)
                ]),
                Column(children: <Widget>[
                  Center(child: Text("Secs", style: TextStyle(fontSize: 20))),
                  Center(
                      child: NumberPicker(
                        value: selectedMode == "Chess"?
                                0: _valueSec,
                        minValue: 0,
                        maxValue: 59,
                        textStyle: TextStyle(fontSize: 20),
                        selectedTextStyle: TextStyle(fontSize: 28,color: Colors.red),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.black26),
                        ),
                        onChanged: (value) => setState(() => _valueSec = value),
                      ))
                ])
              ],
            )),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Settings"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body:
      isCompleted
      ? BigButtonV() :
        Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Text(
              'Players:',
              style: TextStyle(fontSize: 20, height: 1.5, color: Colors.black),
            ),
          ),
          Wrap(
              spacing: 10,
              children: widget.playing
                  .map(
                    (player) => Chip(
                        avatar: CircleAvatar(
                          backgroundColor: Colors.grey.shade800,
                        ),
                        label: Text(player.name, style: TextStyle(fontSize: 20))),
                  )
                  .toList()),
          Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: Colors.red),
            ),
            child: Stepper(
              type: StepperType.vertical,
              steps: getSteps(),
              currentStep: currentStep,
              onStepContinue: () {
                final isLastStep = currentStep == getSteps().length - 1;
                if (isLastStep) {
                  setState(() => isCompleted = true);
                  _sendMessage();
                } else {
                  setState(() => currentStep += 1);
                }
              },
              onStepCancel: currentStep == 0
                  ? null
                  : () {
                      setState(() => currentStep -= 1);
                    },
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                final isLastStep = currentStep == getSteps().length - 1;
                return Row(
                    children: <Widget>[
                    TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                      onPressed: details.onStepContinue,
                    child: Text(isLastStep ? 'Start the Game': 'Next', style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                if (currentStep !=0)
                      TextButton(
                        onPressed: details.onStepCancel,
                        child: const Text('Back', style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  BigButtonV(){
    return Container(
        child: Center(
          child:ElevatedButton(
            child: const Text(
              'Beep',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: _sendNext,
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 200),
              shape: const CircleBorder(),
              primary: Colors.red,
            ),
          ),
        )

    );
  }

  void _sendMessage() {

    var timeLimit = _valueMin * 60 + _valueSec;
    ///print(timeLimit);
    ///print(dobPlaying);
    print(_result);
    print('{"players":$strPlaying, "time_limit": $timeLimit, "mode": "$selectedMode", "dob": $dobPlaying}');
    _channel.sink.add('{"players":$strPlaying, "time_limit": $timeLimit, "mode": "$selectedMode", "dob": $dobPlaying}');
  ///"dob": $dobPlaying}'
  }

  void _sendNext() {
    print('next');
    _channel.sink.add('next');
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

}

