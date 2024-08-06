import 'package:bloc/bloc.dart';
import 'package:front_carros/model/motosierra_model.dart';
import 'package:front_carros/presentation/motosierra_state.dart';
import 'package:front_carros/repository/motosierra_repository.dart';

class MotosierraCubit extends Cubit<MotosierraState>{
  final MotoSierraRepository motosierraRepository;

  MotosierraCubit({required this.motosierraRepository}) : super(MotosierraInitial());
  Future<void> getMotosierras() async {
    try{
      emit(MotosierraLoading());
      final motosierras = await motosierraRepository.getMotosierras();
      emit(MotosierraSuccess(motosierra: motosierras));
    }catch(e){
      emit(MotosierraError(message: e.toString()));
    }
  }

  Future<void> saveMotosierra(Motosierra motosierra) async {
    try{
      emit(MotosierraLoading());
      await motosierraRepository.saveMotosierra(motosierra);
      getMotosierras();
    }catch(e){
      emit(MotosierraError(message: e.toString()));
    }
  }

  Future<void> updateMotosierra(Motosierra motosierra) async {
    try{
      emit(MotosierraLoading());
      await motosierraRepository.updateMotosierra(motosierra);
      getMotosierras();
    }catch(e){
      emit(MotosierraError(message: e.toString()));
    }
  }

  Future<void> deleteMotosierra(int id) async {
    try{
      emit(MotosierraLoading());
      await motosierraRepository.deleteMotosierra(id);
      getMotosierras();
    }catch(e){
      emit(MotosierraError(message: e.toString()));
    }
  }
}