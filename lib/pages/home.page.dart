import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import '../PositionSeekWidget.dart';
import 'frist.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


  // Color primaryCol =Color(0xff1ED760); // green
Color primaryCol =Color(0xff8A051C);//maroon


  List<Map> songs = [
    {'song': 'Hammasi', 'artis': 'Massa','duration':'3:34', 'image' : 'music/images/66666e4cbc4616578a37030a3e0a218b.1000x565x1.jpg'},
    {'song': 'tushdi kech', 'artis': 'Massa','duration':'3:13','image' : 'music/images/1200x1200bf-60.jpg'},
    {'song': 'Soqqa','artis': 'Massa', 'duration':'3:04','image' : 'music/images/m1000x1000.jpg'},
    {'song': 'Man bilan', 'artis': 'Massa','duration':'3:05','image' : 'music/images/i.jpg'},
    {'song': 'Hammasi','artis': 'Massa', 'duration':'3:34','image' : 'music/images/66666e4cbc4616578a37030a3e0a218b.1000x565x1.jpg'},

  ];

final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

@override
void initState(){
  super.initState();
  setupPlaylist();


}

@override
void dispose(){
  super.dispose();
  audioPlayer.dispose();
}

void setupPlaylist() async{
  audioPlayer.open(Playlist(audios: [
    Audio('music/MASSA_-_Hammasi.mp3',
        metas: Metas(
          title: 'Hammasi',
          artist: 'Massa',
          onImageLoadFail:MetasImage.network('https://images.genius.com/66666e4cbc4616578a37030a3e0a218b.1000x565x1.jpg'),
        )),
    Audio('music/1595617080_massa-tushdi-kech.mp3',
          metas: Metas(
            title: 'Tushdi kech',
            artist: 'Massa',
            onImageLoadFail: MetasImage.network('https://images.genius.com/d6921bd5b31ac41c5658c5f14fffe159.1000x1000x1.jpg'),
          )),
    Audio('music/MASSA - Soqqa.mp3',   metas: Metas(
      title: 'Soqqa',
      artist: 'Massa',
      onImageLoadFail: MetasImage.asset('music/images/m1000x1000.jpg'),
    )),
    Audio('music/MASSA - Man Bilan.mp3',
        metas: Metas(
          title: 'Man bilan',
          artist: 'Massa',
          onImageLoadFail: MetasImage.asset('music/images/i.jpg'),
        )),
    Audio('music/MASSA_-_Hammasi.mp3', metas: Metas(
      title: 'Hammasi',
      artist: 'Massa',
      onImageLoadFail:MetasImage.network('https://images.genius.com/66666e4cbc4616578a37030a3e0a218b.1000x565x1.jpg'),
    )),
  ]),showNotification: true,autoStart: false,loopMode: LoopMode.playlist);

}


playMusic()async{
  await audioPlayer.play();
}

pauseMusic()async{
  await audioPlayer.pause();
}

skipPrevious()async{
  await audioPlayer.previous(keepLoopMode: true);
}

skipNext()async{
  await audioPlayer.next(keepLoopMode: true);
}

seekByBack()async{
  await audioPlayer.seekBy(Duration(seconds: -10));;
}

seekByNext()async{
  await audioPlayer.seekBy(const Duration(seconds: 10));;
}


shuffle()async{
  await audioPlayer.shuffle;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xffefefef),
        appBar: _homedAppBar(),
        body:  _homeBody(),
      bottomNavigationBar:_homeBottomMenu() ,
    );
  }

  SizedBox _homeBottomMenu() {
    return SizedBox(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child:   Container(
         child:  audioPlayer.builderIsPlaying(builder: (context, isPlaying,){
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                child: const Icon(Icons.shuffle),
            onTap:() => shuffle() ,),
            Center(
              child: Row(
                children:  [
                  FlatButton(
                      child: Icon(Icons.fast_rewind),
                    onPressed: () => skipPrevious(),
                    onLongPress:   () => seekByBack(),),
                  IconButton(
                    iconSize: 80,
                    icon: Icon(
                      isPlaying ? Icons.pause_circle_filled : Icons.play_arrow,
                      size: 80,),
                    onPressed:() => isPlaying? pauseMusic() : playMusic(),
                  ),
                  FlatButton(
                      child: const Icon(Icons.fast_forward),
                  onPressed: () => skipNext(),
                  onLongPress:   () => seekByNext(),),
                ],
              ),
            ),
            InkWell(
                child: const Icon(Icons.repeat),
            onTap:() => audioPlayer.shuffle)
          ],
        );
      }),
    )
    ));
}

  SizedBox _homeBody() {
    return SizedBox(
        width: double.infinity,
        child: audioPlayer.builderRealtimePlayingInfos(builder: (context, info,){
      return  Column(
              children: [
                Stack(
                  clipBehavior: Clip.none, children :[
                  Container(
                    width:MediaQuery.of(context).size.width * 0.7 ,
                    height: MediaQuery.of(context).size.height * 0.45,
                    decoration:   BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0, 20),
                            blurRadius: 30,
                            spreadRadius: 0,
                          )
                        ],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                          bottomRight: Radius.circular(100),),
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(primaryCol, BlendMode.softLight),
                          fit: BoxFit.cover,
                          image: AssetImage('${songs[info.current!.index]['image']}'),
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${songs[info.current!.index]['song']}',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600

                          ),),
                        const SizedBox(
                          height: 15,
                        ),
                        Text('${songs[info.current!.index]['artis']}',
                          style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                          ),),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
            ],
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 60,
                            right: 60),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton(
                                child: Text('${songs[index]['song']}',style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        color: index == info.current!.index
                                            ? primaryCol
                                            : Colors.black87,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700
                                    )
                                ),),
                                onPressed: (){print(info);},
                              ),
                              Text('${songs[index]['duration']}',style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: index == info.current!.index
                                          ? primaryCol:
                                      Colors.black87,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700
                                  )
                              ),),
                            ],
                          ),
                        ),
                      );
                    })
            ),
            PositionSeekWidget(
              currentPosition: info.currentPosition,
              duration: info.duration,
              seekTo: (to) {
                audioPlayer.seek(to);
              },
            ),
          ],

        );
      ;}));}

AppBar _homedAppBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      Transform.rotate(angle: 270/(180 / pi )),
    ],
  );
}

  }


