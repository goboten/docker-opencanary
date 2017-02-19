# docker-opencanary
opencanary(honeypot) Dockerfile  

ハニーポットであるopencanaryをDockerで動かすためのファイルです。  
ファイル共有のsambaも動いているので事前に準備が必要です。  
$ sudo mkdir -p /smb/home  
$ sudo touch /smb/home/password.txt  
$ sudo vi /smb/home/password.txt   
※ 作成したpassword.txtに何か文字を入れて1バイト以上のファイルにしてください。  

また、重要な設定として詳細な設定方法は書きませんがsshのポートもハニーポットとして動かすため、sshの待ち受けポートを22から適当な番号(2222など)に変更してください。  
opencanaryはjson形式で通信することができるため、fluentをポート1514で待ち受ければデータの受信が可能なので、そのままelasticsearchに流し込めば便利だと思います。

●ビルドについては普通に以下のコマンドでやるのがいいと思います。  

$ sudo docker build -t opencanary ./

●システムの起動について
dockerを実行するときにopencanary では、fluentなどにデータを飛ばすために「-e DEST_IP="host_ipaddress"」の指定が必要です。
例えば 10.1.1.1 な感じです。  

$ sudo docker run --name opencanary --cap-add=NET_BIND_SERVICE -d -p 21:21 -p 22:22 -p 23:23 -p 69:69 -p 80:80 -p 139:139 -p 445:445 -p 1433:1433 -p 3306:3306 -p 3389:3389 -p 5060:5060/UDP -p 5900:5900 -v /smb/home/:/smb/home/ -e DEST_IP="10.1.1.1" opencanary
