function yt --description "Smart yt-dlp wrapper"
    if test (count $argv) -eq 0
        echo "Usage: yt <url> [format_code]"
        return 1
    end

    set -l url (string trim $argv[1])
    set -l format_code $argv[2]
    
    # --- Cookie Logic ---
    set -l cookie_arg
    if test -f ~/.config/yt-dlp/cookies.txt
        set cookie_arg --cookies ~/.config/yt-dlp/cookies.txt
    else if test -d ~/.var/app/org.mozilla.firefox/.mozilla/firefox
        set cookie_arg --cookies-from-browser firefox:~/.var/app/org.mozilla.firefox/.mozilla/firefox
    else
        set cookie_arg --cookies-from-browser firefox
    end

    # --- Best Available Bypass Flags ---
    set -l bypass_flags \
        --js-runtimes node \
        --remote-components ejs:github \
        --extractor-args "youtube:player_client=mweb,tv,web;player_skip=configs" \
        --user-agent "Mozilla/5.0 (iPhone; CPU iPhone OS 17_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4.1 Mobile/15E148 Safari/604.1" \
        --no-playlist \
        --write-subs \
        --write-auto-subs \
        --sub-langs "en.*" \
        --embed-subs \
        --embed-thumbnail \
        --add-metadata \
        --merge-output-format mkv \
        --output "%(title).200s [%(id)s].%(ext)s"

    if test -n "$format_code"
        set -l f_sel
        switch $format_code
            case audio; set f_sel -f "bestaudio/best" --extract-audio --audio-format mp3
            case best;  set f_sel -f "bestvideo+bestaudio/best"
            case video; set f_sel -f "bestvideo/best"
            case '*';   set f_sel -f "$format_code+bestaudio/best"
        end
        
        echo "🚀 Downloading $url..."
        yt-dlp $cookie_arg $bypass_flags $f_sel "$url"
    else
        echo "🔍 Fetching formats for $url..."
        yt-dlp $cookie_arg $bypass_flags -F "$url"
        
        echo ""
        echo "─────────────────────────────────────────"
        read -P "Format (best/audio/video/ID): " choice
        
        if test -z "$choice"; return 1; end

        set -l f_sel
        switch $choice
            case audio; set f_sel -f "bestaudio/best" --extract-audio --audio-format mp3
            case best;  set f_sel -f "bestvideo+bestaudio/best"
            case video; set f_sel -f "bestvideo/best"
            case '*';   set f_sel -f "$choice+bestaudio/best"
        end

        echo "🚀 Downloading..."
        yt-dlp $cookie_arg $bypass_flags $f_sel "$url"
    end
end
