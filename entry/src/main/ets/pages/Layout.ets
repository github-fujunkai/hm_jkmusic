import { Component } from "@kit.TestKit";
import { Find } from "./Find";
import { Mine } from "./Mine";
import { Moment } from "./Moment";
import { Recommend } from "./Recommend";
import { AppStorageV2 } from "@kit.ArkUI";

@Builder
export function LayoutBuilder() {
  Layout();
}


interface TabClass {
  text: string
  icon: ResourceStr
}




@ComponentV2
export struct Layout {
  // navPathStack: NavPathStack = new NavPathStack();
  //AppStorageV2是提供状态变量在应用级全局共享的能力，开发者可以通过connect绑定同一个key，进行跨ability的数据共享。
  navPathStack: NavPathStack = AppStorageV2.connect(NavPathStack,'navStack',()=>new NavPathStack())!

  @Local currentIndex: number = 0
  tabData: TabClass[] = [
    {text: '推荐', icon: $r('app.media.ic_recommend')},
    {text: '发现', icon: $r('app.media.ic_find')},
    {text: '动态', icon: $r('app.media.ic_moment')},
    {text: '我的', icon: $r('app.media.ic_mine')}
  ]


  @Builder
  TabBuilder(item: TabClass,index:number) {
    Column({ space: 5 }) { //设置上下间距
      Image(item.icon)
        .width(24)
        .fillColor(this.currentIndex === index? '#FFE59EC9' :'#63AAAA') //svg使用fillColor设置颜色
      Text(item.text)
        .fontColor(this.currentIndex === index? '#FFE59EC9' :'#63AAAA')
    }
  }

  build() {
    NavDestination() {
      Tabs({barPosition:BarPosition.End}) {
        ForEach(this.tabData, (item: TabClass, index) => {
          TabContent() {
            if (this.currentIndex === 0) {
              Recommend()
            }else if(this.currentIndex === 1) {
              Find()
            }else if(this.currentIndex === 2) {
              Moment()
            }else if(this.currentIndex === 3) {
              Mine()
            }

          }
          .tabBar(this.TabBuilder(item,index)) // tabBar这里菜单比较基础，用@Builder自定义菜单
          .backgroundColor('#131215')
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
        })
      }
      .backgroundColor('#3b3f42')
      .onChange((index:number) => {
        this.currentIndex = index
        console.log('当前数据',index)
      })
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
    .onReady((ctx: NavDestinationContext) => {
      // NavDestinationContext获取当前所在的导航控制器
      this.navPathStack = ctx.pathStack; //把自己放在跳转对象中
    })
  }
}