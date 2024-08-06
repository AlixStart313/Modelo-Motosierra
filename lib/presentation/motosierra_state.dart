import 'package:equatable/equatable.dart';
import 'package:front_carros/model/motosierra_model.dart';


abstract class MotosierraState extends Equatable {
  const MotosierraState();

  @override
  List<Object> get props => [];
}

class MotosierraInitial extends MotosierraState{}

class MotosierraLoading extends MotosierraState{}

class MotosierraSuccess extends MotosierraState{
  final List<Motosierra> motosierra;
  const MotosierraSuccess({required this.motosierra});

  @override
  List<Object> get props => [motosierra];
}

class MotosierraError extends MotosierraState{
  final String message;
  const MotosierraError({required this.message});

  @override
  List<Object> get props => [message];
}