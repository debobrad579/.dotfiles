config = config
c = c

config.load_autoconfig(False)

config.bind("<Space>s", "config-source")
config.bind("s", "search . ;; clear-keychain ;; search ;; fullscreen --leave")
config.bind("<Space>f", "fake-key f")
config.bind("<Space>t", "config-cycle tabs.show always switching")

c.tabs.position = "left"
c.tabs.width = 200

c.content.blocking.enabled = False

c.auto_save.session = True

c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "goog": "https://www.google.com/search?q={}",
    "aw": "https://wiki.archlinux.org/?search={}",
    "yt": "https://www.youtube.com/results?search_query={}",
}

config.source("themes/onedark.py")
