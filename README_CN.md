
<p align="center">
<img width="600" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/projects/monotone/screens_cn/poster.png">
</p>

# Monotone
**Monotone**是一个现代化的移动端应用程序，与Unsplash.Inc所提供的强大的 [Unsplash官方API](https://unsplash.com/developers) 所集成。利用它可以轻松地进行照片的浏览，搜索，收藏，以及个人中心，许可证，FAQ等查阅等功能。  
这是一个**非官方**的应用程序，主要目的是发挥一些构想的可行性。它主要由Swift进行编写，使用RxSwift进行数据驱动，基于SnapKit绘制可响应式的约束布局。

如果您喜欢这个项目，或者被这个项目所启发创意，请毫不犹豫地点上一颗小星星。（笔者狂喜）

<br/>
<br/>

## 目录
- [预览](#预览)
- [已完成的开发项](#已完成的开发项)
    - [特性](#特性)
    - [功能](#功能)
- [上手指南](#上手指南)
    - [前置要求](#前置要求)
    - [安装工程](#安装工程)
- [依赖项](#依赖项)
- [工程结构](#工程结构)
- [设计](#设计)
- [关于Unsplash](#关于Unsplash)
- [持续贡献](#持续贡献)
    - [如何参与开源项目](#如何参与开源项目)
- [许可证](#许可证)

<br/>
<br/>

## 预览

<p align="center"> 
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/projects/monotone/screens_cn/screen-record-1.gif">
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/projects/monotone/screens_cn/screen-record-2.gif">
</p>

<p align="center"> 
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/projects/monotone/screens_cn/screen-shot-1.png">
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/projects/monotone/screens_cn/screen-shot-2.png">
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/projects/monotone/screens_cn/screen-shot-3.png">
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/projects/monotone/screens_cn/screen-shot-4.png">
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/projects/monotone/screens_cn/screen-shot-5.png">
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/projects/monotone/screens_cn/screen-shot-6.png">
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/projects/monotone/screens_cn/screen-shot-7.png">
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/projects/monotone/screens_cn/screen-shot-8.png">
</p>

<br/>
<br/>

## 已完成的开发项

<br/>

### 特性
- [x] 纯代码编写的界面
- [x] 深色模式支持
- [x] 动画效果
- [x] 本地化
- [x] 由Unsplash官方API进行数据驱动
- [X] 更多...

<br/>

### 功能
目前所支持的功能列表：

<table align="center">
    <tr>
        <th style="text-align:center">位置</th>
        <th style="text-align:center">模块</th>
        <th style="text-align:center">页面</th>
        <th style="text-align:center">样式布局</th>
        <th style="text-align:center">数据驱动</th>
        <th style="text-align:center">动画效果</th>
        <th style="text-align:center">本地化</th>
    </tr>
    <tr >
        <td align="center" rowspan="7">主要</td>
        <td align="center" rowspan="1">登录</td>
        <td align="center">登录 & 注册</td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
    </tr>
    <tr>
        <td align="center" rowspan="6">照片</td>
        <td align="center">列表（搜索 & 主题）</td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
    </tr>
    <tr>
        <td align="center">阅览</td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
    </tr>
    <tr>
        <td align="center">相机参数</td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
    </tr>
    <tr>
        <td align="center">收藏（添加 & 移除）</td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
    </tr>
    <tr>
        <td align="center">分享至社交媒体</td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled />         </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
    </tr>
    <tr>
        <td align="center">保存至相册</td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
    </tr>
    <tr >
        <td align="center" rowspan="6">侧边栏</td>
        <td align="center" rowspan="1">个人中心</td>
        <td align="center">详情</td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
    </tr>
    <tr>
        <td align="center" rowspan="5">菜单</td>
        <td align="center">我的照片</td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
    </tr>
    <tr>
        <td align="center">应募</td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled />         </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
    </tr>
    <tr>
        <td align="center">许可条例</td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
    </tr>
    <tr>
        <td align="center">帮助</td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled />         </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
    </tr>
    <tr>
        <td align="center">周边制作</td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled />         </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
    </tr>
    <tr >
        <td align="center" rowspan="6">底边栏</td>
        <td align="center" rowspan="2">商店</td>
        <td align="center">首页</td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled />         </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
    </tr>
        <tr>
        <td align="center">详情</td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled />         </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
    </tr>
    <tr>
        <td align="center" rowspan="1">壁纸</td>
        <td align="center">列表（按屏幕大小）</td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled />         </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
    </tr>
    <tr>
        <td align="center" rowspan="1">收藏</td>
        <td align="center">列表</td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
    </tr>
    <tr>
        <td align="center" rowspan="1">探索</td>
        <td align="center">列表（照片 & 收藏）</td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled />         </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
        <td align="center"><input type="checkbox" disabled checked /> </td>
    </tr>
</table>

<br/>
<br/>

## 上手指南
本应用程序使用Cocoapods进行依赖项的管理。  
请首先参照 [Cocoapods官方网站](https://cocoapods.org/) 的指引进行安装配置（如果您已经安装Cocoapods，可以跳过这一步）。

<br/>

### 前置要求
**Monotone**由Unsplash官方API进行数据驱动，为了使它正常运作，首先您需要申请一对OAuth密钥。
1. 访问 [Unsplash官方站点](https://unsplash.com)，注册并登录（如果您有已登录的账号，可以跳过这一步）；
2. 访问 [Unsplash应用程序注册平台](https://unsplash.com/oauth/applications/new) 同意条款并新建一个APP项目，表单中的名字（Application Name）与描述（Description）可以随意填写；
3. 在APP建立完成后，会自动跳转到APP详情页（您也可以在 <https://unsplash.com/oauth/applications> 中找到它）。在页面下方的”Redirect URI & Permissions - Redirect URI“中填写”monotone://unsplash“，并勾选相应许可，如下图所示，并保存；

<p align="center">
<img width="500" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/projects/monotone/app-redirect.png">
</p>

4. 完成以上工作后，记录页面中的”Access Key“与”Secret Key“，稍后会用到这对密钥。

<br/>

### 安装工程
请通过以下步骤进行安装。

1. 在终端执行如下命令：
``` bash
git clone https://github.com/Neko3000/Monotone.git

cd Monotone

pod install
```

2. 在**Monotone**根目录下拷贝一份名为```api_keys_sample.json```的文件，并把它重命名为```api_keys_debug.json```（这个文件被.gitignore所忽略）；
3. 打开```api_keys_debug.json```，填写您的”Access Key“与”Secret Key“，在运行时它们将会自动被拷贝至APP目录（具体请参考*Project->Build Phases->Run Script*以及*APPCredential.swift*内的内容）。
4. 完成，<kbd>command</kbd> + <kbd>R</kbd>。

<br/>
<br/>

## 依赖项
<table>
    <tr>
        <th>项目</th>
        <th>简述</th>
    </tr>
    <tr >
        <td>RxSwift</td>
        <td>响应式异步编程的框架。</td>
    </tr>
    <tr>
        <td>Action</td>
        <td>基于RxSwift，进一步封装Action来进行调用。</td>
    </tr>
    <tr>
        <td>DataSources</td>
        <td>基于RxSwift，扩展TableView和CollectionView的业务逻辑交互。</td>
    </tr>
    <tr>
        <td>Alamofire</td>
        <td>HTTP网络库。</td>
    </tr>
    <tr>
        <td>SwiftyJSON</td>
        <td>高效的处理JSON数据格式。</td>
    </tr>
    <tr>
        <td>ObjectMapper</td>
        <td>完成Model与JSON之间的映射。</td>
    </tr>
    <tr>
        <td>Kingfisher</td>
        <td>网络图片缓存与多种附加功能。</td>
    </tr>
    <tr>
        <td>SnapKit</td>
        <td>高效的约束布局。</td>
    </tr>
    <tr>
        <td>...</td>
        <td>...</td>
    </tr>
</table>

更多依赖项，请查看 [Podfile](https://github.com/Neko3000/Monotone/blob/master/Podfile)。

<br/>
<br/>

## 工程结构
基本的工程结构文件树如下。

```
Monotone 
├── Monotone
│   ├── /Vars  #全局变量
│   ├── /Enums  #枚举声明（包括了一些伪数据）
│   ├── /Application
│   │   ├── AppCredential  #授权凭证
│   │   ...
│   │   └── UserManager  #用户管理
│   ├── /Utils  #工具
│   │   ├── /BlurHash  #照片加载模糊效果
│   │   ├── ColorPalette  #全局颜色
│   │   ├── AnimatorTrigger  #动画效果
│   │   └── MessageCenter  #通知栏
│   │── /Extension  #扩展
│   │── /Services  #服务
│   │   ├── /Authentication  #授权相关请求
│   │   └── /Network  #数据相关请求
│   │── /Components  #视图类
│   │── /ViewModels  #视图模型类
│   │── /ViewControllers  #视图控制器类
│   │── /Models  #数据模型类
│   │── /Coordinators  #页面跳转
│   └── /Resource  #资源文件
└── Pods

```

<br/>
<br/>

## 设计
您所看到界面布局均由[Addie Design Co](https://dribbble.com/addiedesign)进行设计，并在互联网上免费共享了[这一份文稿](https://dribbble.com/shots/7232794-Unsplash-iOS-UI-Kit-Sketch-Invision-Studio)。不管是设计元素，还是完成度都是值得令人惊叹的。  
可以说没有这份免费共享的设计文稿，就没有这个应用程序的编写。  

感谢[Addie Design Co](https://dribbble.com/addiedesign)所提供的这份漂亮的设计文稿。

<br/>
<br/>

## 关于Unsplash
[Unsplash](https://unsplash.com) 是一个拥有较为自由的著作权许可条款的免费照片共享网站，具有非常高的质量。摄影师可以将照片上传，照片编辑者们会对用户上传的照片进行整理并归纳。

也是笔者本人非常钟爱的一个高质量照片网站，非常推崇这种富有艺术感的共享精神。  
笔者的主页在[这里](https://unsplash.com/@neko3000)，但是自从2020年初以后就减少了外出摄影次数。

<br/>
<br/>

## 持续贡献
受限于 [Unsplash官方API](https://unsplash.com/developers) 所提供的数据，该应用程序中的部分页面仅完成了样式布局，并没有使用真实数据（集中于商店，探索等模块），后续如果官方API提供了这些内容的数据源，也会第一时间添加新的功能。  
同时，针对已经完成的该应用程序，也会持续性的改进一些内容。

<br/>

### 如何参与开源项目
如果您对移动端应用程序的编写具有一定经验，并且想要改进这个应用程序，非常欢迎您参与这个开源项目。发挥您的构想，改进甚至重构这个应用程序。  
欢迎任何开发者对本项目提出ISSUE或者PR。

<br/>
<br/>

## 许可证
本应用程序项目基于 [MIT许可证](https://github.com/Neko3000/Monotone/blob/master/LICENSE) 进行分发。

<br/>
<br/>

