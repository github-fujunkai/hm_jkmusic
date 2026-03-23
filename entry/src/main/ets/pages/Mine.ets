
import { SongItemType,SongItemTypes } from '../models/music';

// 模拟数据
const myPlaylists: SongItemTypes[] = [
  { id: '1', name: '我喜欢的音乐', count: 128, cover: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=music%20playlist%20cover%20with%20heart%20symbol%20dark%20theme&image_size=square_hd' },
  { id: '2', name: '创建的歌单', count: 32, cover: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=music%20playlist%20cover%20dark%20theme%20creative&image_size=square_hd' },
  { id: '3', name: '最近播放', count: 56, cover: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=music%20playlist%20cover%20recent%20plays%20dark%20theme&image_size=square_hd' },
];

const recentSongs: SongItemType[] = [
  { id: '1', name: '起风了', author: '买辣椒也用券', img: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=chinese%20music%20album%20cover%20wind%20theme%20dark&image_size=square_hd', url: '' },
  { id: '2', name: '孤勇者', author: '陈奕迅', img: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=chinese%20music%20album%20cover%20hero%20theme%20dark&image_size=square_hd', url: '' },
  { id: '3', name: '海阔天空', author: 'Beyond', img: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=chinese%20music%20album%20cover%20ocean%20sky%20theme%20dark&image_size=square_hd', url: '' },
  { id: '4', name: '晴天', author: '周杰伦', img: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=chinese%20music%20album%20cover%20sunny%20day%20theme%20dark&image_size=square_hd', url: '' },
];

@ComponentV2
export struct Mine {
  @Local showSettings: boolean = false;

  @Builder
  PlaylistItem(playlist: SongItemTypes) {
    Column({
      space: 8
    }) {
      Image(playlist.cover)
        .width(100)
        .height(100)
        .borderRadius(8)
        .shadow({
          radius: 4,
          color: '#000000',
          offsetX: 0,
          offsetY: 2,
        });
      Text(playlist.name)
        .fontSize(14)
        .fontColor('#FFFFFF')
        .width(100)
        .textAlign(TextAlign.Center)
        .maxLines(1)
      Text(`${playlist.count}首`)
        .fontSize(12)
        .fontColor('#888888')
        .width(100)
        .textAlign(TextAlign.Center);
    }
  }
  
  @Builder
  SongItem(song: SongItemType) {
    Row({
      space: 12
    }) {
      Image(song.img)
        .width(56)
        .height(56)
        .borderRadius(4);
      Column({
        space: 4
      }) {
        Text(song.name)
          .fontSize(16)
          .fontColor('#FFFFFF')
          .maxLines(1)
        Text(song.author)
          .fontSize(14)
          .fontColor('#888888')
          .maxLines(1)
      }
      .flexGrow(1);
      Image($r('app.media.ic_more'))
        .width(24)
        .height(24)
        .fillColor('#888888');
    }
  }
  
  build() {
    Column({
      space: 20
    }) {
      // 用户信息区域
      Row({
        space: 16
      }) {
        Image('https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=user%20avatar%20profile%20picture%20dark%20theme&image_size=square_hd')
          .width(72)
          .height(72)
          .borderRadius(36)
          .border({
            width: 2,
            color: '#FFE59EC9'
          });
        Column({
          space: 4
        }) {
          Text('用户昵称')
            .fontSize(20)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Bold);
          Row({
            space: 8
          }) {
            Button('编辑资料')
              .fontSize(12)
              .fontColor('#FFFFFF')
              .backgroundColor('#3b3f42')
              .borderRadius(12)
              .padding(16);
            Button('设置')
              .fontSize(12)
              .fontColor('#FFFFFF')
              .backgroundColor('#3b3f42')
              .borderRadius(12)
              .padding(4)
              .onClick(() => {
                this.showSettings = true;
              });
          }
        }
        .flexGrow(1);
      }
      .padding(20);
      
      // 我的歌单区域
      Column({
        space: 12
      }) {
        Row() {
          Text('我的歌单')
            .fontSize(18)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Bold);
          Text('查看全部')
            .fontSize(14)
            .fontColor('#FFE59EC9');
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .padding(20);
        
        Flex({
          direction: FlexDirection.Row,
          wrap: FlexWrap.Wrap,
          justifyContent: FlexAlign.Start,
          alignItems: ItemAlign.Start,
        }) {
          ForEach(myPlaylists, (playlist:SongItemTypes) => {
            this.PlaylistItem(playlist);
          });
        }
        .padding(20);
      }
      
      // 最近播放区域
      Column({
        space: 12
      }) {
        Row() {
          Text('最近播放')
            .fontSize(18)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Bold);
          Text('查看全部')
            .fontSize(14)
            .fontColor('#FFE59EC9');
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .padding(20);
        
        List() {
          ForEach(recentSongs, (song:SongItemType) => {
            ListItem() {
              this.SongItem(song);
            }
            .padding(8);
          });
        }
        .width('100%')
        .height(240)
        .divider({
          strokeWidth: 0.5,
          color: '#3b3f42',
          startMargin: 88,
          endMargin: 20
        });
      }
      
      // 其他功能区域
      Column({
        space: 12
      }) {
        Row({
          space: 16
        }) {
          Column({
            space: 4
          }) {
            Image($r('app.media.ic_download'))
              .width(28)
              .height(28)
              .fillColor('#FFE59EC9');
            Text('下载管理')
              .fontSize(14)
              .fontColor('#FFFFFF');
          }
          .flexGrow(1)
          .alignItems(HorizontalAlign.Center);
          
          Column({
            space: 4
          }) {
            Image($r('app.media.ic_code'))
              .width(28)
              .height(28)
              .fillColor('#FFE59EC9');
            Text('播放历史')
              .fontSize(14)
              .fontColor('#FFFFFF');
          }
          .flexGrow(1)
          .alignItems(HorizontalAlign.Center);
          
          Column({
            space: 4
          }) {
            Image($r('app.media.ic_favorite'))
              .width(28)
              .height(28)
              .fillColor('#FFE59EC9');
            Text('我的收藏')
              .fontSize(14)
              .fontColor('#FFFFFF');
          }
          .flexGrow(1)
          .alignItems(HorizontalAlign.Center);
          
          Column({
            space: 4
          }) {
            Image($r('app.media.ic_code'))
              .width(28)
              .height(28)
              .fillColor('#FFE59EC9');
            Text('我的电台')
              .fontSize(14)
              .fontColor('#FFFFFF');
          }
          .flexGrow(1)
          .alignItems(HorizontalAlign.Center);
        }
        .padding(20);
      }
    }
    .backgroundColor('#131215')
    .flexGrow(1)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]);
  }
}