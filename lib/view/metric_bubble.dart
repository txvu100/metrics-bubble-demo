import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:metrics_bubble_demo/model/body_weight.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MetricBubble extends StatefulWidget {
  static const bubbleDiameter = 272.0;

  static const bubbleBoxDecoration = BoxDecoration(
    color: Color(0xff53a99a),
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
        offset: Offset(0, 27),
        blurRadius: 33,
        color: Color(0x3827ae96),
      )
    ],
  );

  static const labelTextStyle = TextStyle(
    fontFamily: 'Helvetica',
    fontWeight: FontWeight.bold,
    // height: 3,
    fontSize: 19,

    color: Colors.white,
  );

  static const weightTextStyle = TextStyle(fontFamily: 'League Gothic', fontSize: 127, height: 1, color: Colors.white);

  static const unitTextStyle = TextStyle(
    fontFamily: 'League Gothic',
    fontSize: 38,
    color: Color(0x80ffffff),
    height: 0.5,
  );

  BodyWeight bodyWeight;

  MetricBubble(this.bodyWeight);

  @override
  _MetricBubbleState createState() => _MetricBubbleState();
}

class _MetricBubbleState extends State<MetricBubble> {
  bool _editMode = false;

  final _formKey = GlobalKey<FormState>();

  final _labelFocusNode = FocusNode();
  final _labelController = TextEditingController();

  final _weightFocusNode = FocusNode();
  final _weightController = TextEditingController();

  @override
  void initState() {
    // automatically select the whole text when text field got focus.
    _labelFocusNode.addListener(() {
      if (_labelFocusNode.hasFocus) {
        setState(() {
          _labelController.selection = TextSelection(baseOffset: 0, extentOffset: _labelController.text.length);
        });
      }
    });

    _weightFocusNode.addListener(() {
      if (_weightFocusNode.hasFocus) {
        setState(() {
          _weightController.selection = TextSelection(baseOffset: 0, extentOffset: _weightController.text.length);
        });
      }
    });
  }

  @override
  void dispose() {
    // dispose these focus nodes and controller after used to avoid memory leak
    super.dispose();
    _labelController.removeListener(() {});
    _weightController.removeListener(() {});
    _labelFocusNode.dispose();
    _weightFocusNode.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _labelController.text = widget.bodyWeight.label;
    _weightController.text = widget.bodyWeight.weight.toString();
    print(widget.bodyWeight.weight.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _editMode = true;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(15.0),
        decoration: MetricBubble.bubbleBoxDecoration,
        height: MetricBubble.bubbleDiameter,
        width: MetricBubble.bubbleDiameter,
        child: Center(
          child: Stack(
            children: [
              Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _editMode
                          ? Container(
                              width: 150,
                              height: 25,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                style: MetricBubble.labelTextStyle,
                                focusNode: _labelFocusNode,
                                controller: _labelController,
                                keyboardType: TextInputType.number,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context).requestFocus(_labelFocusNode);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Empty!';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  widget.bodyWeight.label = value!;
                                },
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                widget.bodyWeight.label,
                                style: MetricBubble.labelTextStyle,
                              ),
                            ),
                      _editMode
                          ? Container(
                              width: 150,
                              height: 110,
                              margin: EdgeInsets.only(top: 5, bottom: 30),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                style: MetricBubble.weightTextStyle,
                                focusNode: _weightFocusNode,
                                controller: _weightController,
                                keyboardType: TextInputType.number,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context).requestFocus(_weightFocusNode);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) return 'Empty!';
                                  if (int.parse(value!) < 0 || int.parse(value!) > 350) return 'Out of range';
                                  return null;
                                },
                                onSaved: (value) {
                                  widget.bodyWeight.weight = int.parse(value!);
                                },
                              ),
                            )
                          : Text(
                              widget.bodyWeight.weight == null ? '-' : '${widget.bodyWeight.weight}',
                              style: MetricBubble.weightTextStyle,
                            ),
                      if (!_editMode)
                        Text(
                          'lbs',
                          style: MetricBubble.unitTextStyle,
                        ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 2,
                  ),
                  Center(
                    child: SvgPicture.asset(
                      'images/graph.svg',
                    ),
                  ),
                ],
              ),
              if (_editMode)
                Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              print('cancel');
                              FocusScope.of(context).requestFocus(_labelFocusNode);
                              _labelController.clear();
                              _editMode = false;
                            });
                          },
                          child: Text('Cancel'),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white70,
                            shape: StadiumBorder(),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              _editMode = false;
                            }
                          });
                        },
                        child: Text('Done'),
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
