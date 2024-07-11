import 'package:crud_app_2/db/operations.dart';
import 'package:crud_app_2/modelos/notes.dart';
import 'package:flutter/material.dart';

class ActualizarPagina extends StatelessWidget {
 
  final Nota nota;
  final TextEditingController _tituloController;
  final TextEditingController _descripcionController;
  final _formKey = GlobalKey<FormState>();

  ActualizarPagina({super.key, required this.nota})
  : _tituloController = TextEditingController(text: nota.titulo),
    _descripcionController = TextEditingController(text: nota.descripcion);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar Nota'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: _tituloController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingrese un título';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Título de la Nota'
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _descripcionController,
              maxLength: 1000,
              maxLines: 4,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingrese descripción';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Descripción de la Nota'
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Actualizar Nota'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  nota.titulo = _tituloController.text;
                  nota.descripcion = _descripcionController.text;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Actualizando Nota')));

                  Operaciones.actualizarOperacion(nota);
                }
              }
            )
          ],
        ),
      ),
    ));
  }
}