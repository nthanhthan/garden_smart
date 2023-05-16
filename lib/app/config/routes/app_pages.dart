import 'package:foodapp/app/pages/detail_room/views/control_view.dart';

import '../../core.dart';
part 'app_routes.dart';

class AppPages {
  static const intilial = Routes.main;
  static final routes = [
    GetPage<dynamic>(
      name: Routes.main,
      page: () => const MainView(),
      binding: MainBinding(),
      transition: Transition.zoom,
    ),
    GetPage<dynamic>(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.signIn,
      page: () => const SignInView(),
      binding: SignInBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.register,
      page: () => const RegisterView(),
      binding: SignInBinding(),
      transition: Transition.rightToLeft,
    ),
       GetPage<dynamic>(
      name: Routes.detailRoom,
      page: () => const DetailRoomView(),
      binding: DetailRoomBinding(),
      transition: Transition.rightToLeft,
    ),
        GetPage<dynamic>(
      name: Routes.control,
      page: () => const ControlView(),
      binding: DetailRoomBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
