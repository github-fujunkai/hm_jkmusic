@Builder
export function StartBuilder() {
  Start();
}

@Component
struct Start {
  // 控制跳转的对象
  navPathStack: NavPathStack = new NavPathStack();
  name: string = '';
  @State value: string = '';
  @State time: number = 3;
  context = this.getUIContext().getHostContext();


  aboutToAppear(): void {
    // 靠这里会导致重新跳转this.navPathStack.replacePathByName('Layout',null,false)
    // 会造成bug
    // setInterval(()=>{
    //   if(this.time>1){
    //     this.time--
    //   }else{
    //     this.navPathStack.replacePathByName('Layout',null,false)
    //   }
    // },1000)
  }
  build() {
    NavDestination() {
      Stack({alignContent:Alignment.TopEnd}){
        Image($r('app.media.ad')).width('100%').height('100%').expandSafeArea()
        Button(`跳过${this.time}s`).onClick((event: ClickEvent) => {
          this.navPathStack.replacePathByName('Layout',null,false)
        }).backgroundColor('#97cfc6c6').margin({right:15})
      }
    }
    .onReady((ctx: NavDestinationContext) => {
      // NavDestinationContext获取当前所在的导航控制器
      this.navPathStack = ctx.pathStack; //把自己放在跳转对象中
    })

  }
}