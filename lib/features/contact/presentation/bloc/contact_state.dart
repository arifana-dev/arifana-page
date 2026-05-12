part of 'contact_bloc.dart';

sealed class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object?> get props => [];
}

class ContactInitial extends ContactState {
  const ContactInitial();
}

class ContactLoaded extends ContactState {
  const ContactLoaded(this.info);

  final ContactInfo info;

  @override
  List<Object?> get props => [info];
}
