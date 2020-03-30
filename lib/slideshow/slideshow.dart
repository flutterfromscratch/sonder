import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonder/slideshow/bloc/bloc.dart';
import 'package:sonder/slideshow/license/about.dart';

const String SONDER_TEXT_HERO = "SonderTextHeroTag";

class SlideshowPage extends StatefulWidget {
//  final AnimationController controller = AnimationController();

  @override
  _SlideshowPageState createState() => _SlideshowPageState();
}

class _SlideshowPageState extends State<SlideshowPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _slideshowBloc = BlocProvider.of<SlideshowBloc>(context);
    return BlocListener<SlideshowBloc, SlideshowState>(
      listener: (context, state) {},
      child: BlocBuilder(
        bloc: _slideshowBloc,
        builder: (BuildContext context, SlideshowState state) {
          return state is DefineSonderState
              ? Container(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        _sonderText(),
//                          ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "(/ˈsɔn.dər/)",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline
                                    .copyWith(color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "The profound feeling of realizing that everyone, including strangers passed in the street,"
                          " has a life as complex as one's own, which they are constantly living despite one's personal lack of awareness of it. ",
                          style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        RaisedButton(
                          key: Key('experienceButton'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.white)),
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Experience",
                              style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            _slideshowBloc.add(StartSlideshowEvent());
                          },
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                )
              : state is ImageLoadedState
                  ? Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        AnimatedSwitcher(
                          duration: Duration(seconds: 5),
                          child: Image.memory(
                            state.imageBytes,
                            key: Key(state.imageBytes.hashCode.toString()),
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: _sonderText(),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                key: Key('aboutButton'),
                                color: Colors.white,
                                icon: Icon(Icons.landscape),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AboutPage(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
        },
      ),
    );
  }

  Widget _sonderText() => Hero(
        tag: "SonderLogo",
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              "S O N D E R",
              style: TextStyle(fontSize: 30, color: Colors.white, shadows: [
                Shadow(offset: Offset(0.0, 0.0), blurRadius: 5.0, color: Colors.white),
              ]),
            ),
          ),
        ),
      );
}
