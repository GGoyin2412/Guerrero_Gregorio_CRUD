import 'package:crud_app_2/db/operations.dart';
import 'package:crud_app_2/paginas/actualizar_pagina.dart';
import 'package:crud_app_2/paginas/guardar_pagina.dart';
import 'package:flutter/material.dart';
import 'package:crud_app_2/modelos/notas.dart';

class ListPages extends StatelessWidget {
  const ListPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => GuardarPagina())
          );
      }),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('CRUD', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        child: _MiLista()
      ),
    );
  }
}

class _MiLista extends StatefulWidget {
  @override
  State<_MiLista> createState() => _MiListaState();
}

class _MiListaState extends State<_MiLista> {
  List<Nota> notas = [];
  
  @override
  void initState() {
    _cargarDatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notas.length,
      itemBuilder: (_, i) => _crearTEm(i),
    );
  }

  _cargarDatos() async {
    List<Nota> auxNotas = await Operaciones.obtenerNotas();
    setState(() {
      notas = auxNotas;
    });
  }

  _crearTEm(int i) {
    return Dismissible(
      key: Key(i.toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: const EdgeInsets.only(left: 10),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete, color: Colors.white, size: 30)),
      ),
      onDismissed: (direction) {
        Operaciones.eliminarOperacion(notas[i]);
      },
      child: ListTile(
        title: Text(notas[i].titulo),
        subtitle: Text(notas[i].descripcion),
        trailing: MaterialButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
            builder: (context) => ActualizarPagina(nota: notas[i])));
          },
          child: Icon(Icons.edit)),
      ),
    );
  }
}