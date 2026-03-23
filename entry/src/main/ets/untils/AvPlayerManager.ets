import { media } from '@kit.MediaKit'
import { SongItemType } from '../models/music'
import { AppStorageV2 } from '@kit.ArkUI'
import { GlobalMusic } from '../models/globalMusic'

class AvPlayerManager {

  // 定义播放器
  player: media.AVPlayer | null = null

  // 共享播放器数据
  currentSong:GlobalMusic = AppStorageV2.connect(GlobalMusic,'SONG_KEY',()=> new GlobalMusic())!


  // 创建播放器 + 监听状态
  async init () {   // 要在entryability中调用初始化
    if(!this.player) {
      this.player = await media.createAVPlayer()
    }

    //监听状态
    this.player.on('stateChange',(state) =>{
      if (state === 'initialized') { // 初始化完成
          this.player?.prepare()  //准备加载资源了
      }
      if (state === 'prepared') { // 资源加载玩完成
          this.player?.play()  //准备播放了
      }
    })

    //监听时间变化
    this.player.on('durationUpdate',(duration)=>{
      this.currentSong.duration = duration
    })

    this.player.on('timeUpdate',(time)=>{
      this.currentSong.time = time
    })



  }
  // 播放歌曲的方法 / 当前播放
  singPlay (song:SongItemType){
    this.player!.url = song.url
    this.currentSong.img = song.img
  }
  //跳转进度seek
  seekPlay(value:number){
    this.player?.seek(value)
  }
}


export const playerManager: AvPlayerManager = new AvPlayerManager()