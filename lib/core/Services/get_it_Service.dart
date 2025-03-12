//احنا هنا بنعمل نسخه وحده من الكلاس بدل منقهد نكتب كل كلاس وجواه الحاجات الي بيحتاجها فاحنا بندمعهم هنا ويوم منحب نستدعي حاجاه فيهم بنستدعيها من نوعها زي مثال ال firebaseService

import 'package:get_it/get_it.dart';
import 'package:graduation_project_ui/Features/Auth/data/Repos_impl/Auth_Repo_Impl.dart';
import 'package:graduation_project_ui/Features/Auth/domin/Repos/Auth_Repo.dart';
import 'package:graduation_project_ui/core/Services/Fire_Base_Auth_Service.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<FireBaseAuthService>(FireBaseAuthService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(firebaseAuthService: getIt<FireBaseAuthService>()),
  );
}
