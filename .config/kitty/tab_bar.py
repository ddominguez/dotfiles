# pyright: reportMissingImports=false

from kitty.fast_data_types import Screen, get_options, get_boss
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    TabBarData,
    as_rgb,
    draw_tab_with_separator,
)


def _draw_right_status(screen: Screen, is_last: bool) -> int | None:
    if not is_last:
        return

    opts = get_options()

    wm_class = f"[{get_boss().active_tab_manager.wm_class}]"
    right_status_length = len(wm_class)

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
    max_tab_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    end = draw_tab_with_separator(
        draw_data, screen, tab, before, max_tab_length, index, is_last, extra_data
    )

    _draw_right_status(screen, is_last)
    return end
