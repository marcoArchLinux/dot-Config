## fish config file ##

set fish_greeting   ## supresses fish greeting ##

## prompt ##

function fish_prompt

    set -l retc red
    test $status = 0; and set retc green

    set -q __fish_git_prompt_showupstream
    or set -g __fish_git_prompt_showupstream auto

    function _nim_prompt_wrapper
        set retc $argv[1]
        set field_name $argv[2]
        set field_value $argv[3]

        set_color normal
        set_color $retc
        echo -n '─'
        set_color -o green
        echo -n '['
        set_color normal
        test -n $field_name
        and echo -n $field_name:
        set_color $retc
        echo -n $field_value
        set_color -o green
        echo -n ']'
    end

   
    if test "$USER" = root -o "$USER" = toor
        set_color -o red
    else
        set_color -o yellow
    end
    echo -n $USER
    set_color -o white
    echo -n @
    if [ -z "$SSH_CLIENT" ]
        set_color -o blue
    else
        set_color -o cyan
    end
    echo -n (prompt_hostname)
    set_color -o white
    echo -n :(prompt_pwd)" "

    set_color -o white
    echo -n '$ '
    set_color normal
end

## fish prompt end ##

## spark ##

set -g spark_version 1.0.0

complete -xc spark -n __fish_use_subcommand -a --help -d "Show usage help"
complete -xc spark -n __fish_use_subcommand -a --version -d "$spark_version"
complete -xc spark -n __fish_use_subcommand -a --min -d "Minimum range value"
complete -xc spark -n __fish_use_subcommand -a --max -d "Maximum range value"

function spark -d "sparkline generator"
    if isatty
        switch "$argv"
            case {,-}-v{ersion,}
                echo "spark version $spark_version"
            case {,-}-h{elp,}
                echo "usage: spark [--min=<n> --max=<n>] <numbers...>  Draw sparklines"
                echo "examples:"
                echo "       spark 1 2 3 4"
                echo "       seq 100 | sort -R | spark"
                echo "       awk \\\$0=length spark.fish | spark"
            case \*
                echo $argv | spark $argv
        end
        return
    end

    command awk -v FS="[[:space:],]*" -v argv="$argv" '
        BEGIN {
            min = match(argv, /--min=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
            max = match(argv, /--max=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
        }
        {
            for (i = j = 1; i <= NF; i++) {
                if ($i ~ /^--/) continue
                if ($i !~ /^-?[0-9]/) data[count + j++] = ""
                else {
                    v = data[count + j++] = int($i)
                    if (max == "" && min == "") max = min = v
                    if (max < v) max = v
                    if (min > v ) min = v
                }
            }
            count += j - 1
        }
        END {
            n = split(min == max && max ? "▅ ▅" : "▁ ▂ ▃ ▄ ▅ ▆ ▇ █", blocks, " ")
            scale = (scale = int(256 * (max - min) / (n - 1))) ? scale : 1
            for (i = 1; i <= count; i++)
                out = out (data[i] == "" ? " " : blocks[idx = int(256 * (data[i] - min) / scale) + 1])
            print out
        }
    '
end

## spark end ## 

## BangBang & Prev Args ##

  # BangBang #

function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

  # BangBang end #

####################

  # Prev Args #

 
function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

  # Prev Args end #

## BangBang & Prev Args end #

## Arch ShortCuts ##

  # Pacman #

  # pacman -R #

function prm -d "pacman -R"
  sudo pacman -R $argv
end

  # pacman -S #

function pin -d "pacman -S"
  sudo pacman -S $argv
end

  # pacman -Syu #

function pug -d "pacman -Syu"
  sudo pacman -Syu $argv
end

  # pacman -Sy #

function pud -d "pacman -Sy"
  sudo pacman -Sy $argv
end

  # pacman end #

  # yay #

function yin 
  yay -S $argv
end

function ysy
  yay -Sy $argv
end

function yrm
  yay -R $argv
end

## Arch shortcuts ##

## misc shortcuts ##

  # legendary #

function lin
  legendary install $argv
end

function lun
  legendary uninstall $argv
end

function llg
  legendary list-games
end

function lli
  legendary list-installed
end

 # ufw #
 
function ufe
    sudo ufw enable
end

function ufd
    sudo ufw disable
end

function ufs
    sudo ufw status
end

function ufa
    sudo ufw $argv
end

## fun stuff ##

function cum
  echo 69
end

function gld
  glava --desktop
end

function rspark
 spark $argv | lolcat
end
