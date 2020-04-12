import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonder/services/time.dart';
import 'package:sonder/slideshow/bloc/bloc.dart';
import 'package:sonder/slideshow/favourites/favourites.dart';
import 'package:sonder/slideshow/license/about.dart';

const String SONDER_TEXT_HERO = "SonderTextHeroTag";

class SlideshowPage extends StatefulWidget {
//  final AnimationController controller = AnimationController();

  @override
  _SlideshowPageState createState() => _SlideshowPageState();
}

class _SlideshowPageState extends State<SlideshowPage>
    with TickerProviderStateMixin {
  AnimationController animation;
  Animation<double> _fadeInGrow;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animation =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _fadeInGrow = Tween<double>(begin: 0.0, end: 300.0).animate(animation);
    animation.addListener(() {
      if (animation.isCompleted) {
        animation.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final time = RepositoryProvider.of<TimeService>(context);
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
                        _sonderText(hourOfDay: DateTime.now().hour),
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
                                    .headline1
                                    .copyWith(color: Colors.grey, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "The profound feeling of realizing that everyone, including strangers passed in the street,"
                          " has a life as complex as one's own, which they are constantly living despite one's personal lack of awareness of it. ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        RaisedButton(
                          key: Key('experienceButton'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.white)),
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Experience",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.white),
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
                        GestureDetector(
                          onDoubleTap: () {
                            print('double tap');
                            if (state.imageUrl != null) {
                              _slideshowBloc
                                  .add(AddFavouriteEvent(state.imageUrl));
                              animation.forward();
                            }
                          },
                          child: AnimatedSwitcher(
                            duration: Duration(seconds: 5),
                            child: Image.memory(
                              state.imageBytes,
                              key: Key(state.imageBytes.hashCode.toString()),
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                            ),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  IconButton(
                                    key: Key('favouritesButton'),
                                    color: Colors.white,
                                    icon: Icon(Icons.favorite),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FavouritesPage()));
                                    },
                                  ),
                                  IconButton(
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
                                  IconButton(
                                    key: Key('nextButton'),
                                    color: Colors.white,
                                    icon: Icon(Icons.navigate_next),
                                    onPressed: () {
                                      _slideshowBloc.add(ChangePictureEvent());
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: FadeTransition(
                            opacity: animation,
                            child: Center(
                              child: Icon(
                                Icons.favorite,
                                size: 80,
                                color: Colors.white,
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

  Widget _sonderText({int hourOfDay}) => Hero(
        tag: "SonderLogo",
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              RepositoryProvider.of<TimeService>(context)
                      .morningOrAfternoon(hourOfDay) +
                  "S O N D E R",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: Colors.white, shadows: [
                Shadow(
                    offset: Offset(0.0, 0.0),
                    blurRadius: 5.0,
                    color: Colors.white),
              ]),
            ),
          ),
        ),
      );
}
