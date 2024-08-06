import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:front_carros/model/motosierra_model.dart';
import 'package:front_carros/presentation/cubits/motosierra_cubit.dart';

class AddEditMotosieraScreen extends StatefulWidget {
  final Motosierra? motosierra;

  const AddEditMotosieraScreen({super.key, this.motosierra});

  @override
  // ignore: library_private_types_in_public_api
  _AddEditMotosieraScreenState createState() => _AddEditMotosieraScreenState();
}

class _AddEditMotosieraScreenState extends State<AddEditMotosieraScreen> {
  final _formKey = GlobalKey<FormState>();
  late String brand;
  late String model;
  late String year;
  late String color;

  @override
  void initState() {
    super.initState();
    brand = widget.motosierra?.brand ?? '';
    model = widget.motosierra?.model ?? '';
    year = widget.motosierra?.power ?? '';
    color = widget.motosierra?.weigth ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.motosierra == null ? 'Registrar' : 'Editar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: brand,
                maxLength: 255,
                decoration: const InputDecoration(labelText: 'Marca'),
                onSaved: (value) => brand = value!,
                validator: (value) =>
                    value!.isEmpty ? 'La marca es requerida' : null,
              ),
              TextFormField(
                initialValue: model,
                maxLength: 255,
                decoration: const InputDecoration(labelText: 'Modelo'),
                onSaved: (value) => model = value!,
                validator: (value) =>
                    value!.isEmpty ? 'El modelo es requerido' : null,
              ),
              TextFormField(
                initialValue: year,
                maxLength: 4,
                decoration: const InputDecoration(labelText: 'Potencia'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onSaved: (value) => year = value!,
                validator: (value) =>
                    value!.isEmpty ? 'La potencia es requerida' : null,
              ),
              TextFormField(
                initialValue: color,
                maxLength: 255,
                decoration: const InputDecoration(labelText: 'Peso'),
                onSaved: (value) => color = value!,
                validator: (value) =>
                    value!.isEmpty ? 'El peso es requerido' : null,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final car = Motosierra(
                      id: widget.motosierra?.id ?? 0,
                      brand: brand,
                      model: model,
                      power: year,
                      weigth: color,
                    );
                    if (widget.motosierra == null) {
                      BlocProvider.of<MotosierraCubit>(context).saveMotosierra(car);
                    } else {
                      BlocProvider.of<MotosierraCubit>(context).updateMotosierra(car);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.motosierra == null ? 'Guardar' : 'Modificar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
