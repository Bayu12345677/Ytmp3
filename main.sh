#!/data/data/com.termux/files/usr/bin/bash

# Author : Bayu Riski A.M

: dari pada lu recode mending ikut kontribusi aja
: recode gak bakal ningkatin skill elu
: subrek juga channel pejuang kentang

# plugins bash moderen
. lib/moduler.sh
# include bash.mod
@require bash.mod
# set variable
: ${aio:=0}
: ${abc:=0}
: ${za:=0}
: ${slebew:=0}
# declarasikan class
const: __req__ = curlopt

# buat struktur oop youtube downloader
class __ytdl__;
{
  # object
  public: app = parse;
  public: app = download;

  # berfungsi untuk parse json ytmp3 api
  def: __ytdl__::parse()
  {
    global: url = "$@"

    curlopt.headers ["accept: application/json","user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36","uuid: b07b3327d0a0d4cac4bef48c96321a4b","content-type: application/x-www-form-urlencoded"]
    var ch : $(opt.options opsi="-sL --request POST --insecure --compressed --data-raw \"u=$url&c=ID\" \$__HEADER__")
    var res : $(curlopt.Curlexec uri="https://154.82.111.113.sslip.io/newp" CH="$ch")

    var id : $(@return: res|jq -r .data.id)
    var title : $(@return: res|jq -r .data.title)
    var durasi : $(@return: res|jq -r .data.duration)
  }
  # berfungsi untuk object download nya
  def: __ytdl__::download()
  {
    argv.get_arg ["$1"]; # url yt
    argv.get_arg ["$2"]; # output
 		argv.get_arg ["$3"]; # type

    __ytdl__::parse "$url"
    trap "rm -rf $output.mp3 $output.mp4 &>/dev/null; exit \?" INT SIGINT
    if ! (test -z $(@return: res|jq -r .data.mp3|grep -Po "(?<=mp3)[^}.]*"|tr -d '",')) || ! (test -f $(@return: res|jq -r .data.mp4|grep -Po "(?<=mp4){^}.]*"|tr -d '",')); then
      if (test "$Type" == "mp3"); then
        var dl : $(@return: res|jq -r .data.mp3);
        var ch : $(opt.options opsi="-sL --insecure --compressed -o ${output/.mp3/}.mp3")
        curlopt.Curlexec uri="$dl" CH="$ch"
      elif (test "$Type" == "mp4"); then
        var dl : $(@return: res|jq -r .data.mp4)
        var ch : $(opt.options opsi="-sL --insecure --compressed -o ${output/.mp4/}.mp4")
        curlopt.Curlexec uri="$dl" CH="$ch"
      fi
    elif (test -z $(@return: res|jq -r .data.mp3_cdn|grep -Po "(?<=mp3_cdn)[^}.]*"|tr -d '",')) || (test -z $(@return: res|jq -r .data.mp4_cdn|grep -Po "(?<=mp4_cdn)[^}.]*")); then
      if (test "$Type" == "mp3"); then
        var dl : $(@return: res|jq -r .data.mp3_cdn);
        var ch : $(opt.options opsi="-sL --insecure --compressed -o ${output/.mp3/}.mp3")
        curlopt.Curlexec uri="$dl" CH="$ch"
      elif (test "$Type" == "mp4"); then
        var dl : $(@return: res|jq -r .data.mp4_cdn)
        var ch : $(opt.options opsi="-sL --insecure --compressed -o ${output/.mp4/}.mp4")
        curlopt.Curlexec uri="$dl" CH="$ch"
      fi
    fi
  }
}
# deklarasikan kelas
const: __ytdl__ = ytdl
# animasi sederhana
def: animasi()
{
  global: text = "$@"
  frame=(
    "${ij}/${st}"
    "${me}_${st}"
    "${cy}\\${st}"
    "${ku}|${st}"
  );

  for xframe in ${frame[@]}; do
    tput sc
    Tulis.str "\r$text ${xframe}"; tput rc
    sleep 0.1
  done
}
# fungsi main
def: main()
{
  # bantu subs channel pejuang kentang
  xdg-open "https://youtube.com/channel/UCtu-GcxKL8kJBXpR1wfMgWg"
  trap "kill \"$slebew\" &> /dev/null; tput sgr0 cnorm; exit \?" INT SIGINT
  toilet -f big -F gay "Ytmp3"
  Tulis.strN "${cy}[\e[100m$m       Y${pu}outube ${me}d${pu}ownloader         $st${cy}]${st}\n"
  Tulis.strN "${ij}❑${pu} Author$me  :$pu Bayu Riski A.M"
  Tulis.strN "${me}❑${pu} Github$me  :$pu Bayu12345677"
  Tulis.strN "${ku}❑${pu} Youtube$me :$pu Pejuang Kentang"
  Tulis.strN ""
  Tulis.str "${cy}[\e[100m${ij}● ${me}● ${ku}● $st${cy}]${pu} masukan url ${me}:$st "; read p
  echo; tput civis
  while true; do
    animasi "${ku}●$pu Memeriksa url"
  done &
  let slebew=$!
  if ! (curl -sL "$p" --insecure --compressed -o /dev/null); then
    kill "$slebew" &> /dev/null
    tput ed
    Tulis.strN "${me}●$pu Url tidak valid"; tput cnorm; exit
  elif (ambil: p in "?feature"); then
    kill "$slebew" &> /dev/null
    tput ed
     Tulis.strN "${ku}[${me}+${ku}]${pu} format Tidak di ketahui ${ij}\$${me}/${ij}\$${m} (${hi}$p${m})$st"; tput cnorm; exit
  fi; kill "$slebew"&>/dev/null; tput ed
  tput sc
  animasi "${ku}❑$pu mengecek folder";tput rc
  if (mkdir /sdcard/Ytmp3 &> /dev/null); then
    var set_dir : "/sdcard/Ytmp3"
    else {
      true
    }; fi

  tput ed; {
    while true; do
      tput sc
      animasi "${ku}❑$pu Mencari video"
      tput rc
    done &  
    let slebew=$!
  { ytdl.parse "$p" && {
    var title : "$title"
    var durasi : "$durasi"
    var id : "$id"
    }; : sgr; try {
    	kill "$slebew" &> /dev/null
    	tput ed
    } catch {
    	kill "$slebew" &>/dev/null
    	tput ed
    };
  };
};

  tput sc; {
    Tulis.strN "${ku}[\e[100;1;35m            I${pu}nformasi ${me}v${pu}ideo               $st${ku}]\n"
    Tulis.strN "${me}►$pu Title$me    : ${pu}$title"
    Tulis.strN "${cy}►$pu Durasi$me   : ${pu}$durasi"
    Tulis.strN "${ij}►$pu id video$me : ${pu}$id\n"
  }; tput cnorm && Tulis.strN "${ku}❒${pu} Example ${ku}(${hi}[output]> lagu.#mp3 atau mp4${ku})\n";Tulis.str "$cy[\e[1;37mOutput$st$cy]$me➢$st "; read out
  tput rc;tput ed; tput civis
  echo
  animasi "${ku}❑$pu Memulai mengunduh"
  tput ed
  Tulis.strN "${ku}[$pu$(date +%H:%M:%S)${ku}]$pu Menyiapkan http request curl protocol ${me}(${hi}https${ku}/${hi}http${me})$st"
  # cek curl
  # kalo body try gagal di eksekusi bakal lanjutin ke catch
  try {
    command -v curl &> /dev/null
  } catch {
    echo
    Tulis.strN "${ku}[${pu}$(date +%H:%M:%S)${ku}]${pu} package curl ${me}(${hi}ERROR${me})${ku};${pu} status ${bi}*${ku}/${bi}*$pu curl tidak terinstall$st"; tput cnorm; exit
  };
  Tulis.strN "${ku}[${pu}$(date +%H:%M:%S)${ku}]$pu memeriksa koneksi ${ij}(${m}$p${ij})$st"
  var status : $(curl -sL "$p" --insecure --compressed -w %{http_code} -o /dev/null)
  Tulis.strN "${ku}[${pu}$(date +%H:%M:%S)${ku}]${pu} status code ${me}-${ij}>${ku} (${cy}$status${ku})${me} -${ij}>${ku} (${hi}$p${ku})$st"
  echo
  var typ : $(eval '@return: out|grep -o "mp3"||@return: out|grep -o "mp4"')
  Tulis.strN "${cy}[${pu}$(date +%H:%M:%S)${cy}]$pu status ${me}-${ij}>$pu curl ${ku}[${ij}done${ku}]$st"
  Tulis.strN "${ku}[${pu}$(date +%H:%M:%S)${ku}]$pu Type ${ku}=${me}>$pu $typ$st"
  echo; echo
  let abc=0
  let za=0
  let aio=0
  # rumus nikola tesla :v
  while true; do
    let abc++
    let za++
    let aio++
    let ynk=(x*100/100*100/100)
    local empty=$(Tulis.str "%${ynk}s")
    if ((abc == 1)); then var iii : "$ij"; var aaa : "$me"
    elif ((abc == 2)); then var iii : "$me"; var aaa : "$ku"
    elif ((abc == 3)); then var iii : "$ku"; var aaa : "$ij"
    elif ((abc == 4)); then var iii : "$bi"; var aaa : "$cy"
    elif ((abc == 5)); then var iii : "$cy"; var aaa : "$bi"
    fi

    zframe=(
      [1]="${ij}/$st"
      [2]="${me}_$st"
      [3]="${ku}\\$st"
      [4]="${cy}|$st"
    )

    aframe=(
      [1]="${ku}▉${st}........"
      [2]=".${me}▉${st}......."
      [3]="..${ij}▉${st}......"
      [4]="...${bi}▉${st}....."
      [5]="....${me}▉${st}...."
      [6]=".....${ij}▉${st}..."
      [7]="......${cy}▉${st}.."
      [8]=".......${ku}▉${st}."
      [9]="........${m}▉${st}"
      [10]=".......${ku}▉${st}."
      [11]="......${cy}▉${st}."
      [12]=".....${ij}▉${st}.."
      [13]="....${me}▉${st}..."
      [14]="...${bi}▉${st}...."
      [15]="..${ij}▉${st}....."
      [16]=".${ij}▉${st}......"
      [17]="${me}▉${st}......."
    )

    if ((za >= $((5*100/100-1)))); then
      let za=0
    fi
    if ((aio >= $((18 + 100 - 100 - 1)))); then
      let aio=0
    fi
    tput sc
    tput cuu 1
    Tulis.str "\r${iii}❒$st$pu downloading ${zframe[$za]} ${hi}[${pu}${aframe[$aio]}${hi}] $st"; sleep 0.1
    tput rc
  done &
  let slebew=$!
  var tip : $(@return: out|grep -o "mp3"||@return: out|grep -o "mp4")
  var tip : ${tip:-mp3}
  ytdl.download url="$p" Type="$tip" output="$out"
  var size : $(du -h "$out")
  # mv $out ${set_dir:-/sdcard/Ytmp3} 2> /dev/null
  sleep 4
  kill "$slebew" &> /dev/null
    mv $out ${set_dir:-/sdcard/Ytmp3} 2> /dev/null
  echo;echo;# yonglek anyink :v
 	echo -e "${ku}[${pu}$(date +%H:%M:%S)${ku}]${pu} size ${me}-${ij}>${pu} $size"
  echo -e "${ku}[${pu}$(date +%H:%M:%S)${ku}]$pu save ${me}-${ij}>$pu dir ${ku}=$pu $set_dir${ij};$pu name ${me}-${ij}>$pu $out$st"
  echo
  Tulis.strN "${me}[${ku}+${me}]$pu Proses Telah Selesai"
  Tulis.strN "${me}[${ku}+${me}]${pu} Total ${me}:${pu} $(date +%N)${hi}s${st}"; echo; tput cnorm sgr0; exit
}
# test class
#ytdl.download url="https://youtube.com/shorts/rEzk1WYl9Po?feature=share" Type="mp3" output="am"
