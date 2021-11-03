import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_movie_demo/home/update/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<HomeBloc>(context);
    bloc.add(GetDataHomeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
            backgroundColor: Colors.black,
            extendBody: true,
            extendBodyBehindAppBar: true,
            body: Stack(children: [
              Image.asset('assets/icon_top.png',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover),
              BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                if (state is LoadingHomeState)
                  return buildLoadingContainer();
                else if (state is ResponseHomeState)
                  return buildResponseColumn(state);
                else if (state is HomeFailureState)
                  return buildFailureColumn(state);
                return Container();
              })
            ])),
      ),
    );
  }

  Container buildLoadingContainer() {
    return Container(
      child: Center(child: CircularProgressIndicator(color: Colors.cyanAccent)),
    );
  }

  Column buildResponseColumn(ResponseHomeState state) {
    return Column(
      children: <Widget>[
        Expanded(child: SizedBox(), flex: 354),
        Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 8),
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
              child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: state.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: index == 0 ? 8 : 16,
                            bottom: index == state.list.length - 1 ? 8 : 0),
                        alignment: Alignment(0, 0),
                        width: double.infinity,
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  spreadRadius: 2,
                                  color: Color(0xFFE7E7E7))
                            ]),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '標題︰${state.list[index].title}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              Text('日期︰${state.list[index].releaseDate}')
                            ]));
                  }),
            ),
            flex: 371),
        Expanded(child: SizedBox(), flex: 75)
      ],
    );
  }

  Column buildFailureColumn(HomeFailureState state) {
    return Column(
      children: <Widget>[
        Expanded(child: SizedBox(), flex: 354),
        Expanded(
            child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.transparent,
                width: double.infinity,
                height: double.infinity,
                child: Center(child: Text(state.failureModel.message))),
            flex: 371),
        Expanded(child: SizedBox(), flex: 75)
      ],
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
