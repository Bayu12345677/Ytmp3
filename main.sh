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
  public: app = shorts;
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

  # kusus youtube sort
  def: __ytdl__::shorts()
  {
    argv.get_arg ["$1"];: url
    argv.get_arg ["$2"];: type opsi
    argv.get_arg ["$3"];: kualitas

    # cek type
    var ch : $(opt.options opsi="-sL --insecure --compressed")
    var base : $(curlopt.Curlexec uri="$url" CH="$ch")
    var bs : $(@return: base|grep -Po '(?<=ytInitialPlayerResponse\s=\s)(.*?)(?=;(?:var\smeta|<\/script>))')
    # cek status video biar work
    if (test $(@return: bs|jq -r .playabilityStatus.status) == "OK"); then
      # type
      if (call: [test "$tipe" == "info"]); then var aerox : $(call: [@return: bs]|jq -r .videoDetails)
        var videoId : $(call: [@return: aerox]|jq -r .videoID)
        var durasi : $(call: [@return: aerox]|jq -r .lengthSeconds)
        var sys_title : $(call: [@return: aerox]|jq -r .title)
        var title : "${sys_title/[[:space:]]#[a-zA-Z0-9]*/}"
        var channel : $(call: [@return: aerox]|jq -r .author)
      elif (call: [test "$tipe" == "download"]); then var aerox : $(call: [@return: bs]|jq -r .streamingData.formats[$resolusi])
        var get_data : $(call: [@return: aerox]|jq -r .url)
        var ch : $(opt.options opsi="-sL --insecure --compressed -o '${title}.mp4'")
        curlopt.Curlexec uri="$get_data" CH="$ch"
      fi
    else
         @return "${ku}[${bi}+${ku}]${pu} gagal mengambil data url${st}"
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
def: __main__()
{
  # bantu subs channel pejuang kentang
  xdg-open "https://youtube.com/channel/UCtu-GcxKL8kJBXpR1wfMgWg"
  tput reset
  trap "kill \"$slebew\" &> /dev/null; rm -rf \"\${title}.mp4\" &> /dev/null; tput sgr0 cnorm; exit \?" INT SIGINT
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
  tput rc
  let slebew=$!
  if ! (curl -sL "$p" --insecure --compressed -o /dev/null); then
    kill -0 "$slebew" &> /dev/null
    tput ed
    Tulis.strN "${me}●$pu Url tidak valid"; tput cnorm; exit
  elif (ambil: p in "shorts"); then
    kill -0 "$slebew" &> /dev/null
    tput ed
      tput sc
      animasi "${ku}(${me}•${ij}•${ku})${pu} mencari video" &
      let slebew=$!
      call: [ytdl.shorts tipe="info" url="$p"]
      kill "$slebew" &> /dev/null
      tput sc
      #rich "[bold][yellow]•[cyan]•[red]• [white]Informasi[red] •[cyan]•[yellow]•" -p --rule
      _text_="
[bold][yellow][[green]•[red]•[yellow]][white] Video id[red] :[white] $videoId
[bold][yellow][[green]•[red]•[yellow]][white] durasi[red]   :[white] $durasi
[bold][yellow][[green]•[red]•[yellow]][white] title[red]    :[white] $title
[bold][yellow][[green]•[red]•[yellow]][white] channel[red]  :[white] $channel
      "
      # ynkts
      #rich "$_text_" -p -a heavy | sed -e 's;┛\n;┛;g'
      # cari resolusi lah
      local __subrek_dong=($(@return: bs|jq -r .streamingData.formats[].qualityLabel))
      # maksimum opsi ya itu 4
        var ab : "[blue]0[red].[white] ${__subrek_dong[0]:-null}"
        var bz : "[blue]1[red].[white] ${__subrek_dong[1]:-null}"
        var batu : "[blue]2[red].[white] ${__subrek_dong[2]:-null}"
        var keong : "[blue]3[red].[white] ${__subrek_dong[3]:-null}"

      local _text_="
[bold][yellow][[green]•[red]•[yellow]][white] Video id[red] :[white] $videoId
[bold][yellow][[green]•[red]•[yellow]][white] title[red]    :[white] $title
[bold][yellow][[green]•[red]•[yellow]][white] channel[red]  :[white] $channel
[bold][yellow][[green]•[red]•[yellow]][white] durasi[red]   :[white] $durasi
[bold]-----------------------------------------------
[bold]            [yellow][[cyan]•[green]•[red]•[yellow]][red]>[white] Resolusi [red]<[yellow][[red]•[green]•[cyan]•[yellow]]
[bold]-----------------------------------------------
      $ab
      $bz
      $batu
      $keong
      "
      # Aldo hengker
      rich "$_text_" -p -a heavy --title "[bold][yellow]•[cyan]•[red]•[white] INFORMASI [red]•[cyan]•[yellow]•"
      tput cnorm
      Tulis.str "${ku}[${me}+${ku}]${pu} Select ${me}:${pu} "; read sel
      # buat beli aerox
      tput civis
      case $sel in
                  0)
                    if (ambil: ab in "null"); then
                      if (ambil: bz in "null"); then true; else let _resolusi=1; fi
                      if (ambil: batu in "null"); then true; else let _resolusi=2; fi
                      if (ambil: keong in "null"); then true; else let _resolusi=3; fi
                    else
                      let _resolusi=0
                    fi
                      ;;
                  1)
                    if (ambil: bz in "null"); then
                      if (ambil: batu in "null"); then true; else let _resolusi=2; fi
                      if (ambil: ab in "null"); then true; else let _resolusi=0; fi
                      if (ambil: keong in "null"); then true; else let _resolusi=3; fi
                    else
                      let _resolusi=1
                    fi
                      ;;
                  2) 
                    if (ambil: batu in "null"); then
                      if (ambil: bz in "null"); then true; else let _resolusi=1; fi
                      if (ambil: keong in "null"); then true; else let _resolusi=3; fi
                      if (ambil: ab in "null"); then true; else let _resolusi=0; fi
                    else
                      let _resolusi=2
                    fi
                      ;;
                  3)
                    if (ambil: keong in "null"); then
                      if (ambil: batu in "null"); then true; else let _resolusi=2; fi
                      if (ambil: bz in "null"); then true; else let _resolusi=1; fi
                      if (ambil: ab in "null"); then true; else let _resolusi=0; fi
                    else
                      let _resolusi=3
                    fi
                      ;;
                  *)
                      if (ambil: keong in "null"); then true; else let _resolusi=3; fi
                      if (ambil: bz in "null"); then true; else let _resolusi=1; fi
                      if (ambil: batu in "null"); then true; else let _resolusi=2; fi
                      if (ambil: ab in "null"); then true; else let _resolusi=0; fi
                      ;;
      esac; echo; echo
      rich "[blue]•[red]•[green]•[yellow] - [white]Downloading [yellow]-[green] •[red]•[blue]•" -p --rule
      let prog=0
      let arr=0
      ar_warn=(
        [1]="${ij}_${st}____________________________"
        [2]="${ij}__${st}___________________________"
        [3]="${ij}___${st}__________________________"
        [4]="${ij}____${st}_________________________"
        [5]="${ij}_____${st}________________________"
        [6]="${ij}______${st}_______________________"
        [7]="${ij}________${st}_____________________"
        [8]="${ij}_________${st}____________________"
        [9]="${ij}__________${st}___________________"
        [10]="${ij}___________${st}__________________"
        [11]="${ij}____________${st}_________________"
        [12]="${ij}_____________${st}________________"
        [13]="${ij}_______________${st}______________"
        [14]="${ij}________________${st}_____________"
        [15]="${ij}_________________${st}____________"
        [16]="${ij}__________________${st}___________"
        [17]="${ij}___________________${st}__________"
        [18]="${ij}____________________${st}_________"
        [19]="${ij}_____________________${st}________"
        [20]="${ij}______________________${st}_______"
        [21]="${ij}_______________________${st}______"
        [22]="${ij}________________________${st}_____"
        [23]="${ij}_________________________${st}____"
        [24]="${ij}__________________________${st}___"
        [25]="${ij}___________________________${st}__"
        [26]="${ij}____________________________${st}_"
        [27]="${ij}_____________________________${st}"
      ); echo
        while true; do
          #echo
          let prog++
          let arr++
          tput sc
          printf "[ ${hi}Downloading${me}: ${ar_warn[$arr]}${pu} ${prog}${ku}%%${st} ]"
          tput rc
          sleep 0.$(shuf -i 1-20 -n 1)
          if ((arr == 27)); then
            let arr=1
          fi
        done &
        let slebew=$!
        call: [ytdl.shorts url="$p" tipe="download" resolusi="$_resolusi"]
        let prog="100"
        let arr="27"
        kill "$slebew" &> /dev/null
        kill "$slebew" &> /dev/null
        echo
        rich "[red]•[green]•[cyan]•[yellow] -[while] Informations [yellow]- [cyan]•[green]•[red]•" -p --rule
        mkdir /sdcard/Ytmp3 &> /dev/null
        mv "$title.mp4" /sdcard/Ytmp3
        var siz : $(du -h "/sdcard/Ytmp3/$title.mp4")
        local _text_="
[bold][yellow]-[blue]⦒[white] video[red] : [white]${title}.mp4
[bold][yellow]-[green]⦒[white] type [red] : [white]shorts
[bold][yellow]-[cyan]⦒[white] save [red] : [white]/sdcard/Ytmp3
[bold][yellow]-[red]⦒[white] size [red] : [white]$siz
        "
        rich "$_text_" -p -a heavy --center
#        mkdir /sdcard/Ytmp3 &> /dev/null
 #       mv "$title.mp4" /sdcard/Ytmp3
        echo
        xdg-open "/sdcard/Ytmp3/$title.mp3"
        tput cnorm; exit
     #Tulis.strN "${ku}[${me}+${ku}]${pu} format Tidak di ketahui ${ij}\$${me}/${ij}\$${m} (${hi}$p${m})$st"; tput cnorm; exit
  fi
  kill "$slebew" 2> /dev/null
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
  let x=0
  while true; do
    let x++
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
    Tulis.str "\r${iii}❒$st$pu downloading ${hi}[${pu}${aframe[$aio]}${hi}]${cy} ${x}${ku}%%$st"; sleep 0.1
    tput rc
  done &
  let slebew=$!
  var tip : $(@return: out|grep -o "mp3"||@return: out|grep -o "mp4")
  var tip : ${tip:-mp3}
  ytdl.download url="$p" Type="$tip" output="$out"
  var size : $(du -h "$out")
  # mv $out ${set_dir:-/sdcard/Ytmp3} 2> /dev/null
  sleep 4
  let x=100
  kill "$slebew" &> /dev/null
    mv $out ${set_dir:-/sdcard/Ytmp3} 2> /dev/null
  echo;echo;# yonglek anyink :v
 	echo -e "${ku}[${pu}$(date +%H:%M:%S)${ku}]${pu} size ${me}-${ij}>${pu} $size"
  echo -e "${ku}[${pu}$(date +%H:%M:%S)${ku}]$pu save ${me}-${ij}>$pu dir ${ku}=$pu ${set_dir:-/sdcard/Ytmp3}${ij};$pu name ${me}-${ij}>$pu $out$st"
  echo
  Tulis.strN "${me}[${ku}+${me}]$pu Proses Telah Selesai"
  Tulis.strN "${me}[${ku}+${me}]${pu} Total ${me}:${pu} $(date +%N)${hi}s${st}"; echo; tput cnorm sgr0; exit
}
# test class
#ytdl.download url="https://youtube.com/shorts/rEzk1WYl9Po?feature=share" Type="mp3" output="am"
