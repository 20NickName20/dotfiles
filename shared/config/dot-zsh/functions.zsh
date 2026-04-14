extract () {
  case $1 in
    *.tar.gz) tar xzf $1 ;;
    *.zip) unzip $1 ;;
    *.tar.bz2) tar xjf $1 ;;
    *) echo "unknown format" ;;
  esac
}

