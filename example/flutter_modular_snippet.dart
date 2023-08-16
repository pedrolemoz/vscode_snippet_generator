import 'package:flutter_modular/flutter_modular.dart';

class $1Module extends Module {
  @override
  void binds(Injector i) {
    i.add($2.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/$3', child: (context) => $4());
  }
}
