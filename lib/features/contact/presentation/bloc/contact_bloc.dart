import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contact_repository.dart';
import '../../domain/contact_info.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc(this._repository) : super(const ContactInitial()) {
    on<ContactLoadRequested>(_onLoad);
  }

  final ContactRepository _repository;

  void _onLoad(ContactLoadRequested event, Emitter<ContactState> emit) {
    emit(ContactLoaded(_repository.getContactInfo()));
  }
}
