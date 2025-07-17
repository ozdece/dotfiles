source ~/.config/fish/git_utility.fish
source ~/.asdf/asdf.fish


if status is-interactive
    set fish_greeting # Remove fish greeting
    
    # Extending PATH variable
    set -x PATH $PATH:.
    set -x PKG_CONFIG_PATH "/usr/lib/pkgconfig:/usr/share/pkgconfig:$PKG_CONFIG_PATH"


    fish_add_path -g ~/bin
    fish_add_path -g ~/.asdf
    fish_add_path -g ~/.asdf/bin
    fish_add_path -g ~/bin
    fish_add_path -g ~/.local/bin
    fish_add_path -g ~/.cargo/bin

    #Add Abbreviations
    abbr gs git status
    abbr gco git commit
    abbr gaa git add .
    abbr el exa -lah
    abbr gb git allBranches
    abbr gp git push
    abbr t tmux attach
    abbr tm-ls tmux ls

    # CMake abbrs
    abbr cmake-debug 'cmake -DCMAKE_BUILD_TYPE=Debug ../.. && cmake --build .'
    abbr cmake-release 'cmake -DCMAKE_BUILD_TYPE=Release ../.. && cmake --build .'
    
    # Add aliases for common ops.
    alias dotfiles='cd ~/.dotfiles'
    alias dev-rust='cd ~/dev/project/rust'
    alias dev-java='cd ~/dev/project/java'
    alias dev-elixir='cd ~/dev/project/elixir'
    alias dev-c='cd ~/dev/project/cc++'

    # OPAM config
    test -r '/home/cem/.opam/opam-init/init.fish' && source '/home/cem/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true

    function change_timezone
        set zone $argv[1]
        sudo timedatectl set-timezone $zone && echo -e "Time zone has been changed to \"$zone\"."
    end

    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

end
