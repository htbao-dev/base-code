import 'package:dapass/data/datasource/local_datasource/auth_local_datasource.dart';
import 'package:dapass/data/datasource/remote_datasource/auth_remote_datasource.dart';
import 'package:dapass/data/repositories_impl/auth_repository_impl.dart';
import 'package:dapass/repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DependencyInjection extends StatelessWidget {
  const DependencyInjection({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _dataSource(
      child: _repository(
        child: child,
      ),
    );
  }

  Widget _dataSource({required Widget child}) {
    return MultiProvider(
      providers: [
        Provider<AuthRemoteDataSource>(
          create: (_) => AuthRemoteDataSourceImpl(),
        ),
        Provider<AuthLocalDataSource>(
          create: (_) => AuthLocalDataSourceImpl(),
        ),
      ],
      child: child,
    );
  }

  Widget _repository({required Widget child}) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            authRemoteDataSource:
                Provider.of<AuthRemoteDataSource>(context, listen: false),
            authLocalDatasource:
                Provider.of<AuthLocalDataSource>(context, listen: false),
          ),
        ),
      ],
      child: child,
    );
  }
}
