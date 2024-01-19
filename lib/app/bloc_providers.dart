import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/main/bloc/main_bloc.dart';

blocProviders(BuildContext context) {
  return [
    BlocProvider.value(value: MainBloc()),
  ];
}
