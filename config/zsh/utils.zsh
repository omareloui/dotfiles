# Functions
extract() {
  case $1 in
    *.tar.bz | *.tar.bz2 | *.tar.tbz | *.tar.tbz2)
      foldername="$(basename "${1%%.*}")"
      [[ ! -d $foldername ]] && mkdir $foldername
      tar xjvf "$1" -C "$foldername"
      ;;
    *.tar.gz | *.tar.tgz)
      foldername="$(basename "${1%%.*}")"
      [[ ! -d $foldername ]] && mkdir $foldername
      tar xzvf "$1" -C "$foldername"
      ;;
    *.tar.xz | *.tar.txz)
      foldername="$(basename "${1%%.*}")"
      [[ ! -d $foldername ]] && mkdir $foldername
      tar xJvf "$1" -C "$foldername"
      ;;
    *.zip)
      unzip "$1"
      ;;
    *.rar)
      unrar x "$1"
      ;;
    *.7z)
      7z x "$1"
      ;;
    *)
      echo -e "\e[31mError\e[33m:\e[0m Didn't find a function to exctract $1"
      ;;
  esac
}
