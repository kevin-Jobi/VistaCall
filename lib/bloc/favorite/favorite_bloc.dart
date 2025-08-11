// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'favorite_event.dart';
// part 'favorite_state.dart';

// class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
//   FavoriteBloc() : super(FavoriteInitial()) {
//     on<FavoriteEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/favorite/favorite_event.dart';
import 'package:vistacall/bloc/favorite/favorite_state.dart';
import 'package:vistacall/repositories/doctor_repository.dart';

class FavoriteDoctorsBloc extends Bloc<FavoriteDoctorsEvent,FavoriteDoctorsState> {
  final DoctorRepository _repository;

  FavoriteDoctorsBloc(this._repository) : super(FavoriteDoctorsInitial()){
    on<LoadFavoriteDoctors>(_onLoadFavoriteDoctors);
  }

  Future<void> _onLoadFavoriteDoctors(
    LoadFavoriteDoctors event,
    Emitter<FavoriteDoctorsState> emit
  ) async{
    emit(FavoriteDoctorsLoading());
    try{
      final doctors = await _repository.fetchFavoriteDoctors();
      emit(FavoriteDoctorsLoaded(doctors));
    } catch(e){
      emit(FavoriteDoctorsError(e.toString()));
    }
  }
}