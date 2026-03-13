@Entry
@Component
struct NavigationDemo {
  @Provide('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  private listArray: Array<string> = ['WLAN', 'Bluetooth', 'Personal Hotspot', 'Connect & Share'];
  context = this.getUIContext().getHostContext();

  build() {
    Navigation(this.navPathStack) {
    }.onAppear(()=>{
      this.navPathStack.pushPathByName('Start', null, false); // 将页面压入导航栈，参数为页面名称、传递参数、是否替换当前页面
    })
    .hideNavBar(true) // 不会进入跳转逻辑，返回也不会返回到这里
  }
}
