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
    // funcion para detectar cuando hay mas de 3 digitod y pone una coma
    String Function(Match) mathFunc;
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc = (Match match) => '${match[1]},';
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
              '\$ ${import.replaceAllMapped(reg, mathFunc)}',
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
    number(String text, double heigth) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            import += text;
          });
        },
        child: SizedBox(
          height: heigth,
          child: Center(
            child: Text(
              text,
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
          return WillPopScope(
            onWillPop: () async => false,
            child: SizedBox(
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
                          number(
                            '1',
                            heigth,
                          ),
                          number('2', heigth),
                          number('3', heigth)
                        ]),
                        TableRow(children: [
                          number(
                            '4',
                            heigth,
                          ),
                          number('5', heigth),
                          number('6', heigth)
                        ]),
                        TableRow(children: [
                          number(
                            '7',
                            heigth,
                          ),
                          number('8', heigth),
                          number('9', heigth)
                        ]),
                        TableRow(children: [
                          number(
                            '.',
                            heigth,
                          ),
                          number('0', heigth),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              setState(() {
                                if (import.length > 0.0) {
                                  import =
                                      import.substring(0, import.length - 1);
                                }
                              });
                            },
                            onLongPress: () {
                              setState(() {
                                import = '';
                              });
                            },
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
            ),
          );
        });
  }
}
