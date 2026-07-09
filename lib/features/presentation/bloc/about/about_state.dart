part of 'about_cubit.dart';

sealed class AboutState extends Equatable {
  const AboutState();

  @override
  List<Object> get props => [];
}

final class AboutInitial extends AboutState {}

final class AboutLoading extends AboutState {}

final class AboutSuccess extends AboutState {
  final List<AboutItem> about;

  AboutSuccess({required this.about});

  @override
  List<Object> get props => [about];
}

final class AboutError extends AboutState {
  final String message;

  AboutError({required this.message});
  @override
  List<Object> get props => [message];
}
