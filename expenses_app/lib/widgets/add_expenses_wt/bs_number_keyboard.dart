import 'package:expenses_app/utils/constans.dart';
import 'package:flutter/material.dart';

class BSNumberKeyboard extends StatefulWidget {
  const BSNumberKeyboard({super.key});

  @override
  State<BSNumberKeyboard> createState() => _BSNumberKeyboardState();
}

class _BSNumberKeyboardState extends State<BSNumberKeyboard> {
  String import = '0.00';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _numPad();
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Text('Cantidad Ingresada'),
            Text(
              '\$ $import',
              style: const TextStyle(
                  fontSize: 30.0,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  _numPad() {
    if (import == '0.00') import = '';
    _number(String _text, double _heigth) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            import += _text;
          });
        },
        child: SizedBox(
          height: _heigth,
          child: Center(
            child: Text(
              _text,
              style: const TextStyle(fontSize: 35.0),
            ),
          ),
        ),
      );
    }

    showModalBottomSheet(
        barrierColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 350.0,
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              var heigth = constraints.biggest.height / 5;
              return Column(
                children: [
                  Table(
                    border: TableBorder.symmetric(
                        inside: const BorderSide(
                            /*color: Colors.grey,*/ width: 0.1)),
                    children: [
                      TableRow(children: [
                        _number(
                          '1',
                          heigth,
                        ),
                        _number('2', heigth),
                        _number('3', heigth)
                      ]),
                      TableRow(children: [
                        _number(
                          '4',
                          heigth,
                        ),
                        _number('5', heigth),
                        _number('6', heigth)
                      ]),
                      TableRow(children: [
                        _number(
                          '7',
                          heigth,
                        ),
                        _number('8', heigth),
                        _number('9', heigth)
                      ]),
                      TableRow(children: [
                        _number(
                          '.',
                          heigth,
                        ),
                        _number('0', heigth),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (import.length > 0.0) {
                                import = import.substring(0, import.length - 1);
                              }
                            });
                          },
                          behavior: HitTestBehavior.opaque,
                          child: SizedBox(
                            height: heigth,
                            child: const Icon(
                              Icons.backspace,
                              size: 35.0,
                            ),
                          ),
                        )
                      ])
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: Constants.customButtom(
                              Colors.transparent, Colors.red, 'Cancelar'),
                          onTap: () {
                            setState(() {
                              import = '0.00';
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Constants.customButtom(
                              Colors.transparent, Colors.green, 'Aceptar'),
                          onTap: () {
                            setState(() {
                              if (import.length == 0.0) import = '0.00';
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ),
                    ],
                  )
                ],
              );
            }),
          );
        });
  }
}
