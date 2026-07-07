part of 'banner_cubit.dart';

sealed class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

final class BannerInitial extends BannerState {}

final class BannerLoading extends BannerState {}

final class BannerSuccess extends BannerState {
  final List<BannerItem> banner;

  BannerSuccess({required this.banner});

  @override
  List<Object> get props => [banner];
}

final class BannerError extends BannerState {
  final String message;

  BannerError({required this.message});
  @override
  List<Object> get props => [message];
}
