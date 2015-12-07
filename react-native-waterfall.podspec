Pod::Spec.new do |s|  
  s.name             = "react-native-waterfall"  
  s.version          = "1.0.0"  
  s.summary          = "基于UICollectionView实现的React Native 瀑布流"  
  s.description      = <<-DESC  
                       这是一个基于原生UICollectionView实现的React Native版本的瀑布流UI控件
  s.homepage         = "https://github.com/spricity/react-native-waterfall"  
  s.screenshots      = "https://img.alicdn.com/tps/TB1RkeXKVXXXXXsXFXXXXXXXXXX-750-1378.jpg"
  s.license          = 'MIT'  
  s.author           = { "崎轩" => "chuncheng.licc@taobao.com" }  
  s.source           = { :git => "https://github.com/spricity/react-native-waterfall.git", :tag => s.version.to_s }  
  
  s.platform     = :ios, '6.0'  
  s.requires_arc = true  
  
  s.source_files = 'RNWaterfall/*'  
  
  s.frameworks = 'Foundation', 'UIKit'  
  
end