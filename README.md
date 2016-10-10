# Agumon

引擎：cocos2d-x 3.13.1

####常用命令行
* 运行mac模拟器(分辨率：640x1136，放缩：0.75)；
		
		$ /Volumes/D/GitHub/Agumon/runtime/mac/Agumon-desktop.app/Contents/MacOS/Agumon-desktop /Volumes/D/GitHub/Agumon -resolution 640x1136 -scale 0.75

* 为android工程编译c++库(编译并打包工程)；
		
		$ cd /Agumon
		$ cocos compile -p android --android-studio  --ap android-21 --ndk-toolchain arm-linux-androideabi-4.8
				
####提交项目注意事项
* 调用`cocos compile -p android --android-studio ......`命令后，新增的文件在提交保存的时候可以删除，包括以下路径的内容（修改android工程影响的文件是否在下面路径中，还不知道）；

		/simulator/android/
		/frameworks/runtime-src/proj.android-studio/app/obj/
		/frameworks/runtime-src/proj.android-studio/app/libs/
		/frameworks/runtime-src/proj.android-studio/app/assets/
		
* 提交android-studio工程的时候，需要关闭android-studio，减少临时文件；

####所有命名遵循格式驼峰(详细百度)
	1.文件名  bigPig.png 
	2.变量名  bigPig
	3.类名    BigPig
	4.全局变量  BIGPIG
	5.枚举类型  enBigPig (en开头)
	6.方法名  funtion bigPig()

####代码结构 


