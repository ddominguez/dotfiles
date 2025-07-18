# pyright: reportMissingImports=false

from kitty.fast_data_types import Screen, get_options, get_boss
from kitty.tab_bar import DrawData, ExtraData, TabBarData, as_rgb, draw_title
from kitty.utils import color_as_int


def calc_draw_spaces(*args) -> int:
    length = 0
    for i in args:
        if not isinstance(i, str):
            i = str(i)
        length += len(i)
    return length


def _draw_left_status(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    if draw_data.leading_spaces:
        screen.draw(" " * draw_data.leading_spaces)

    draw_title(draw_data, screen, tab, index)
    trailing_spaces = min(max_title_length - 1, draw_data.trailing_spaces)
    max_title_length -= trailing_spaces
    extra = screen.cursor.x - before - max_title_length

    if extra > 0:
        screen.cursor.x -= extra + 1
        screen.draw("…")

    if trailing_spaces:
        screen.draw(" " * trailing_spaces)

    end = screen.cursor.x
    screen.cursor.bold = screen.cursor.italic = False
    screen.cursor.fg = 0

    if not is_last:
        screen.cursor.bg = as_rgb(color_as_int(draw_data.inactive_bg))
        screen.draw(draw_data.sep)

    screen.cursor.bg = 0
    return end


def _draw_right_status(screen: Screen, is_last: bool) -> int:
    if not is_last:
        return

    opts = get_options()

    wm_class = f"[{get_boss().active_tab_manager.wm_class}]"

    right_status_length = calc_draw_spaces(wm_class)

    draw_spaces = screen.columns - screen.cursor.x - right_status_length
    if draw_spaces > 0:
        screen.draw(" " * draw_spaces)

    fg, bg = screen.cursor.fg, screen.cursor.bg
    screen.cursor.fg = as_rgb(opts.color_table[5])
    screen.draw(wm_class)

    screen.cursor.fg = fg
    screen.cursor.bg = bg

    if screen.columns - screen.cursor.x > right_status_length:
        screen.cursor.x = screen.columns - right_status_length

    return screen.cursor.x


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    _draw_left_status(
        draw_data,
        screen,
        tab,
        before,
        max_title_length,
        index,
        is_last,
        extra_data,
    )

    # Set cursor to where `left_status` ends, instead `right_status`, to enable `open new tab` feature
    end = screen.cursor.x

    _draw_right_status(
        screen,
        is_last,
    )
    return end
