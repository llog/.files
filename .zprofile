#export PATH=/Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home/bin:$PATH
# for rn
export ANDROID_HOME=$HOME/code/sdk
export ANDROID_SDK=$HOME/code/sdk
export ANDROID_NDK=$ANDROID_HOME/ndk/21.3.6528147
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
# for ft
export PATH=$PATH:$HOME/code/src/ft/depot_tools
export PATH=$PATH:$HOME/flutter/bin
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
# for ruby
export PATH=/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH

#export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

function ipaddr() {
    curl https://api.ipify.org
}

function proxy() {
	export http_proxy=socks5://127.0.0.1:1080
	export https_proxy=socks5://127.0.0.1:1080
}
function unproxy() {
	unset http_proxy
	unset https_proxy
}

function alog() {
    package=${1:-com.sankuai.meituan}
    while true
    do
        pid=$(adb shell pidof $package| cut -d ' ' -f1)
        if [ -n "$pid" ]; then
            break;
        else
            sleep 0.5
        fi
    done

    adb logcat -v threadtime -v color --pid=${pid}
}

function hylinux() {
    screen  $(sudo cat ~/Library/Containers/com.docker.docker/Data/vms/0/tty)
}

function hpx() {
    curl -sL https://hpx.sankuai.com/api/open/getProjectListNew\?os\=android\&pageNum\=1\&pageSize\=20000 \
        |jq '.data.list[]| {name: .name, id: .id, type: .type, description: .description, repoUrl: .repoUrl}
            |select(.repoUrl != null)|select(.repoUrl,.name|contains($key))
            |.url= (((.repoUrl|sub("ssh://git@git.sankuai.com";"https://dev.sankuai.com/code/repo-detail")
            |sub("ssh://git@git.dianpingoa.com"; "https://dev.sankuai.com/code/repo-detail")))
            |sub(".git"; "/file/list"))|.hpx="http://hpx.sankuai.com/" + (.type|sub("app"; "application")) + "/" + (.id|tostring)
            |del(.id, .type)' --arg key "$1"
}

function chrome() {
    [ ! -d $HOME/.chrome ] && { rm -rf $HOME/.chrome && mkdir $HOME/.chrome }
    open -na "Google Chrome" --args --disable-web-security --user-data-dir=$HOME/.chrome
}

function png2str() {
    [ -z $1 ] && { 
        echo "usage: png2str <url>" && return
    }
    md5_name=$(md5 -qs $1)
    {
        [ -f $1 ] && cat $1 || curl -sL $1
    } \
        | base64 | base64 -do /tmp/${md5_name}.png && echo "data:image/png;base64,$(base64 -i /tmp/${md5_name}.png)" && open /tmp/${md5_name}.png
}

func screencap() {
    out=screencap_$(date +%Y%m%d-%H%M%S).png
    adb exec-out screencap -p > $out && open $out
}

func hello() {
    git config user.name hello
    git config user.email hello@ifnot.cc
}

alias scrcpy="scrcpy --turn-screen-off --always-on-top --bit-rate 2M --max-size 1024"
alias cnpm="npm --registry=https://registry.npm.taobao.org \
--cache=$HOME/.npm/.cache/cnpm \
--disturl=https://npm.taobao.org/dist \
--userconfig=$HOME/.cnpmrc"
alias mnpm="npm --registry=http://r.npm.sankuai.com \
--cache=$HOME/.cache/mnpm \
--disturl=http://npm.sankuai.com/mirrors/node \
--userconfig=$HOME/.mnpmrc"
test -e /Users/xx/.iterm2_shell_integration.zsh && source /Users/xx/.iterm2_shell_integration.zsh || true

export NVM_DIR="/Users/xx/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export NVM_NODEJS_ORG_MIRROR=http://npm.sankuai.com/mirrors/node
export N_PREFIX=~/.n
export N_NODE_MIRROR=http://npm.sankuai.com/dist/node
export PATH=~/.n/bin:$PATH
