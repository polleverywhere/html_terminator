　　　　　 r┐　　　　　　　　　　　　　　　,r:ｰ'´.::.:: .:..｀ヽ、
　　　　　 |i |　　　　　　　　　　　 　 　 f´.::.,__.:::::..::::::::::::::ヽ
　　　　　 |l |　　　　　　　　　　　　　　ﾁr'´　　 ￣￣ヾ;::.:.|
　　　　 ,ｒ1｜　　　　　　　　　　　　　 ｷ| _＿ '´ ＿_ 　l;::..l
　　　　 |ｌ |｜　　　　　　　　　　　　　　}撻鬱ij!'徼i匐}ﾚ''１
　　　　 |lr' i|　　　　　　　　　　　　　 　f{｀~゛ﾂ; ヾ~´　iﾉ｝|
　　　　 ||ｌ　l|　　　　　　　　　　　 　 　 ぃ　　´'_｀　　　Y´
　　　　 |||　l|　　　　　　　　　　　　　　　 ﾄ､ ´￣ ｀　,ｨ{
　　　　 |||　i|　　　　　 　 　 　 　 　 　 　 |　｀ｰ-‐ '　　}｀iー -- ､
　　　　 |||　l|　　　　　　　　　　　　　　　 ,!　i　　 /　ノ　 l　_,シ ム
　　　　 |||　l|　　　　　　　　　　　　　　 〃ﾄ､＿,,,. ;i'ﾒ　　｜/ ,／　 ＼
　　　　｜! ∥　　　　　　　　　　　　 ／/lliiiiiiiiiiiiiiiill/{r―‐^ i〃/　　　 ヽ
　　　　｜ｌ ∥　　　　　　　　　 　 ／ ,ｲllliiiiiiiiiiiiillll/´　 ／r- ゝ 　' 　 　 l
　　　　｜| ∥　　　　　　 　 　 ／ ／´ﾌliiiiiiiiiilllll/　, 　／　　 |/　　　　｜
　　　　 jｌj　ｌ|　　　　 　 　 　 / ir'　 　 |liiiiiiiilllllli'　　／　　　　|　　　ーイ、
　　　　ﾑ- 、|　　　　　 　 　 ﾊ |, 　　 /iiiiillllllllll|　 /　　　　　 |　　　　　　i
　　　 ﾉ　　 ｀i　　　　　　　 /　ｌj　　 /llllllllllllllllll{／　　　　　　 l　　　　　　|
　　　 ヽ　　 /　 　 　 　 　 ｌ　｜　 /llllliillllllllllllll|　　　　　　 　 |　　　　 　 |
　　 ､r┤　,ﾑ､　　　　　 　 | ヽ|　 /lliiiiiiiiiillllllllllll}　　　 　 　 　 |　　　　　　|
　　 '{ヽ'r_'__　i　　 　 　 　 〉　 l　|iiiiiiiiiiiiiiilllllllllll|　　　　　　　　|　、　　　　|
　　 /〉ｰ-{　ｿト 、　　 　 / 　 ｜|iiiiiiiiiiiiiiiiiillllllll!、　　　　　　　|　　二　　 |
　　 しt_;ｭ',//　　 ヽ、 ／　　　 | |iiiiiiiiiiiiiiiiiiiiillllllヽ、　　　　 　 |　　　　｀　|
　 　 （_,イｰ'　　　 　 ´　　　　　| |iiiiiiiiiiiiiiiiiiiiiiiiiiiiiillヽ、　　　　 ||　　　 ヽ　|
　　　　 └-､ 　　ノ´　 　 　 　 | |iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii|　　　　　||　　　　　 |

# HtmlTerminator

Visits Active Record fields and terminates unsafe HTML.

## Installation

Add this line to your application's Gemfile:

    gem 'html_terminator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install html_terminator

## Usage

In your Rails models:

    terminate_html :field1, :field2, :field 3

or

    terminate_html :except => [:field8, :field9]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
