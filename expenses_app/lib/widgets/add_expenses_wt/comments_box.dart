import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  const CommentBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          const Icon(
            Icons.sticky_note_2_outlined,
            size: 35.0,
          ),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
              child: TextFormField(
            keyboardType: TextInputType.text,
            maxLength: 50,
            decoration: InputDecoration(
                counterText: '',
                hintText: 'Agregar descripcion (Opcional)',
                hintStyle: const TextStyle(fontSize: 12.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Colors.blue))),
          ))
        ],
      ),
    );
  }
}
