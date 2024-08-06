import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_carros/presentation/cubits/motosierra_cubit.dart';
import 'package:front_carros/repository/motosierra_repository.dart';
import 'package:front_carros/presentation/motosierra_state.dart';
import 'package:front_carros/presentation/screens/add_edit_Motosierra_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final MotoSierraRepository motosierraRepository = MotoSierraRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<MotosierraCubit>(
          create: (context) => MotosierraCubit(motosierraRepository: motosierraRepository)..getMotosierras(),
        ),
      ],
      child: const  MaterialApp(
        title: 'Practica Motosierras',
        home: MotosierraListScreen(),
      ),
    );
  }
}

class MotosierraListScreen extends StatelessWidget {
  const MotosierraListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Motosierras'),
      ),
      body: BlocBuilder<MotosierraCubit, MotosierraState>(
        builder: (context, state) {
          if (state is MotosierraLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MotosierraSuccess) {
            return ListView.builder(
              itemCount: state.motosierra.length,
              itemBuilder: (context, index) {
                final motosierra = state.motosierra[index];
                return ListTile(
                  title: Text('${motosierra.brand} ${motosierra.model}'),
                  subtitle: Text(motosierra.power),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditMotosieraScreen(motosierra: motosierra),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<MotosierraCubit>().deleteMotosierra(motosierra.id);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditMotosieraScreen(motosierra: motosierra),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is MotosierraError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<MotosierraCubit>().getMotosierras();
                    },
                    child: const Text('Cargar otra vez'),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditMotosieraScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}