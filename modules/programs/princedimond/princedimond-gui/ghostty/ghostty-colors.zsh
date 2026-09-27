# ghostty-colors.zsh — Auto-tint Ghostty tabs by project or SSH host
#
# Projects under ~/git/ get cool-toned background tints.
# SSH sessions get warm-toned tints. Colors are deterministic:
# the same project/host always gets the same color.
#
# Only activates inside Ghostty.

# Activate in Ghostty (local) or any capable terminal (remote/SSH)
case "$TERM" in
  xterm-ghostty|xterm*|screen*|tmux*) ;;
  *) [[ -z "$GHOSTTY_RESOURCES_DIR" ]] && return ;;
esac

# ---------------------------------------------------------------------------
# Palette — subtle dark tints that pair well with Dracula
# ---------------------------------------------------------------------------

# Cool tones for local projects
typeset -a _GTC_PROJECT_COLORS=(
  "#1e2535"  # slate blue
  "#1e2d2d"  # deep teal
  "#261e35"  # plum
  "#1e3526"  # forest
  "#2d1e2d"  # mauve
  "#1e2d35"  # steel
  "#2d2d1e"  # olive
  "#1e352d"  # sea green
  "#2d1e35"  # violet
  "#1e3535"  # cyan
  "#241e35"  # indigo
  "#1e3530"  # jade
)

# Warm tones for SSH hosts
typeset -a _GTC_SSH_COLORS=(
  "#352222"  # brick
  "#352d1e"  # amber
  "#35261e"  # burnt orange
  "#2d2222"  # rosewood
  "#352c1e"  # golden brown
  "#2d1e1e"  # dark cherry
  "#352d24"  # copper
  "#351e1e"  # deep red
)

_GTC_DEFAULT_BG="#282a36"  # Dracula default

# Colored circle emojis — indexed by hash to visually match the tint
typeset -a _GTC_SSH_DOTS=(    🔥 🍊 🌅 🌹 🌻 🍒 🥧 ♦️ )

# Track current context so precmd can re-assert the title
_GTC_CURRENT_TITLE=""
_GTC_SSH_ACTIVE=""

# ---------------------------------------------------------------------------
# Internals
# ---------------------------------------------------------------------------

_gtc_hash() {
  local s="$1" h=0 i
  for (( i=0; i<${#s}; i++ )); do
    h=$(( (h * 31 + $(printf '%d' "'${s:$i:1}")) % 65536 ))
  done
  echo $h
}

# Shorten ~/git/foo/bar/baz → foo/bar/baz ; ~/other → ~/other
_gtc_short_cwd() {
  if [[ "$PWD" == "$HOME/git/"* ]]; then
    echo "${PWD#$HOME/git/}"
  elif [[ "$PWD" == "$HOME"* ]]; then
    echo "~${PWD#$HOME}"
  else
    echo "$PWD"
  fi
}

_gtc_set() {
  printf '\033]11;%s\007' "$1"
  printf '\033]2;%s\007' "$2"
  _GTC_CURRENT_TITLE="$2"
}

# Prefix for tab titles — includes hostname when in an SSH session
if [[ -n "$SSH_CONNECTION" ]]; then
  _GTC_HOST_PREFIX="${HOST%%.*}: "
else
  _GTC_HOST_PREFIX=""
fi

_gtc_reset() {
  local title="${_GTC_HOST_PREFIX}$(_gtc_short_cwd)"
  printf '\033]11;%s\007' "$_GTC_DEFAULT_BG"
  printf '\033]2;%s\007' "$title"
  _GTC_CURRENT_TITLE="$title"
}

# ---------------------------------------------------------------------------
# precmd — re-assert title before every prompt so running programs
# (gh copilot, etc.) can't permanently overwrite it
# ---------------------------------------------------------------------------

_gtc_precmd() {
  [[ -n "$_GTC_CURRENT_TITLE" ]] && printf '\033]2;%s\007' "$_GTC_CURRENT_TITLE"
}

# ---------------------------------------------------------------------------
# SSH coloring — wraps ssh to tint before connect, restore after
# ---------------------------------------------------------------------------

ssh() {
  local host="" skip=false arg
  for arg in "$@"; do
    if $skip; then skip=false; continue; fi
    case "$arg" in
      -[bcDEeFIiJLlmOopQRSWw]) skip=true ;;
      -*) ;;
      *@*) host="${arg#*@}"; break ;;
      *)   [[ -z "$host" ]] && host="$arg"; break ;;
    esac
  done

  if [[ -n "$host" ]]; then
    local short="${host%%.*}"
    local idx=$(( $(_gtc_hash "$short") % ${#_GTC_SSH_COLORS[@]} + 1 ))
    local dot="${_GTC_SSH_DOTS[$idx]}"
    _GTC_SSH_ACTIVE="$short"
    _gtc_set "${_GTC_SSH_COLORS[$idx]}" "$dot $short"
  fi

  command ssh "$@"
  local ret=$?
  _GTC_SSH_ACTIVE=""
  return $ret
}

# ---------------------------------------------------------------------------
# Hook registration + initial apply
# ---------------------------------------------------------------------------

autoload -Uz add-zsh-hook
add-zsh-hook precmd _gtc_precmd
