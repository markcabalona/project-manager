import 'package:get_it/get_it.dart';

import 'features/auth/data/datasources/authenticator.dart';
import 'features/auth/data/datasources/firebase_authenticator.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/google_sign_in.dart';
import 'features/auth/domain/usecases/send_email_otp.dart';
import 'features/auth/domain/usecases/sign_in.dart';
import 'features/auth/domain/usecases/sign_out.dart';
import 'features/auth/domain/usecases/sign_up.dart';
import 'features/auth/domain/usecases/validate_email_otp.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/project/data/datasources/firebase_datasource.dart';
import 'features/project/data/datasources/remote_datasource.dart';
import 'features/project/data/repositories/project_repo_impl.dart';
import 'features/project/domain/repositories/project_repository.dart';
import 'features/project/domain/usecases/create_project.dart';
import 'features/project/domain/usecases/delete_project.dart';
import 'features/project/domain/usecases/fetch_projects.dart';
import 'features/project/domain/usecases/update_project.dart';
import 'features/project/presentation/bloc/project_bloc.dart';

final GetIt sl = GetIt.instance;

void init() {
  // FirebaseAuth
  // BloC
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      signIn: sl<SignIn>(),
      signUp: sl<SignUp>(),
      googleSignIn: sl<GoogleSignIn>(),
      signOut: sl<SignOut>(),
      sendEmailOTP: sl<SendEmailOTP>(),
      validateEmailOTP: sl<ValidateEmailOTP>(),
    ),
  );

  // Usecases
  sl.registerLazySingleton<SignIn>(
    () => SignIn(
      repository: sl<AuthRepository>(),
    ),
  );
  sl.registerLazySingleton<SignUp>(
    () => SignUp(
      repository: sl<AuthRepository>(),
    ),
  );
  sl.registerLazySingleton<GoogleSignIn>(
    () => GoogleSignIn(
      repository: sl<AuthRepository>(),
    ),
  );
  sl.registerLazySingleton<SignOut>(
    () => SignOut(
      repository: sl<AuthRepository>(),
    ),
  );
  sl.registerLazySingleton<SendEmailOTP>(
    () => SendEmailOTP(
      repository: sl<AuthRepository>(),
    ),
  );
  sl.registerLazySingleton<ValidateEmailOTP>(
    () => ValidateEmailOTP(
      repository: sl<AuthRepository>(),
    ),
  );

  // repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authenticator: sl<Authenticator>(),
    ),
  );

  // authenticator
  sl.registerLazySingleton<Authenticator>(
    () => FirebaseAuthenticator(),
  );

  sl.registerFactory<ProjectBloc>(
    () => ProjectBloc(
      createProject: sl<CreateProject>(),
      fetchProjects: sl<FetchProjects>(),
      updateProject: sl<UpdateProject>(),
      deleteProject: sl<DeleteProject>(),
    ),
  );

  // Usecases
  sl.registerLazySingleton<CreateProject>(
    () => CreateProject(repository: sl<ProjectRepository>()),
  );
  sl.registerLazySingleton<FetchProjects>(
    () => FetchProjects(repository: sl<ProjectRepository>()),
  );
  sl.registerLazySingleton<UpdateProject>(
    () => UpdateProject(repository: sl<ProjectRepository>()),
  );
  sl.registerLazySingleton<DeleteProject>(
    () => DeleteProject(repository: sl<ProjectRepository>()),
  );

  // Repository
  sl.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoryImpl(remoteDatasource: sl<RemoteDatasource>()),
  );

  //Datasource
  sl.registerLazySingleton<RemoteDatasource>(() => FirebaseDatasource());
}
