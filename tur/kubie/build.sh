TERMUX_PKG_HOMEPAGE=https://github.com/sbstp/kubie
TERMUX_PKG_DESCRIPTION="A more powerful alternative to kubectx and kubens"
TERMUX_PKG_LICENSE="ZLIB"
TERMUX_PKG_LICENSE_FILE="LICENSE"
TERMUX_PKG_MAINTAINER="@idj0"
TERMUX_PKG_VERSION=0.23.0
TERMUX_PKG_SRCURL=https://github.com/sbstp/kubie/archive/refs/tags/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=e6722811998ca497edd365e27d96c7f672221ffb5d7fd59ec9fbf181831b01f8
TERMUX_PKG_DEPENDS="pacman, kubectl, binutils, ncurses"
TERMUX_PKG_BUILD_DEPENDS="rust"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_TAG_TYPE="newest-tag"

termux_step_make() {
    termux_setup_rust
    cargo build --release \
        --jobs $TERMUX_MAKE_PROCESSES \
        --target $CARGO_TARGET_NAME
}

termux_step_make_install() {
    install -Dm700 $TERMUX_PKG_SRCDIR/target/$CARGO_TARGET_NAME/release/$TERMUX_PKG_NAME \
        -t "$TERMUX_PREFIX/bin/$TERMUX_PKG_NAME"
}

termux_step_post_make_install() {
    install -Dm600 $TERMUX_PKG_SRCDIR/completion/kubie.bash \
        -t ${TERMUX_PREFIX}/share/bash-completions/completions/kubie
    install -Dm600 $TERMUX_PKG_SRCDIR/completion/kubie.fish \
        -t ${TERMUX_PREFIX}/share/fish/vendor_completions.d/kubie.fish
}
