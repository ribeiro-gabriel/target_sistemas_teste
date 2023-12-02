import 'package:equatable/equatable.dart';

///[ValueObject<T>] standardize the validation of the objects which should
///return either [String?] representing the error message either the value
abstract class ValueObject<T> extends Equatable {
  final T value;

  const ValueObject(this.value);

  (String?, ValueObject<T>) validate();

  @override
  List<Object?> get props => [value];
}
